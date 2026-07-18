#!/bin/sh
set -eu

psql --set ON_ERROR_STOP=on --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-SQL
    CREATE USER airflow WITH PASSWORD '${AIRFLOW_DB_PASSWORD}';
    CREATE DATABASE airflow OWNER airflow;
    CREATE USER detleng WITH PASSWORD '${DETLENG_DB_PASSWORD}';
    CREATE DATABASE detleng OWNER detleng;
SQL
