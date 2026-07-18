FROM python:3.12-slim

RUN apt-get update \
    && apt-get install --yes --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/* \
    && git --version
RUN pip install --no-cache-dir dbt-postgres==1.11.0
WORKDIR /usr/app/dbt
COPY backend/dbt/entrypoint.sh /usr/local/bin/detleng-dbt-docs
RUN chmod +x /usr/local/bin/detleng-dbt-docs
ENTRYPOINT ["detleng-dbt-docs"]
