# dbt integration

The startup script calls the existing local `dbt` executable to generate documentation, then publishes the resulting static site at `/dbt/` through Caddy.

Set `DBT_PROJECT_DIR` and optionally `DBT_PROFILES_DIR` in `.env` to use an existing project. If `DBT_PROJECT_DIR` is blank, the empty starter project in `project/` is used. Its connection values come from the same PostgreSQL environment variables.

No models, transformations, or analytics pipeline are included in Phase 2.
