# 04_PAGE_SPECIFICATIONS.md

# DeTLeng Platform

## Page Specifications

---

## Purpose

Define the required layout for each platform page.

Only two user-facing pages exist.

- Home
- Dashboard

No additional HTML pages should be created.

---

# Home

```text
Navigation

↓

Hero Section

↓

Platform Overview

↓

Platform Workflow

↓

Technology Stack

↓

Call To Action

↓

DeTLeng Ecosystem

↓

Footer

↓

Support Button
```

Purpose

Introduce the platform and direct users to the Dashboard.

---

# Dashboard

```text
Navigation

↓

Platform Status

↓

Module Cards

    • Apache Airflow
    • PostgreSQL
    • dbt
    • Dashboard Engine
    • AI Assistant

↓

DeTLeng Ecosystem

↓

Footer

↓

Support Button
```

Purpose

Serve as the operational control center.

Each card launches its associated module or future integration.

---

# Dashboard Card Actions

| Module | Action |
|---------|--------|
| Apache Airflow | Launch Airflow |
| PostgreSQL | Launch PostgreSQL Interface |
| dbt | Launch dbt Workspace |
| Dashboard Engine | Generate Excel Dashboard |
| AI Assistant | Open Existing AI Assistant |

---

# Design Rules

- Fixed navigation
- Responsive layout
- Shared footer
- Shared ecosystem section
- Shared support button
- Consistent spacing
- Consistent branding

---

# Codex Instructions

- Build only the layouts defined above.
- Do not add additional sections.
- Do not create additional HTML pages.
- Keep both pages lightweight, consistent, and modular.

---

# Document Information

Document

04_PAGE_SPECIFICATIONS.md

Version

2.0

Status

Approved

Phase

1
