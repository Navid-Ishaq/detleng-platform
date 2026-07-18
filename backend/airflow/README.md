# Apache Airflow integration

Airflow remains a host-managed installation. Caddy proxies `/airflow/` to `AIRFLOW_UPSTREAM` (default `host.docker.internal:8080`) without stripping the prefix.

Airflow 3 configuration:

```text
AIRFLOW__API__BASE_URL=http://localhost:8088/airflow
AIRFLOW__CORE__EXECUTION_API_SERVER_URL=http://localhost:8088/airflow/execution/
FORWARDED_ALLOW_IPS=*
airflow api-server --proxy-headers
```

Use the production platform URL instead of localhost on the server. Restrict `FORWARDED_ALLOW_IPS` to the trusted proxy/network in production where practical. The startup script starts `airflow standalone` only when the configured port is closed and the `airflow` command is available; a separately managed Airflow process must be restarted after applying these settings.

No DAGs or workflow logic are included in Phase 2.
