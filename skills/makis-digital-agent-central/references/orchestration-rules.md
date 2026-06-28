# Orchestration Rules

Rules for the central orchestrator agent when chaining multiple skills.

## Task analysis

Before selecting skills, answer:
- What is the primary concern? (CRUD, security, AI, database, tests, specs, memory)
- Does it touch multiple layers? (controller, service, persistence, view, security)
- Is the scope clear or does it need specification first?
- Is it risky enough to require low autonomy?

## Skill chaining

- Always start with the most foundational skill (specs → dev-rules → specialized → memory → verification).
- Do not skip verification when the task involves data mutation, auth, or external API calls.
- Do not skip memory capture when the task creates a new pattern or resolves an ambiguity.
- Run verification even when using high autonomy.

## Conflict resolution

- If two skills disagree on approach, prefer `makis-digital-dev-rules` as the authority.
- If the task is covered by multiple skills, use the most specific one.
- If no skill fits, fall back to `makis-digital-dev-rules`.

## Autonomy by task type

| Task type | Autonomy | Why |
|---|---|---|
| Bugfix with clear reproduction | Medium | Test-first workflow is well-defined |
| New CRUD module | Medium | Blueprint exists |
| Security review | Low | Risk of missing vulnerabilities |
| AI integration | Low | External API, sensitive data |
| Schema migration | Medium | Reversible when tested |
| Knowledge capture | High | Non-destructive |
| Spec writing | High | Draft, reviewed later |
| Verification | High | Checklist-driven |
