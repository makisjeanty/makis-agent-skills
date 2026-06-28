# Memory Workflow

Knowledge management playbook for `makis-digital`.

## What to capture

| Event | Capture in |
|---|---|
| Architecture decision (why not how) | `references/knowledge/decisions.md` |
| Structural change | `references/knowledge/architecture-current.md` |
| New CRUD convention | `references/knowledge/crud-projects-pattern.md` |
| Security control or baseline change | `references/knowledge/security-baseline.md` |
| Reusable bugfix pattern | New reference in skill's `references/` |
| Reusable prompt or agent pattern | New reference in skill's `references/` |
| External tool or SDK notes | New reference in skill's `references/` |

## Capture checklist

- [ ] Is this decision non-obvious or high-impact?
- [ ] Would a future agent benefit from reading this?
- [ ] Is the entry factual and specific to this project?
- [ ] Does it include context, decision, rationale, and consequences?
- [ ] Is the file under version control?

## Retrieval checklist

Before a structural change:
- [ ] Check `references/knowledge/decisions.md` for relevant past decisions.
- [ ] Check `references/knowledge/architecture-current.md` for current structure.

Before a security change:
- [ ] Check `references/knowledge/security-baseline.md` for existing controls.

Before a CRUD change:
- [ ] Check `references/knowledge/crud-projects-pattern.md` for existing conventions.
- [ ] Check the relevant skill's `references/` for patterns.

## Knowledge file hygiene

- One file per knowledge domain (decisions, architecture, security, CRUD).
- Append new entries — never delete or rewrite history.
- Use consistent date prefix format for chronological entries.
- Review and consolidate knowledge files periodically to remove stale entries.
