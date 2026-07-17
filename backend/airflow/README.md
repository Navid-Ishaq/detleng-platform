# Apache Airflow integration

Airflow remains a host-managed installation. Caddy proxies `/airflow/` to `AIRFLOW_UPSTREAM` (default `host.docker.internal:8080`). The startup script starts `airflow standalone` only when the configured port is closed and the `airflow` command is available.

No DAGs or workflow logic are included in Phase 2.
