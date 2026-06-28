---
name: makis-digital-specs
description: Translate requirements into technical specifications for the makis-digital PHP project. Use when the task starts from a vague request, feature idea, or user story that needs structured specification before implementation begins.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need to turn unstructured requirements into actionable implementation specs.
---

# Makis Digital Specs

Use this skill when the task is unclear, the requirements are incomplete, or you need a written specification before writing code.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand where new features fit.
- Read `references/knowledge/decisions.md` for past decisions that constrain new features.
- Read `references/knowledge/crud-projects-pattern.md` when the spec involves CRUD flows.
- Read `references/knowledge/security-baseline.md` to include security requirements from the start.

## Spec workflow

1. **Clarify intent** — ask or infer what the feature should do, who uses it, and what problem it solves.
2. **Map the surface** — identify routes, controllers, data model, views, and API endpoints involved.
3. **Define contract** — specify inputs, outputs, validation rules, auth requirements, and error states.
4. **State constraints** — note performance, security, backward-compatibility, and UI constraints.
5. **Write the spec** — produce a concise, structured document covering all of the above.
6. **Review against existing patterns** — check that the spec aligns with project conventions.

## Spec structure

```markdown
## Feature: [name]

### Goal
One sentence describing what the feature does.

### Routes / Endpoints
- `GET /path` — description, auth, params
- `POST /path` — description, auth, body, validation

### Data model
Fields, types, constraints, defaults, relationships.

### Controllers
Which controller(s), new or modified.

### Services
New business rules or logic.

### Repositories
New queries, read/write operations, schema changes.

### Views / Responses
What the user sees or the API returns.

### Security
- Auth requirements
- Authorization rules
- CSRF / API auth
- Input validation rules
- Output escaping context

### Testing scope
- Unit tests needed
- Integration tests needed
- Edge cases to cover
```

## Rules

- Write specs before code when the feature involves new routes, data models, or security-sensitive flows.
- Keep specs short — one page or less for most features.
- Reference existing patterns instead of re-specifying them.
- Do not include implementation details that the implementer can decide.
- Do not skip security requirements in the spec — define them upfront.
- Update the spec if implementation reveals gaps.

## References

- Read [references/spec-template.md](references/spec-template.md) for the spec template and examples.
- Read `references/knowledge/crud-projects-pattern.md` for existing CRUD conventions.
