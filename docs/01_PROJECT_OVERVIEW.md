# 01_PROJECT_OVERVIEW.md

# DeTLeng Platform

## Project Overview

---

## Purpose

The DeTLeng Platform is a modern Data Engineering Platform developed as part of the DeTLeng Ecosystem.

Unlike a traditional informational website, this project is an interactive platform that brings together multiple data engineering technologies under a single interface.

The primary goal is to provide a centralized environment for building, managing, monitoring, and demonstrating modern data engineering workflows.

This platform is initially designed for internal use, experimentation, demonstrations, research, learning, and innovation. Future versions may support external users, authentication, and client-specific workspaces.

---

# Project Vision

The DeTLeng Platform aims to become a unified workspace where modern data engineering tools work together seamlessly.

Instead of visiting multiple applications separately, users should be able to access everything from one platform.

Examples include:

- Apache Airflow
- Google BigQuery
- dbt
- SQL Workspace
- Dataset Browser
- Documentation
- AI Assistant
- Monitoring
- Future Data Engineering Modules

The platform should provide one consistent experience regardless of which module is currently being used.

---

# Project Philosophy

This project is NOT intended to be a traditional marketing website.

It is a working engineering platform.

Every page should either:

- perform a platform function,
- launch an engineering tool,
- display useful engineering information,
- or prepare for future functionality.

Static informational pages should be kept to an absolute minimum.

---

# Project Objectives

The platform should:

- provide a professional engineering interface
- demonstrate real-world data engineering workflows
- integrate multiple engineering technologies
- simplify engineering demonstrations
- provide reusable engineering components
- support future cloud deployment
- support future authentication
- support future multi-user environments
- support future AI integration

---

# Phase 1 Scope

Phase 1 focuses on building the platform foundation.

Deliverables include:

- Complete platform navigation
- Shared UI components
- Responsive interface
- Standardized page layout
- Placeholder modules
- Professional branding
- Shared footer
- Support system
- Documentation framework

Actual integrations may be replaced with placeholders where implementation is planned for later phases.

---

# Future Phases

Future development may include:

- Apache Airflow Integration
- Reverse Proxy Configuration
- BigQuery Browser
- dbt Integration
- AI Assistant
- Monitoring Dashboard
- User Authentication
- Client Workspaces
- Administration Panel
- API Services
- Logging
- Notifications
- Usage Analytics

These items are outside the scope of Phase 1.

---

# Technology Stack

The initial implementation should prioritize simplicity.

Current stack:

- HTML5
- CSS3
- Vanilla JavaScript

No frontend frameworks should be introduced unless explicitly requested.

Future backend technologies may include:

- Python
- FastAPI
- Apache Airflow
- Docker
- Nginx
- Google BigQuery
- dbt
- Cloud Services

These technologies should only be integrated when implementation begins.

---

# Repository Structure

The repository should remain clean, modular, and maintainable.

Typical structure:

/
assets/
css/
js/
images/
pages/
components/
docs/

Future folders may be added as implementation progresses.

---

# Branding

The platform is part of the DeTLeng Ecosystem.

Brand identity must remain consistent across all pages.

Use the provided:

- logo
- favicon

Do not replace branding assets.

---

# UI Philosophy

Every page must look like part of the same application.

Consistency is more important than visual complexity.

Users should immediately recognize they are inside the DeTLeng Platform.

---

# Platform Navigation

Navigation represents platform modules rather than informational pages.

Menu items may include:

- Home
- Platform
- Airflow
- BigQuery
- dbt
- Pipelines
- Datasets
- AI Assistant
- Documentation
- Settings
- About
- Support

Navigation may expand in future releases without changing the overall design philosophy.

---

# Placeholder Policy

Modules not yet implemented should never appear broken.

Instead they should display a professional placeholder such as:

"Coming Soon"

or

"This module is currently under development."

This ensures the platform always appears complete while allowing phased implementation.

---

# Reusability

Common components should be reusable whenever practical.

Examples include:

- Navigation
- Footer
- Ecosystem section
- Support button
- Common styling
- Shared JavaScript

Avoid unnecessary code duplication.

---

# Documentation First

Documentation is considered part of the software.

Implementation should always follow documentation.

If implementation conflicts with documentation, the documentation takes priority until officially updated.

---

# Development Philosophy

The project emphasizes:

- readability
- maintainability
- modularity
- consistency
- scalability
- simplicity

Avoid unnecessary complexity.

---

# Out of Scope

The following items are intentionally excluded from Phase 1:

- Authentication
- Authorization
- User Management
- Billing
- Subscription System
- Database Administration
- Multi-Tenant Support
- Client Isolation
- Production Reverse Proxy
- Cloud Infrastructure

These will be addressed in future phases.

---

# Success Criteria

Phase 1 is considered complete when:

- All planned pages exist.
- Navigation works correctly.
- Branding is consistent.
- Responsive layout functions correctly.
- Shared components are reused.
- Placeholder modules are professional.
- Documentation is complete.
- Repository structure is organized.

---

# Codex Development Instructions

Codex must treat this document as the highest-level project specification.

Do not redesign the platform architecture.

Do not introduce additional frameworks.

Do not change branding.

Do not remove planned modules.

Follow all subsequent documentation files before implementing any feature.

When uncertainty exists, preserve the existing architecture and use placeholders instead of inventing new functionality.

---

# Document Information

Document:
01_PROJECT_OVERVIEW.md

Project:
DeTLeng Platform

Document Version:
1.0

Status:
Approved

Phase:
Phase 1

Last Updated:
2026-07-16

Author:
DeTLeng Platform Engineering
