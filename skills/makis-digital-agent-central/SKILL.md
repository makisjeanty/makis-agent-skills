---
name: makis-digital-agent-central
description: Central orchestrator for the makis-digital skill ecosystem. Analyzes incoming tasks, selects and chains the right specialized skills, and coordinates multi-step workflows. Use as the first skill when the task scope is unclear or spans multiple concerns.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.2.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need to route tasks across a multi-skill ecosystem.
  priority: highest
---

# Makis Digital Agent Central

Use this skill as the **entry point** for any `makis-digital` task. It analyzes the request, decomposes it into sub-tasks, dispatches specialized subagents in parallel, then synthesizes and verifies the result.

## How it works

1. **Analyze** the incoming request — identify what the task touches (CRUD, security, AI, database, tests, specs).
2. **Decompose** into independent sub-tasks — each sub-task should map to one specialized concern.
3. **Dispatch** subagents via the `task` tool — each subagent receives a focused brief + skill context.
4. **Synthesize** results from all subagents into a coherent output.
5. **Verify** with `makis-digital-verification-loop` before closing.

## Subagent dispatch rules

**Every subagent dispatch MUST include in its prompt:**

1. `Load $SKILL_NAME` — tell the subagent which skill to use ("Load makis-digital-crud-refactor")
2. The **exact sub-task** scoped to one concern
3. Concrete **deliverables** (e.g., "Write the Repository class at app/Repositories/UserRepository.php")
4. A **return instruction** — "Return the file paths created/modified and a brief summary."

**Parallel dispatch**: independent sub-tasks run concurrently via multiple `task` calls.

**Sequential dispatch**: when one sub-task depends on another (e.g., specs before implementation), chain them.

### Subagent → skill mapping

| Sub-task type | Skill to load |
|---|---|
| Architecture, standards, undefined scope | `makis-digital-dev-rules` |
| CRUD refactor / modularization | `makis-digital-crud-refactor` |
| Security review / hardening | `makis-digital-security-review` |
| Bugfix / regression | `makis-digital-test-first-bugfix` |
| AI / LLM SDK integration | `makis-digital-ai-integration` |
| Database schema / queries / migrations | `makis-digital-database-patterns` |
| REST API design | `makis-digital-api-patterns` |
| Error handling patterns | `makis-digital-error-handling` |
| Frontend / views / forms | `makis-digital-frontend-patterns` |
| Logging / observability setup | `makis-digital-logging-observability` |
| Composer / dependencies | `makis-digital-dependency-management` |
| Build / release / deploy | `makis-digital-deployment` |
| Test planning | `makis-digital-testing-strategy` |
| Spec writing (requirements → spec) | `makis-digital-specs` |
| Knowledge capture / decisions | `makis-digital-memory` |
| Post-change verification | `makis-digital-verification-loop` |
| Idea shaping / prompt crafting | `makis-digital-idea-prompt-generator` |
| Research / architecture investigation | `makis-digital-expert-researcher` |
| Performance tuning / caching / profiling | `makis-digital-performance-optimization` |

## Multi-skill chaining (sequential)

For tasks that span multiple areas, chain in this order:

1. **Specs first** — `makis-digital-specs` if requirements are unclear
2. **Dev-rules umbrella** — `makis-digital-dev-rules` to frame the work
3. **Specialized skills** — dispatch relevant subagents (can be parallel)
4. **Memory capture** — `makis-digital-memory` for decisions and patterns
5. **Verification** — `makis-digital-verification-loop` to close

## Decomposition examples

### Example: "Add a blog post CRUD with AI summary"

```
Sub-task 1 (specs):      "Write specs for blog post CRUD" → specs subagent
Sub-task 2 (db):         "Create migration + model for posts table" → db subagent
Sub-task 3 (CRUD):       "Build PostController + PostService + PostRepository" → CRUD subagent
Sub-task 4 (AI):         "Integrate AI summary on post save" → AI subagent
Sub-task 5 (verification): "Verify build, tests, security" → verification subagent
```

Dispatch 1-4 in parallel (or sequential if specs → implementation), then 5.

### Example: "Review and fix security issues in login"

```
Sub-task 1 (security):    "Audit login controller for auth, CSRF, XSS, injection" → security subagent
Sub-task 2 (test):        "Write tests for login edge cases" → test-first-bugfix subagent
Sub-task 3 (fix):         "Apply security fixes from audit" → dev-rules + CRUD subagent
Sub-task 4 (verification): "Verify tests pass, no regressions" → verification subagent
```

## Autonomy levels

- **Low autonomy** (risky/complex): decompose manually, review each subagent output, run verification.
- **Medium autonomy** (familiar work): decompose and dispatch, but confirm before destructive ops.
- **High autonomy** (safe patterns): full decompose → dispatch → synthesize → verify in one flow.

## Knowledge loading

- `references/knowledge/skill-catalog.md` — available skills
- `references/knowledge/workflows.md` — ordered playbooks
- `references/knowledge/architecture-current.md` — project structure
- `references/orchestration-rules.md` — detailed decomposition rules
- `agents/` — subagent prompt templates for common patterns
