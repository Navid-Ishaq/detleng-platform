# dbt integration

The startup script calls the existing local `dbt` executable to generate documentation, then publishes the resulting static site at `/dbt/` through Caddy. Run `scripts/generate-dbt-docs.ps1` whenever the dbt manifest or catalog changes.

Set `DBT_PROJECT_DIR` and optionally `DBT_PROFILES_DIR` in `.env` to use an existing project. If `DBT_PROJECT_DIR` is blank, the empty starter project in `project/` is used. Its connection values come from the same PostgreSQL environment variables.

`DBT_POSTGRES_HOST` defaults to `localhost` because dbt runs on the host. `POSTGRES_HOST=host.docker.internal` is reserved for containers such as pgAdmin. Generated files are staged before replacing `backend/dbt/site`, so a failed generation does not erase the last working documentation site.

No models, transformations, or analytics pipeline are included in Phase 2.
