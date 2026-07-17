# DeTLeng Platform

Phase 1 frontend foundation for the DeTLeng data engineering platform.

## Included

- `index.html` — platform home and workflow overview
- `dashboard.html` — operational control center with five integration-ready modules
- `css/style.css` — shared responsive design system
- `js/app.js` — shared navigation, support email, and placeholder interactions
- `images/` — unchanged official DeTLeng logo and favicon
- `docs/` — approved project overview and UI/UX specification

## Run locally

Open `index.html` directly in a browser, or serve this directory with any static web server.

## Phase 1 scope

This repository contains frontend UI only. Apache Airflow, PostgreSQL, dbt, and Dashboard Engine cards intentionally use placeholder actions. The AI Assistant opens the approved external service in a new tab.

The module targets are kept in the dashboard markup (`/airflow`, `/postgresql`, and `/dbt`) so future integrations can be connected without redesigning the cards.
