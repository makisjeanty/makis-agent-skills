---
name: makis-digital-crud-refactor
description: Refactor or build CRUD modules in makis-digital with thin controllers, reusable services, dedicated persistence classes, and safe incremental changes. Use when changing routes, controllers, views, database access, validation flow, or module structure for features like projects, admin panels, forms, or APIs.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents refactoring PHP CRUD modules with tests and incremental architecture changes.
---

# Makis Digital CRUD Refactor

Use this skill when a CRUD feature needs to be stabilized, cleaned up, or reorganized without losing behavior.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` before reorganizing folders or responsibilities.
- Read `references/knowledge/decisions.md` before changing runtime targets such as `src/` versus `app/`.
- Read `references/knowledge/crud-projects-pattern.md` when working on the `projects` module or using it as the reference CRUD flow.
- Read `references/knowledge/security-baseline.md` before changing create, update, or delete paths.

## Workflow

1. Read the route, controller, view, persistence code, and tests for the module.
2. Write or update a behavior-preserving test before deeper refactors.
3. Keep routes stable while moving logic downward.
4. Extract validation, business rules, and persistence in small steps.
5. Re-run focused tests after each meaningful step.

## Target architecture

- Controller: request parsing, authorization, response selection
- Service: business rules and use-case orchestration
- Repository or persistence layer: reads and writes
- Validator: reusable input rules when validation stops being trivial
- View: rendering only

## Refactor order

1. Protect current behavior with tests.
2. Extract repeated reads and writes from the controller.
3. Extract business decisions to a service.
4. Keep controller methods short and explicit.
5. Remove duplicated validation from sibling actions.

## Gotchas

- Do not rewrite routes just because internals are changing.
- Do not move view-specific formatting logic into persistence classes.
- Do not leave security checks behind in a removed controller branch.
- Do not mix browser-form flow and API flow unless they intentionally share the same service contract.

## References

- Read [references/incremental-crud-migration.md](references/incremental-crud-migration.md) before a non-trivial CRUD reorganization.
