# PostgreSQL and pgAdmin

The platform uses PostgreSQL 17.10 inside Compose. Initialization creates:

- `airflow` database and role for Airflow metadata;
- `detleng` database and role for datasets and analytics.

pgAdmin is available only through `/postgresql/` and pre-registers the `detleng` database server. Enter the `POSTGRES_PASSWORD` value from `.env` when pgAdmin first asks for the database password.
