---
name: makis-digital-agent-central
description: Central orchestrator for the makis-digital skill ecosystem. Analyzes incoming tasks, selects and chains the right specialized skills, and coordinates multi-step workflows. Use as the first skill when the task scope is unclear or spans multiple concerns.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need to route tasks across a multi-skill ecosystem.
  priority: highest
---

# Makis Digital Agent Central

Use this skill as the **entry point** for any `makis-digital` task. It analyzes the request, selects the correct specialized skill(s), and orchestrates the workflow from start to finish.

## How it works

1. **Analyze** the incoming request — identify what the task touches (CRUD, security, AI, database, tests, specs).
2. **Select** the right specialized skill(s) based on the analysis.
3. **Chain** skills in the correct order when the task spans multiple concerns.
4. **Verify** with `makis-digital-verification-loop` before closing.

## Task routing

| If the task is about... | Start with... |
|---|---|
| Architecture, unclear scope, or broad delivery | `makis-digital-dev-rules` |
| CRUD reorganization or modularization | `makis-digital-crud-refactor` |
| Security review or hardening | `makis-digital-security-review` |
| Bugfix or regression | `makis-digital-test-first-bugfix` |
| AI/LLM SDK integration | `makis-digital-ai-integration` |
| Persistence, queries, or migrations | `makis-digital-database-patterns` |
| Requirements-to-specs translation | `makis-digital-specs` |
| Knowledge capture or decision logging | `makis-digital-memory` |
| Post-change verification | `makis-digital-verification-loop` |

## Multi-skill chaining

For tasks that span multiple areas, chain skills in this order:

1. **Specs first** — if requirements are unclear, start with `makis-digital-specs`.
2. **Dev-rules umbrella** — activate `makis-digital-dev-rules` to frame the work.
3. **Specialized skill** — use the relevant skill (CRUD, AI, database, security, bugfix).
4. **Memory capture** — record decisions and reusable patterns with `makis-digital-memory`.
5. **Verification** — close with `makis-digital-verification-loop`.

## Autonomy levels

- **Low autonomy** (default for risky or complex tasks): activate skills explicitly, review each output, run verification.
- **Medium autonomy** (familiar work, clear scope): chain skills but confirm before destructive operations.
- **High autonomy** (well-understood patterns, safe refactors): execute full workflow and report results.

## Knowledge loading

- Read `references/knowledge/skill-catalog.md` to understand available skills and their purposes.
- Read `references/knowledge/workflows.md` for ordered execution playbooks.
- Read `references/knowledge/architecture-current.md` when the task involves existing project structure.

## References

- Read [references/orchestration-rules.md](references/orchestration-rules.md) for detailed orchestration patterns.
