# Orchestration Rules

Rules for the central orchestrator when decomposing tasks and dispatching subagents.

## Task decomposition

Before dispatching subagents, decompose the request:

1. **Identify concerns** — list every domain the task touches (controller, service, DB, AI, auth, views, tests, deploy)
2. **Map concerns to skills** — each concern maps to one skill from the routing table
3. **Group by dependency** — are there ordering constraints? (specs before code, schema before CRUD)
4. **Decide parallelism** — independent concerns run in parallel; dependent ones chain sequentially

## Subagent dispatch

### Writing a subagent prompt

Every subagent dispatch via the `task` tool must include:

```
You are a {ROLE}. Load `{SKILL_NAME}`.

Your task: {EXACT_TASK}

Deliverables:
- {FILE_1}
- {FILE_2}

Return: file paths + summary.
```

### Parallel dispatch pattern

```json
// Multiple concurrent task calls for independent work
task("BlogPost migration + model", prompt=db_prompt, subagent_type="general")
task("PostController + service", prompt=crud_prompt, subagent_type="general")
task("AI summary integration", prompt=ai_prompt, subagent_type="general")
```

Then collect all results.

### Sequential dispatch pattern

```
1. specs subagent → produces spec doc
2. db subagent (reads spec) → produces migration
3. crud subagent (reads spec + migration) → produces controller/service
4. verification subagent → runs checks
```

## Result synthesis

After all subagents return:

1. Collect file paths from each subagent
2. Check for conflicts (same file modified by two subagents)
3. If conflicts: re-run conflicted subagents sequentially
4. Present unified summary to the user

## Autonomy levels

| Task type | Autonomy | Decomposition |
|---|---|---|
| Bugfix with clear reproduction | High | Auto-decompose, dispatch, verify |
| New CRUD module | High | Auto-decompose, dispatch, verify |
| Security review | Low | Decompose manually, review each |
| AI integration | Low | Decompose manually, review each |
| Schema migration | Medium | Auto-decompose, confirm migrations |
| Knowledge capture | High | Single subagent, direct |
| Spec writing | High | Single subagent, direct |
| Cross-cutting feature (multiple layers) | Medium | Auto-decompose, confirm before destructive ops |

## Conflict resolution

- Two subagents modifying the same file → re-run them sequentially, not parallel
- Two subagents disagreeing on approach → prefer `makis-digital-dev-rules` as authority
- No skill matches the concern → fall back to `makis-digital-dev-rules`
- Subagent returns an error → retry once with more context, if fails again escalate to user

## Safety rules

- Never dispatch a subagent that would write secrets or credentials
- Always run verification as the final step
- Always run security review when auth, payments, or PII is involved
- Always run memory capture when discovering a new pattern or resolving an ambiguity
