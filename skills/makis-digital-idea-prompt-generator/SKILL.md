---
name: makis-digital-idea-prompt-generator
description: Generate project ideas, feature ideas, and structured prompts for AI coding agents. Takes a domain or context and produces multiple concrete ideas with pros/cons, then generates executable prompts ready for makis-digital-agent-central.
license: MIT
metadata:
  maintainer: makis-jeanty
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need to go from blank page to executable prompt.
---

# Makis Digital Idea Prompt Generator

Use this skill when you have a vague goal, domain, or problem and need to turn it into concrete ideas and ready-to-execute prompts for the agent-central orchestrator.

## Core workflow

### Phase 1 — Idea generation

Given a **domain/goal** + optional **constraints**, generate 3-5 concrete ideas:

| Input | Example |
|---|---|
| Domain | "PHP e-commerce" |
| Goal | "Admin dashboard to manage orders" |
| Constraints | "Laravel, Inertia, no external APIs" |

For each idea include: name, one-line description, core features (3-5), tech relevance, effort estimate (small/medium/large), and risk level.

### Phase 2 — Idea refinement

Take the chosen idea and refine it:

- What is the MVP scope?
- What are the key entities and relationships?
- What are the routes/endpoints?
- What are the security concerns?
- What could go wrong?

### Phase 3 — Prompt construction

Build a ready-to-execute prompt for `makis-digital-agent-central`:

```
Build a {FEATURE} for {PROJECT}.

Requirements:
- {REQ_1}
- {REQ_2}

Stack: {PHP_VERSION}, {FRAMEWORK}, {DB}, {FRONTEND}

Key entities: {ENTITY_1}, {ENTITY_2}

Routes:
- GET /{resource} — list
- POST /{resource} — create
- GET /{resource}/{id} — show
- PUT /{resource}/{id} — update
- DELETE /{resource}/{id} — delete

Security: {auth_requirements}

Deliverables:
- Migration
- Model
- Controller + Service + Repository
- Tests
- Routes
```

## Prompt styles

| Style | When | Structure |
|---|---|---|
| **Agent Central** | New feature or project | Routes through agent-central for full orchestration |
| **Quick CRUD** | Simple entity CRUD | Direct to crud-refactor skill |
| **Security review** | Auditing existing code | Direct to security-review skill |
| **Bugfix** | Known bug | Direct to test-first-bugfix skill |
| **Spec** | Unclear requirements | Direct to specs skill first |

## Knowledge loading

- Read `references/knowledge/architecture-current.md` for project structure context.
- Read `references/knowledge/decisions.md` for past decisions to avoid repeated mistakes.
- Read `references/knowledge/security-baseline.md` for security controls to include.
- Read `references/knowledge/crud-projects-pattern.md` for CRUD conventions.

## References

- Read [references/idea-prompt-generator.md](references/idea-prompt-generator.md) for detailed templates and examples.
