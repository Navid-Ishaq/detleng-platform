FROM apache/airflow:3.3.0

ARG AIRFLOW_VERSION=3.3.0
COPY backend/airflow/requirements.txt /requirements.txt
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" -r /requirements.txt
