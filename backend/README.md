# Backend modules

- `airflow/` contains the custom Airflow 3 image, dependencies, logs, and the operational dataset ETL DAG.
- `postgresql/` initializes separate Airflow metadata and DeTLeng application databases and pre-registers the application database in pgAdmin.
- `dbt/` contains the dbt-postgres image, analytics project, models, tests, documentation generator, and published static site.
- `dashboard-engine/` and `ai-assistant/` remain reserved for later phases.

The Compose network connects modules by service name. Caddy is the only browser-facing service.
