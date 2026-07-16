# 01_PROJECT_OVERVIEW.md

# DeTLeng Platform

## Purpose

The DeTLeng Platform is a modern Data Engineering Platform within the DeTLeng Ecosystem.

It is a working engineering platform, not an informational website.

The platform provides a single interface for launching, integrating, and demonstrating data engineering workflows.

---

# Project Vision

Provide a unified platform where users can transform raw datasets into analytics-ready data and generate business outputs through a simple workflow.

The platform focuses on:

- Data Engineering
- Analytics Engineering
- Dashboard Automation
- AI-Powered Business Insights

---

# Phase 1 Workflow

```text
Dataset
(CSV / Excel)

        │
        ▼

Apache Airflow

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

Database

• PostgreSQL
or
• Google BigQuery

        │
        ▼

dbt

        │
        ▼

Analytics Layer

        │
        ▼

DeTLeng Dashboard Engine

        │
        ▼

Excel Dashboard

        │
        ▼

AI Assistant
```

---

# Platform Structure

The platform contains only two user-facing pages.

```text
platform-detleng/

│
├── index.html
├── dashboard.html
│
├── css/
│   └── style.css
│
├── js/
│   └── app.js
│
├── images/
│
└── docs/
```

No additional HTML pages should be created unless explicitly requested.

---

# Dashboard Modules

The Dashboard is the operational control center.

Phase 1 modules:

- Apache Airflow
- PostgreSQL
- dbt
- Dashboard Engine
- AI Assistant

Each module is represented by a dashboard card.

Cards launch the real application, service, or future integration.

Do not recreate third-party applications in HTML.

---

# Dashboard Engine

The Dashboard Engine generates business outputs from the Analytics Layer.

Outputs include:

- Excel Dashboard
- KPI Summary
- Executive Report
- Data Quality Report

Future outputs may include:

- Power BI
- Looker Studio
- PDF Reports

---

# Technology Stack

- HTML5
- CSS3
- Vanilla JavaScript
- Python
- Apache Airflow
- PostgreSQL
- Google BigQuery
- dbt
- OpenAI
- Docker

---

# Branding

Use the provided branding assets only.

Logo:

- `logop.png`

Favicon:

- `faviconp.png`

Do not replace or modify branding.

---

# Development Rules

- Build a platform, not a website.
- Keep the interface simple.
- Reuse shared components.
- Do not duplicate code.
- Do not introduce unnecessary frameworks.
- Keep the project modular and maintainable.

---

# Codex Instructions

- Follow this document as the primary project specification.
- Do not redesign the architecture.
- Do not add informational pages.
- Do not recreate third-party tools.
- Implement only the defined platform structure.
- Future integrations should use placeholders until implemented.

---

# Document Information

Document: 01_PROJECT_OVERVIEW.md

Version: 2.0

Status: Approved

Phase: 1
