---
name: makis-digital-frontend-patterns
description: Frontend patterns for the makis-digital PHP project covering PHP view templates, JavaScript organization, form handling, and client-side validation. Use when building or refactoring the frontend layer.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents working with PHP views and minimal JavaScript frontends.
---

# Makis Digital Frontend Patterns

Use this skill when the task involves view templates, JavaScript behavior, form handling, or frontend organization in `makis-digital`.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand view locations and current frontend setup.
- Read `references/knowledge/security-baseline.md` before rendering user-supplied data.

## View layer rules

- Keep views passive — render escaped data, avoid business logic.
- Use layout templates for shared structure (header, footer, nav).
- Keep partial templates for reusable UI fragments (forms, tables, modals).
- Name templates consistently: `feature/index.php`, `feature/form.php`, `feature/show.php`.
- Escape every dynamic value for the correct context (HTML, attribute, URL, JSON).

## Form handling

- Use POST for state-changing forms.
- Include CSRF token in every browser form.
- Render validation errors inline next to the relevant field.
- Preserve valid input values on validation failure — do not clear the form.
- Use a consistent form structure: label, input, error container.

## JavaScript rules

- Keep JavaScript in dedicated files under `assets/js/`, not inline in views.
- Use unobtrusive event handlers — do not use `onclick` attributes.
- Keep JS behavior progressive — the page should work without JS when possible.
- Use a single namespace object for project JS to avoid global collisions.

## CSS rules

- Keep CSS in dedicated files under `assets/css/`.
- Use a consistent naming convention like BEM for classes.
- Keep responsive breakpoints documented and consistent.

## Accessibility rules

- Use semantic HTML elements (`<nav>`, `<main>`, `<form>`, `<button>`).
- Label all form inputs with explicit `<label>` elements.
- Use `aria-label` or `aria-labelledby` for icon-only controls.
- Ensure color contrast meets WCAG AA standards.

## References

- Read [references/frontend-standards.md](references/frontend-standards.md) for detailed frontend conventions and examples.
