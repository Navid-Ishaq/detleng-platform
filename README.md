# DeTLeng Platform

A runnable local data engineering platform integrating Apache Airflow, PostgreSQL 17, pgAdmin, dbt Core, and the existing DeTLeng frontend behind one Caddy gateway.

## Quick start

Prerequisites:

- Docker Desktop running with Docker Compose v2
- At least 4 GB of Docker memory; 8 GB is recommended for Airflow
- PowerShell 7 or Windows PowerShell 5.1
- Ports 8088 and 8443 available

Start everything:

```powershell
Copy-Item .env.example .env
.\scripts\start-platform.ps1
```

The copy step is optional: the startup script creates `.env` automatically when it is missing.

Open:

- Platform: `http://localhost:8088/`
- Dashboard: `http://localhost:8088/dashboard.html`
- Airflow: `http://localhost:8088/airflow/`
- PostgreSQL administration: `http://localhost:8088/postgresql/`
- dbt documentation: `http://localhost:8088/dbt/`

The local pgAdmin credentials and PostgreSQL password are in `.env`. The included defaults are development-only.

Default pgAdmin login:

- Email: `info@detleng.local`
- Password: `DLPlatform@2026`

## Run the data workflow

1. Place a `.csv`, `.xlsx`, or `.xls` file in `data/inbox/`. A working sample is included.
2. Open Airflow from the dashboard.
3. Trigger `detleng_dataset_to_analytics`.
4. The DAG profiles, cleans, validates, and loads the newest dataset into `raw.customer_orders` in PostgreSQL.
5. The DAG runs and tests dbt, creating `analytics.order_summary`.
6. Refresh `/dbt/` to see the updated lineage and catalog.
7. Inspect both schemas through pgAdmin.

Required input columns are `order_id`, `customer_name`, `country`, `order_date`, and `amount`. Column names are normalized to lowercase snake case before validation.

## Useful commands

```powershell
.\scripts\status-platform.ps1
.\scripts\test-routes.ps1
.\scripts\generate-dbt-docs.ps1
.\scripts\stop-platform.ps1
```

Use `.\scripts\stop-platform.ps1 -RemoveData` only when you intentionally want to delete Docker database and application volumes.

See [DEPLOYMENT.md](DEPLOYMENT.md) for architecture, troubleshooting, dependencies, and production boundaries.

## Scope

Dashboard Engine and AI Assistant backend development remain out of scope. This repository implements the operational Airflow, PostgreSQL/pgAdmin, dbt, and first dataset-to-analytics workflow only.
