# Apache Airflow

The local runtime uses Apache Airflow 3.3.0 with LocalExecutor and PostgreSQL metadata storage. Separate API server, scheduler, DAG processor, and triggerer services follow the Airflow 3 component model.

`dags/detleng_dataset_pipeline.py` implements dataset discovery, profiling, cleaning, validation, PostgreSQL loading, dbt execution/testing, and documentation refresh.

The custom image adds pandas, Excel support, PostgreSQL connectivity, and dbt-postgres. Airflow is configured for the `/airflow` proxy prefix in `compose.yaml`; Caddy preserves that prefix.
