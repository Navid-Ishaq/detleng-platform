# dbt

The dbt image uses dbt-postgres 1.11.0 and includes Git as a required runtime dependency. On startup it validates Git and database connectivity, parses the project, generates documentation, publishes it to `site/`, and remains running as the documentation HTTP service. Caddy proxies `/dbt/` to this healthy service.

The Airflow DAG subsequently runs and tests `analytics.order_summary`, then refreshes the published documentation. The model aggregates validated `raw.customer_orders` data by country.

Run `scripts/generate-dbt-docs.ps1` to refresh documentation independently of the DAG.
