# 02_UI_UX_STANDARDS.md

# DeTLeng Platform

## UI / UX Standards

---

# Purpose

Define the official UI and UX standards for the DeTLeng Platform.

The platform must appear as a single professional engineering application.

---

# Platform Pages

The platform contains only two pages.

```text
index.html
dashboard.html
```

No additional HTML pages should be created unless explicitly requested.

---

# Branding

Use only the official DeTLeng branding.

Logo

`logop.png`

Favicon

`faviconp.png`

Branding must remain identical across the platform.

---

# Global Layout

Every page must follow this layout.

```text
Fixed Navigation

↓

Page Content

↓

Footer

↓

Support Button

↓

Shared JavaScript
```

---

# Navigation

Navigation must remain identical on every page.

Menu:

- Home
- Dashboard

The active page must always be highlighted.

Navigation requirements:

- Fixed Top
- Responsive
- Mobile Menu
- Hover Effect
- Active Menu Highlight

---

# Dashboard

The Dashboard is the platform control center.

It contains only operational modules.

Modules:

- Apache Airflow
- PostgreSQL
- dbt
- Dashboard Engine
- AI Assistant

Each module is displayed as a professional dashboard card.

---

# Dashboard Cards

## Apache Airflow

Purpose

Launch Apache Airflow.

Target

`/airflow`

Future implementation will use a reverse proxy.

---

## PostgreSQL

Purpose

Launch PostgreSQL administration interface.

Target

`/postgresql`

Future implementation may use pgAdmin or an equivalent interface.

---

## dbt

Purpose

Launch the dbt documentation or analytics workspace.

Target

`/dbt`

---

## Dashboard Engine

Purpose

Generate an automated Excel dashboard from the Analytics Layer.

Output:

- Excel Dashboard
- KPI Summary
- Executive Report
- Data Quality Report

Button:

**Generate Dashboard**

---

## AI Assistant

Purpose

Open the existing AI Assistant.

Target:

https://casestudy.detleng.com/

This module will be customized in future phases.

---

# UI Standards

Font

- Segoe UI
- Arial
- sans-serif

Responsive

- Desktop
- Tablet
- Mobile

Cards

- Rounded Corners
- Soft Shadow
- Consistent Padding
- Consistent Spacing

Buttons

- Blue Primary
- Hover Effect
- Active State
- Border Radius: 12px
- Transition: 0.2s

Animations should remain minimal.

---

# Color Palette

Primary

DeTLeng Blue

Accent

Golden Yellow

Background

White

Secondary Background

Light Gray

Text

Dark Gray

---

# Footer

Every page must display the official DeTLeng Ecosystem.

| Platform | URL |
|----------|-----|
| DeTLeng | https://www.detleng.com |
| Insights | https://insights.detleng.com |
| Case Studies | https://casestudy.detleng.com |
| Inteligencia | https://inteligencia.detleng.com |
| Agents | https://agents.detleng.com |

All external links must open in a new tab.

The footer must remain identical across the platform.

---

# Support Button

Every page must include a floating Support button.

Action:

Open the user's default email client using a `mailto:` link.

The email template should include:

- Name
- Project Type
- Project Description
- Data Source
- Expected Outcome
- Deadline
- Additional Requirements

No backend processing.

No contact forms.

---

# Shared Resources

Use shared resources whenever possible.

```text
css/style.css

js/app.js

images/

Shared Navigation

Shared Footer

Shared Support Button
```

Avoid code duplication.

---

# Design Principles

- Build a platform, not a website.
- Keep the interface clean.
- Keep navigation minimal.
- Prioritize usability over decoration.
- Maintain consistent branding.
- Maintain consistent spacing.
- Keep HTML, CSS, and JavaScript modular.

---

# Codex Instructions

- Follow these UI standards exactly.
- Do not redesign the interface.
- Do not create additional informational pages.
- Do not recreate third-party applications.
- Dashboard cards must launch the appropriate module or future integration.
- Preserve branding and visual consistency.

---

# Document Information

Document: 02_UI_UX_STANDARDS.md

Version: 2.0

Status: Approved

Phase: 1
