from __future__ import annotations

import json
import os
import re
import shutil
import subprocess
from pathlib import Path

import pandas as pd
from airflow.sdk import dag, task
from pendulum import datetime
from sqlalchemy import create_engine, text


DATA_ROOT = Path("/opt/airflow/data")
INBOX = DATA_ROOT / "inbox"
WORK = DATA_ROOT / "work"
PROFILES = DATA_ROOT / "profiles"
VALIDATION = DATA_ROOT / "validation"
REQUIRED_COLUMNS = {"order_id", "customer_name", "country", "order_date", "amount"}


def _latest_dataset() -> Path:
    candidates = [
        path for path in INBOX.iterdir()
        if path.is_file() and path.suffix.lower() in {".csv", ".xlsx", ".xls"}
    ]
    if not candidates:
        raise FileNotFoundError("Place a CSV or Excel file in data/inbox before triggering the DAG.")
    return max(candidates, key=lambda path: path.stat().st_mtime)


def _read_dataset(path: Path) -> pd.DataFrame:
    if path.suffix.lower() == ".csv":
        return pd.read_csv(path)
    return pd.read_excel(path)


def _normalise_column(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "_", str(value).strip().lower())
    return value.strip("_")


@dag(
    dag_id="detleng_dataset_to_analytics",
    description="Profile, clean, validate and load a dataset, then build the dbt analytics layer.",
    start_date=datetime(2026, 1, 1, tz="UTC"),
    schedule=None,
    catchup=False,
    tags=["detleng", "etl", "postgresql", "dbt"],
)
def dataset_pipeline():
    @task
    def discover_dataset() -> str:
        return str(_latest_dataset())

    @task
    def profile_dataset(dataset_path: str) -> str:
        path = Path(dataset_path)
        frame = _read_dataset(path)
        PROFILES.mkdir(parents=True, exist_ok=True)
        report = {
            "source_file": path.name,
            "rows": int(len(frame)),
            "columns": [str(column) for column in frame.columns],
            "null_counts": {str(key): int(value) for key, value in frame.isna().sum().items()},
            "duplicate_rows": int(frame.duplicated().sum()),
            "data_types": {str(key): str(value) for key, value in frame.dtypes.items()},
        }
        output = PROFILES / f"{path.stem}_profile.json"
        output.write_text(json.dumps(report, indent=2), encoding="utf-8")
        return str(output)

    @task
    def clean_dataset(dataset_path: str, _profile_path: str) -> str:
        source = Path(dataset_path)
        frame = _read_dataset(source)
        frame.columns = [_normalise_column(column) for column in frame.columns]
        for column in frame.select_dtypes(include="object").columns:
            frame[column] = frame[column].map(lambda value: value.strip() if isinstance(value, str) else value)
        if "order_date" in frame.columns:
            frame["order_date"] = pd.to_datetime(frame["order_date"], errors="coerce").dt.date
        if "amount" in frame.columns:
            frame["amount"] = pd.to_numeric(frame["amount"], errors="coerce")
        frame = frame.dropna(how="all").drop_duplicates()
        if "order_id" in frame.columns:
            frame = frame.drop_duplicates(subset=["order_id"], keep="last")
        WORK.mkdir(parents=True, exist_ok=True)
        output = WORK / f"{source.stem}_clean.csv"
        frame.to_csv(output, index=False)
        return str(output)

    @task
    def validate_dataset(clean_path: str) -> str:
        path = Path(clean_path)
        frame = pd.read_csv(path)
        missing_columns = sorted(REQUIRED_COLUMNS.difference(frame.columns))
        failures = []
        if frame.empty:
            failures.append("Dataset contains no valid rows.")
        if missing_columns:
            failures.append(f"Missing required columns: {', '.join(missing_columns)}")
        if not missing_columns:
            null_required = frame[list(REQUIRED_COLUMNS)].isna().sum()
            invalid = {key: int(value) for key, value in null_required.items() if value}
            if invalid:
                failures.append(f"Required-column null values: {invalid}")
            if (pd.to_numeric(frame["amount"], errors="coerce") < 0).any():
                failures.append("Negative amounts are not allowed.")
        VALIDATION.mkdir(parents=True, exist_ok=True)
        report = {"valid": not failures, "rows": int(len(frame)), "failures": failures}
        output = VALIDATION / f"{path.stem}_validation.json"
        output.write_text(json.dumps(report, indent=2), encoding="utf-8")
        if failures:
            raise ValueError("; ".join(failures))
        return clean_path

    @task
    def load_postgresql(clean_path: str) -> int:
        frame = pd.read_csv(clean_path, parse_dates=["order_date"])
        database_url = os.environ["PLATFORM_DATABASE_URL"]
        engine = create_engine(database_url)
        with engine.begin() as connection:
            connection.execute(text("create schema if not exists raw"))
        frame.to_sql("customer_orders", engine, schema="raw", if_exists="replace", index=False, method="multi")
        return int(len(frame))

    @task
    def build_analytics_layer(_loaded_rows: int) -> str:
        project = Path("/opt/airflow/dbt")
        staging = Path("/opt/airflow/dbt-site-staging")
        published = Path("/opt/airflow/dbt-site")
        subprocess.run(["dbt", "run", "--project-dir", str(project), "--profiles-dir", str(project)], check=True)
        subprocess.run(["dbt", "test", "--project-dir", str(project), "--profiles-dir", str(project)], check=True)
        if staging.exists():
            shutil.rmtree(staging)
        subprocess.run([
            "dbt", "docs", "generate", "--project-dir", str(project), "--profiles-dir", str(project),
            "--target-path", str(staging),
        ], check=True)
        published.mkdir(parents=True, exist_ok=True)
        for item in published.iterdir():
            if item.name != ".gitkeep":
                shutil.rmtree(item) if item.is_dir() else item.unlink()
        for item in staging.iterdir():
            shutil.move(str(item), published / item.name)
        shutil.rmtree(staging)
        return "analytics.order_summary"

    source_path = discover_dataset()
    profile_path = profile_dataset(source_path)
    cleaned_path = clean_dataset(source_path, profile_path)
    validated_path = validate_dataset(cleaned_path)
    loaded_rows = load_postgresql(validated_path)
    build_analytics_layer(loaded_rows)


dataset_pipeline()
