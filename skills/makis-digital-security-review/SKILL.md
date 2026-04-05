---
name: makis-digital-security-review
description: Review or harden makis-digital code for security from the base of the system upward. Use when changing authentication, authorization, CSRF, validation, output encoding, sessions, uploads, API endpoints, error handling, or any user-controlled input and state-changing flow.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents reviewing or hardening PHP web applications with browser and API attack surfaces.
---

# Makis Digital Security Review

Use this skill for secure implementation work and for code reviews focused on vulnerabilities, exposure risks, and missing protections.

## Knowledge loading

- Read `references/knowledge/security-baseline.md` first.
- Read `references/knowledge/architecture-current.md` to understand where the current security controls live.
- Read `references/knowledge/decisions.md` if the review could lead to structural changes.
- Read `references/knowledge/crud-projects-pattern.md` when reviewing project CRUD or admin mutations.

## Review order

1. Identify entry points: forms, routes, JSON bodies, file uploads, headers, sessions.
2. Trace validation, authorization, and mutation paths.
3. Check output contexts and error handling.
4. Check tests covering the risky behavior.
5. Report findings by severity before summarizing.

## High-risk areas in this project

- login and session flow
- admin-only mutations
- CSRF-protected browser forms
- API authentication and token handling
- uploads and file serving
- dynamic views and escaped output

## Findings format

- State the risk first.
- Name the affected file or flow.
- Explain the impact briefly.
- Propose the safest fix that fits the current architecture.

## Gotchas

- A passing happy-path test does not prove secure behavior.
- Validation is not authorization.
- Sanitizing input does not replace output escaping.
- API endpoints need auth checks even when browser routes are already protected.

## References

- Read [references/security-review-checklist.md](references/security-review-checklist.md) during security reviews or hardening tasks.
