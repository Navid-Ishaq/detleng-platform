#!/bin/sh
set -eu

generate_docs() {
  git --version
  dbt debug --project-dir /usr/app/dbt --profiles-dir /usr/app/dbt
  dbt parse --project-dir /usr/app/dbt --profiles-dir /usr/app/dbt
  rm -rf /usr/app/site-staging
  dbt docs generate \
    --project-dir /usr/app/dbt \
    --profiles-dir /usr/app/dbt \
    --target-path /usr/app/site-staging

  find /usr/app/site -mindepth 1 ! -name .gitkeep -exec rm -rf {} +
  cp -R /usr/app/site-staging/. /usr/app/site/
  test -f /usr/app/site/index.html
}

case "${1:-serve}" in
  generate-only)
    generate_docs
    ;;
  serve)
    generate_docs
    exec python -m http.server 8080 --bind 0.0.0.0 --directory /usr/app/site
    ;;
  *)
    exec "$@"
    ;;
esac
