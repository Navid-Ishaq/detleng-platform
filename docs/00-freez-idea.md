# DeTLeng Platform — Phase 1 Architecture

## Objective

Build a simple, professional, and scalable Data Engineering Platform that transforms raw datasets into clean, analytics-ready data, generates automated Excel dashboards, and provides AI-powered business insights.

---

## Platform Workflow

```text
Any Dataset
(CSV • Excel • JSON*)

        │
        ▼

Apache Airflow
(ETL Orchestration)

        │
        ▼

Data Profiling

        │
        ▼

Data Cleaning

        │
        ▼

Data Validation

        │
        ▼

Database Layer

   PostgreSQL
      OR
 Google BigQuery

        │
        ▼

dbt
(Data Transformation &
Analytics Modeling)

        │
        ▼

Analytics Layer

        │
        ▼

DeTLeng Dashboard Engine

        ├── Excel Dashboard
        ├── KPI Summary
        ├── Executive Report
        └── Data Quality Report

        │
        ▼

DeTLeng AI Assistant

        ├── Business Insights
        ├── Trend Analysis
        ├── KPI Explanation
        └── Decision Support
```

> *JSON support is planned for a future phase.

---

## Technology Stack

| Layer | Technology |
|--------|------------|
| Data Sources | CSV, Excel |
| ETL | Apache Airflow |
| Profiling | Python |
| Cleaning | Python |
| Validation | Python |
| Database | PostgreSQL / Google BigQuery |
| Transformation | dbt |
| Analytics Layer | dbt Models |
| Dashboard | Microsoft Excel (.xlsx) |
| AI | OpenAI Assistant |

---

## Phase 1 Deliverables

- Automated Dataset Ingestion
- ETL Orchestration with Airflow
- Data Profiling, Cleaning & Validation
- PostgreSQL Integration
- Google BigQuery Integration
- dbt Analytics Layer
- Automated Excel Dashboard Generation
- AI-Powered Business Insights

---

## DeTLeng Vision

> **Upload Data → Engineer Data → Generate Dashboard → Deliver AI Insights**
