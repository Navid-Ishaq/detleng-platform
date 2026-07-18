# DeTLeng local platform deployment

## Architecture

```text
Browser -> http://localhost:8088 -> Caddy
  |-- /airflow/      -> Airflow 3 API server
  |                       |-- scheduler
  |                       |-- DAG processor
  |                       `-- triggerer
  |-- /postgresql/  -> pgAdmin -> PostgreSQL 17
  |-- /dbt/          -> long-running dbt documentation service
  `-- /              -> existing frontend

data/inbox -> Airflow DAG -> raw.customer_orders
                              -> dbt run/test
                              -> analytics.order_summary
                              -> regenerated dbt documentation
```

All application services communicate on the private Compose network. Only Caddy publishes browser ports. PostgreSQL and Airflow are not exposed directly on host ports.

## Dependencies

Required on the host:

- Docker Desktop or Docker Engine
- Docker Compose v2.14 or newer
- 4 GB minimum Docker memory, 8 GB recommended
- PowerShell for the convenience scripts
- Internet access on the first build to pull images and Python packages
- Free host ports 8088 and 8443

Not required on the host:

- Python
- Airflow
- PostgreSQL
- pgAdmin
- dbt
- Caddy

These are provided by pinned container images or repository Dockerfiles. Git is installed inside the dbt image because dbt validates it as a required dependency.

## First start

```powershell
git clone <repository-url>
cd detleng-platform-main
Copy-Item .env.example .env
.\scripts\start-platform.ps1
```

The first build can take several minutes. The script waits for all four gateway checks before reporting success.

Verify independently:

```powershell
.\scripts\test-routes.ps1
docker compose ps
```

Expected routes:

| Module | URL | Expected |
|---|---|---|
| Airflow | `http://localhost:8088/airflow/` | Airflow UI, no blank screen |
| PostgreSQL | `http://localhost:8088/postgresql/` | pgAdmin login/application |
| dbt | `http://localhost:8088/dbt/` | dbt documentation site; `dbt-docs` remains Up and healthy |

## Airflow reverse proxy configuration

Airflow 3 receives these values from Compose:

```text
AIRFLOW__API__BASE_URL=http://localhost:8088/airflow
AIRFLOW__CORE__EXECUTION_API_SERVER_URL=http://airflow-api-server:8080/airflow/execution/
FORWARDED_ALLOW_IPS=*
airflow api-server --proxy-headers
```

Caddy uses `handle /airflow/*`, not `handle_path`, because Airflow must receive its `/airflow` prefix unchanged. Local authentication uses Airflow's development-only Simple Auth all-admin mode.

## Dataset pipeline

The `detleng_dataset_to_analytics` DAG processes the newest supported file in `data/inbox`:

1. Discover CSV/Excel dataset.
2. Write a JSON profile to `data/profiles`.
3. Normalize columns, trim strings, parse dates and amounts, remove empty/duplicate rows.
4. Validate required columns, nulls, row count, and non-negative amounts; write results to `data/validation`.
5. Replace `raw.customer_orders` in the `detleng` database.
6. Run and test dbt.
7. Publish regenerated dbt documentation.

Clean intermediate CSV files are written to `data/work`.

## Credentials

Local defaults are stored in `.env.example` so a new clone can run without interactive secret generation. They are not safe for shared environments. Before any remote deployment:

- pgAdmin development email: `info@detleng.com`;
- pgAdmin development password: `DLPlatform@2026`;

- replace every database and pgAdmin password;
- generate a strong Airflow API secret and Fernet key;
- generate a shared Airflow JWT secret for the API server and scheduler;
- replace Simple Auth with an appropriate authentication manager;
- use Docker secrets or a managed secret store;
- add backups and monitoring;
- restrict pgAdmin with VPN, IP allowlisting, or an identity-aware proxy.

Changing PostgreSQL initialization credentials after the data volume exists does not rewrite existing roles. For a clean local reset, run `scripts/stop-platform.ps1 -RemoveData`, then start again. This permanently deletes local platform data.

## Troubleshooting

Airflow blank page or incorrect redirects:

```powershell
docker compose logs airflow-api-server
docker compose exec airflow-api-server airflow config get-value api base_url
```

The printed base URL must be `http://localhost:8088/airflow`.

dbt returns 404 or the container exits:

```powershell
docker compose logs dbt-docs
docker compose exec dbt-docs git --version
.\scripts\generate-dbt-docs.ps1
Test-Path backend\dbt\site\index.html
```

pgAdmin cannot connect:

```powershell
docker compose ps postgres pgadmin
docker compose logs postgres pgadmin
```

Use server `postgres`, database `detleng`, user `detleng`, and the `POSTGRES_PASSWORD` value from `.env`.

## Production boundary

This Compose stack is designed for local development. GitHub Pages cannot run these backend services because it is a static host. Production requires a VM, container platform, or Kubernetes deployment where Caddy or another reverse proxy can reach Airflow, pgAdmin, PostgreSQL, and the generated dbt site. Do not expose ports 5432 or 8080 publicly.
