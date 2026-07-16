Is file ka purpose

Ye user documentation nahi hogi.

Ye developer notebook hogi.

Codex jab future mein kaam kare to usko context mile.

Example:

# Implementation Notes

This document contains future engineering notes,
planned integrations,
developer reminders,
and implementation ideas.

It is intended for developers working on the DeTLeng Platform.
Isme sections honi chahiye
Future Integrations
Airflow Reverse Proxy

Target URL

platform.detleng.com/airflow

Status

Planned
BigQuery
Future

Native Dataset Browser

Status

Planned
AI Assistant
Future

SQL Generator

Pipeline Generator

Documentation Assistant

Status

Planned
TODO Standards

Har page ke andar Codex ye format use kare.

<!--
==================================================

TODO

Module

Apache Airflow

Purpose

Launch Airflow UI

Future

Reverse Proxy

Target

platform.detleng.com/airflow

Status

Planned

==================================================
-->

Ye bahut professional lagta hai.

Future Documents
Later create

AIRFLOW.md

BIGQUERY.md

DBT.md

AI_ASSISTANT.md

MONITORING.md

SETTINGS.md

Abhi nahi.

Jab implementation start hogi.

Ek aur cheez add karo

Main 05 aur 07 ke beech ek relation bhi banaunga.

05 bolega

Every page must follow Development Rules.

07 bolega

Developer reminders.

Future ideas.

Experimental features.

Temporary implementation notes.

Dono overlap nahi karenge.

Aur ek zabardast idea

Codex ko ek rule aur de do.

Every HTML page should begin with a Developer Comment Block.

Example

==================================================

Page

Airflow

Purpose

Launch Apache Airflow

Version

1.0

Author

DeTLeng Platform

Status

Phase 1

==================================================

Ye comments browser mein show nahi honge, lekin source code dekhne wale developer ko turant samajh aa jayega ke page kis purpose ke liye bana hai.

Ek aur future-proof rule

Har page mein version bhi likhwa do.

Example:

<!--
Project

DeTLeng Platform

Module

BigQuery

Version

1.0.0

Last Updated

2026-07-16

Phase

1

-->

Kal ko 200 pages bhi ho gaye to maintenance bahut aasaan ho jayegi.

Final Architecture

Meri nazar mein ab docs/ folder kuch is tarah hona chahiye:

docs/
│
├── 01_PROJECT_OVERVIEW.md
├── 02_UI_UX_STANDARDS.md
├── 03_PLATFORM_ARCHITECTURE.md
├── 04_PAGE_SPECIFICATIONS.md
├── 05_DEVELOPMENT_RULES.md
├── 06_FUTURE_ROADMAP.md
└── 07_IMPLEMENTATION_NOTES.md

Ye 7 files mil kar DeTLeng Platform ki Software Design Specification (SDS) ban jayengi. Iske baad Codex sirf HTML generate nahi karega, balki isi architecture aur standards ko follow karte hue platform develop karega. Phir jab hum Airflow, BigQuery, dbt, AI Assistant ya kisi naye module par kaam shuru karenge, to us module ki apni specification file add kar denge aur poora project ek hi engineering standard par grow karega.
