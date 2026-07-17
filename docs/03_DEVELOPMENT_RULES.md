# 03_DEVELOPMENT_RULES.md

# DeTLeng Platform

## Development Rules

---

## Purpose

Define the implementation standards for the DeTLeng Platform.

All development must follow these rules.

---

# General Rules

- Build a platform, not a website.
- Keep the code simple and maintainable.
- Do not add features outside the documented scope.
- Follow the approved project structure.

---

# HTML

- Use semantic HTML5.
- Keep markup clean and readable.
- Use meaningful class names.
- Avoid inline styles.
- Avoid inline JavaScript.

---

# CSS

- Use a single shared stylesheet.
- Do not duplicate CSS.
- Reuse existing classes whenever possible.
- Keep styles modular and organized.

---

# JavaScript

- Use a single shared JavaScript file.
- Keep functions reusable.
- Do not duplicate logic.
- Avoid unnecessary libraries.

---

# Shared Components

The following components must remain identical across all pages:

- Navigation
- Footer
- DeTLeng Ecosystem
- Support Button

---

# Responsive Design

Support:

- Desktop
- Tablet
- Mobile

No desktop-only layouts.

---

# Navigation

- Fixed header
- Active menu highlighting
- Consistent spacing
- Consistent behavior

---

# Dashboard

The Dashboard is the operational workspace.

Cards must perform only one action:

| Module | Action |
|---------|--------|
| Apache Airflow | Launch Airflow |
| PostgreSQL | Launch PostgreSQL |
| dbt | Launch dbt |
| Dashboard Engine | Generate Excel Dashboard |
| AI Assistant | Open AI Assistant |

Do not recreate third-party applications.

---

# Support Button

Use a standard `mailto:` link.

Subject:

`DeTLeng Platform Support Request`

Email template:

- Name
- Company
- Project
- Platform Module
- Description
- Expected Outcome
- Priority
- Attachments

No backend forms.

---

# Footer

Display the same footer on every page.

Include:

- DeTLeng
- Platform
- Insights
- Case Studies
- Inteligencia
- Agents
- Support

Open external links in a new tab.

---

# Code Quality

- Reuse code.
- Avoid duplication.
- Remove unused code.
- Keep files organized.
- Write readable code.
- Keep comments concise.

---

# Future Integrations

Use placeholders until implementation is available.

Examples:

- Airflow
- PostgreSQL
- dbt
- Dashboard Engine
- AI Assistant

---

# Codex Instructions

- Follow these rules for every implementation.
- Do not introduce unnecessary frameworks.
- Do not duplicate code.
- Preserve project consistency.
- Prefer reusable solutions.

---

# Document Information

Document: 03_DEVELOPMENT_RULES.md

Version: 1.0

Status: Approved

Phase: 1
