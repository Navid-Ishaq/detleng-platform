# DeTLeng Platform deployment

## Why GitHub Pages returns 404

GitHub Pages is a static-file host. A request to `https://platform.detleng.com/airflow/` is handled by GitHub Pages as a lookup for a static `airflow/index.html`. It cannot start containers, proxy HTTP to Airflow or pgAdmin, connect to PostgreSQL, or run dbt. DNS also cannot send different URL paths on one hostname to different servers.

The same-origin production URLs therefore require `platform.detleng.com` to terminate at a real server-side proxy. The recommended production design is:

```text
Internet
  -> platform.detleng.com (DNS A/AAAA)
  -> Caddy on VM/VPS (ports 80/443)
       -> /              static frontend
       -> /airflow/      private Airflow API server
       -> /postgresql/   private pgAdmin container -> private PostgreSQL
       -> /dbt/          generated static dbt documentation
```

The GitHub repository remains the source and CI/CD origin; GitHub Pages is no longer the runtime for the custom domain.

## Local development

1. Copy `.env.example` to `.env`.
2. Set both passwords, the local Airflow/dbt executable paths when needed, and the real dbt project path.
3. Configure/restart Airflow with:

   ```text
   AIRFLOW__API__BASE_URL=http://localhost:8088/airflow
   AIRFLOW__CORE__EXECUTION_API_SERVER_URL=http://localhost:8088/airflow/execution/
   FORWARDED_ALLOW_IPS=*
   airflow api-server --proxy-headers
   ```

4. Generate dbt docs: `powershell -ExecutionPolicy Bypass -File scripts/generate-dbt-docs.ps1`.
5. Start: `powershell -ExecutionPolicy Bypass -File scripts/start-platform.ps1`.
6. Verify: `powershell -ExecutionPolicy Bypass -File scripts/test-routes.ps1`.
7. Open `http://localhost:8088/dashboard.html`.

## Recommended production deployment

1. Provision a Linux VM/VPS with Docker Engine and Compose. Allow inbound TCP 80 and 443 only; keep 5432 and 8080 private.
2. Clone this repository onto the server.
3. Copy `.env.production.example` to `.env`, replace all placeholder secrets, and set `AIRFLOW_UPSTREAM` to an Airflow address reachable only from the Docker network/host.
4. Configure Airflow with:

   ```text
   AIRFLOW__API__BASE_URL=https://platform.detleng.com/airflow
   AIRFLOW__CORE__EXECUTION_API_SERVER_URL=https://platform.detleng.com/airflow/execution/
   airflow api-server --proxy-headers
   ```

5. Generate dbt documentation during deployment. The generated `backend/dbt/site` directory must contain at least `index.html`, `manifest.json`, and `catalog.json` before Caddy starts.
6. Change the DNS for `platform.detleng.com` from the GitHub Pages target to A/AAAA records for the VM. Remove the GitHub Pages custom-domain setting (and then remove `CNAME` from the Pages publishing branch) during the cutover.
7. Run `docker compose up -d`. With `PLATFORM_ADDRESS=platform.detleng.com`, Caddy obtains and renews HTTPS certificates automatically.
8. Run `scripts/test-routes.ps1 -BaseUrl https://platform.detleng.com` from a trusted administration machine.

Do not expose pgAdmin publicly without strong credentials and an additional access policy such as a VPN, IP allowlist, or identity-aware proxy.

## Alternative: retain GitHub Pages

If GitHub Pages must continue serving `platform.detleng.com`, deploy Caddy/backend services at another hostname such as `services.detleng.com`. Set `PLATFORM_ADDRESS=services.detleng.com` on that server and set `backendOrigin` in `js/config.js` to `https://services.detleng.com` before publishing Pages.

The buttons will then open `https://services.detleng.com/airflow/`, `/postgresql/`, and `/dbt/`. They cannot remain at `https://platform.detleng.com/...` unless a server-side proxy/CDN sits in front of GitHub Pages and routes those paths to the backend.
