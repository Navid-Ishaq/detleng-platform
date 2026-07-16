# 02_UI_UX_STANDARDS.md

# DeTLeng Platform

## UI / UX Standards

---

# Purpose

This document defines the official User Interface (UI) and User Experience (UX) standards for the DeTLeng Platform.

Every page, component, module, and future implementation must follow these standards.

Consistency is more important than creativity.

The entire platform should feel like one professional application rather than multiple unrelated web pages.

---

# Design Philosophy

The DeTLeng Platform is an engineering platform.

Its interface should communicate:

- Professionalism
- Simplicity
- Reliability
- Clarity
- Modern Engineering
- Maintainability

Avoid unnecessary animations, visual clutter, excessive colors, or decorative elements.

The interface should remain clean and functional.

---

# Branding

The platform uses official DeTLeng branding.

Use ONLY the provided assets.

Logo

logop.png

Favicon

faviconp.png

These assets must remain consistent across every page.

Never replace or redesign them.

---

# Global Layout

Every page should follow exactly the same layout.

Standard page structure:

Fixed Navigation

↓

Page Content

↓

Module Content

↓

Footer

↓

Support Button

↓

Shared JavaScript

Users should never feel that they have left the platform.

---

# Navigation Standards

Navigation is mandatory on every page.

The navigation bar must:

- remain fixed at the top
- remain identical on every page
- display the DeTLeng logo
- support desktop and mobile layouts
- use consistent spacing
- use consistent typography

Never redesign the navigation for individual pages.

---

# Navigation Menu

Initial platform modules:

- Home
- Airflow
- BigQuery
- dbt
- Pipelines
- Datasets
- Jobs
- Logs
- AI Assistant
- Monitoring
- Settings
- Documentation

Future modules may be added without changing the existing navigation design.

---

# Active Navigation

The currently opened page must always be visually highlighted.

Example:

Hover

Blue

Active

Dark Blue

Bold Text

Yes

Underline

Optional

This provides immediate orientation to the user.

---

# Hover Effects

Every interactive element should provide visual feedback.

Examples include:

Navigation links

Buttons

Cards

Icons

Clickable modules

Hover transitions should remain subtle.

Recommended transition:

0.2s

Avoid flashy animations.

---

# Responsive Design

Responsive design is mandatory.

Desktop

Required

Tablet

Required

Mobile

Required

Pages must remain usable on all common screen sizes.

Never create desktop-only layouts.

---

# Typography

Use clean system fonts.

Preferred:

Segoe UI

Fallback:

Arial

sans-serif

Typography should prioritize readability.

Avoid decorative fonts.

---

# Color Palette

Primary Blue

DeTLeng Blue

Primary Accent

Golden Yellow

Background

White

Secondary Background

Light Gray

Text

Dark Gray

Links

Blue

Success

Green

Warning

Orange

Danger

Red

Maintain color consistency across all modules.

---

# Spacing

Pages should use generous whitespace.

Avoid crowded layouts.

Recommended spacing:

Section spacing

40px–60px

Card padding

20px–30px

Content width

Approximately 900–1200px

Spacing should remain consistent throughout the platform.

---

# Cards

Cards should use:

Soft border

Rounded corners

Subtle shadow

Consistent padding

Consistent spacing

Cards should never appear visually heavy.

---

# Buttons

Buttons should remain consistent across the platform.

Rounded Corners

12px

Transition

0.2s

Hover

Required

Soft Shadow

Required

Primary Button

Blue

Secondary Button

Gray

Danger Button

Red

Support Button

DeTLeng Blue

Buttons should communicate hierarchy through color.

---

# Footer

Every page must contain the same footer.

Footer contents:

DeTLeng Ecosystem

Platform Links

Copyright

Support Information

Future links may be added without redesigning the footer.

---

# Ecosystem Section

Every page must display the official **DeTLeng Ecosystem** section.

Include links to:

DeTLeng

Insights

Case Studies

Inteligencia

Agents





This section should remain identical across the entire platform and provide quick navigation to other DeTLeng properties.

The following websites must always be included.

| Platform | URL | Purpose |
|----------|-----|---------|
| **DeTLeng** | https://www.detleng.com | Data Engineering • ETL • Analytics • Business Intelligence |
| **Insights** | https://insights.detleng.com | Research • Articles • Knowledge Hub |
| **Case Studies** | https://casestudy.detleng.com | Projects • Implementations • Success Stories |
| **Inteligencia DeTLeng** | https://inteligencia.detleng.com | Knowledge • Insights • Applied Intelligence |
| **Agents DeTLeng** | https://agents.detleng.com | AI Agents • Automation • Intelligent Workflows |

## UI Requirements

The Ecosystem section should:

- appear near the bottom of every page
- use the same layout on every page
- use the same spacing and styling
- remain fully responsive
- open all external links in a new browser tab (`target="_blank"`)
- preserve consistent branding across the platform

The Ecosystem section is considered a shared platform component and must remain visually identical throughout the DeTLeng Platform.

---

# Support Button

Every page must contain the Support button.

The Support button should:

Open the user's default email application.

Automatically prepare a consultation email template.

The email template should include:

Name

Project Type

Project Description

Data Source

Expected Outcome

Deadline

Additional Requirements

The user only fills in the information and presses Send.

Do not require custom forms or backend processing.

The implementation should use a standard mailto link.

---

# Shared Components

The following elements should be implemented as reusable components whenever practical.

Navigation

Footer

Support Button

Ecosystem Section

Common Styles

Common JavaScript

Avoid unnecessary duplication.

If reusable components are not technically possible in Phase 1 using pure HTML, maintain identical code across all pages and prepare for future component extraction.

---

# Page Consistency

Every page must contain:

Logo

Favicon

Navigation

Page Title

Module Content

Footer

Support Button

Developer Comments

Version Information

No page should appear visually different from the rest of the platform.

---

# Placeholder Pages

Modules not yet implemented should remain professional.

Display:

Module Name

Description

Implementation Status

Coming Soon

Future Roadmap

Never leave blank pages.

---

# Accessibility

Use semantic HTML whenever practical.

Buttons must remain clickable.

Links should remain distinguishable.

Contrast should remain readable.

Avoid relying only on color to communicate meaning.

---

# Performance

Avoid unnecessary JavaScript.

Avoid large image assets.

Keep HTML clean.

Reuse CSS whenever possible.

Load only what is required.

---

# Widget Strategy

Phase 1 should prioritize simplicity.

Preferred approach:

Shared CSS

Shared JavaScript

Common reusable HTML structure

Do not introduce frontend frameworks.

If future requirements justify it, reusable widgets or components may be introduced without changing the visual design.

---

# UI Evolution

Future enhancements may include:

Dark Mode

Theme Switching

Component Library

Animations

Accessibility Improvements

Localization

These enhancements should preserve the existing design language.

---

# Codex Development Instructions

Codex must follow these UI standards exactly.

Do not redesign pages individually.

Do not introduce different fonts, colors, spacing, or layouts.

Every page must appear to belong to the same platform.

When uncertain, prefer consistency over creativity.

---

# Document Information

Document

02_UI_UX_STANDARDS.md

Project

DeTLeng Platform

Version

1.0

Status

Approved

Phase

Phase 1

Last Updated

2026-07-16

Author

DeTLeng Platform Engineering
