# 03_PLATFORM_ARCHITECTURE.md

# DeTLeng Platform

## Platform Architecture

---

## Purpose

This document defines the operational architecture of the DeTLeng Platform.

The platform consists of a single Dashboard that launches engineering modules and future integrations.

---

# Platform Structure

```text
index.html

        │

        ▼

dashboard.html

        │

        ├── Apache Airflow
        ├── PostgreSQL
        ├── dbt
        ├── Dashboard Engine
        └── AI Assistant
```

---

# Platform Modules

## Apache Airflow

Purpose

Launch Apache Airflow.

Target

`/airflow`

Status

Future Reverse Proxy

---

## PostgreSQL

Purpose

Launch PostgreSQL administration interface.

Target

`/postgresql`

Status

Future Integration

---

## dbt

Purpose

Launch dbt documentation and analytics workspace.

Target

`/dbt`

Status

Future Integration

---

## Dashboard Engine

Purpose

Generate automated business dashboards.

Outputs

- Excel Dashboard
- KPI Summary
- Executive Report
- Data Quality Report

Status

Phase 1

---

## AI Assistant

Purpose

Open the existing AI Assistant.

Target

https://casestudy.detleng.com/

Status

Operational

Future

Dataset-specific AI Assistants.

---

# Architecture Principle

The Dashboard is the platform control center.

Third-party applications must not be recreated.

Dashboard cards launch the original application, service, or integration.

---

# Future Integrations

- Reverse Proxy
- Docker
- Nginx
- Authentication
- User Workspaces
- Cloud Deployment
- Monitoring
- Logging
- Notifications

---

# Document Information

Document

03_PLATFORM_ARCHITECTURE.md

Version

2.0

Status

Approved

Phase

1
