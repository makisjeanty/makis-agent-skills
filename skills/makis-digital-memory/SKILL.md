---
name: makis-digital-memory
description: Project knowledge management for the makis-digital PHP project. Captures decisions, reusable patterns, architecture rationale, and debugging outcomes so future agent sessions can build on past work instead of rediscovering it.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need to persist and retrieve project knowledge across sessions.
---

# Makis Digital Memory

Use this skill when the task involves recording project knowledge, capturing architecture decisions, saving reusable patterns, or retrieving past decisions to inform current work.

## When to capture

- After completing a non-trivial feature or refactor.
- When a design decision resolves an ambiguity that future agents might face again.
- When a bug reveals a subtle invariant or edge case.
- When a security finding changes how a module should be reviewed.
- When a new pattern or convention emerges from project work.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` before documenting structural changes.
- Read `references/knowledge/decisions.md` before adding new decisions.
- Read `references/knowledge/crud-projects-pattern.md` when capturing project-specific CRUD patterns.
- Read `references/knowledge/security-baseline.md` when documenting security decisions.

## Capture workflow

1. Identify what is worth keeping: decisions, patterns, gotchas, architecture changes.
2. Choose the right knowledge file:
   - `decisions.md` for architecture and design decisions.
   - `architecture-current.md` for structural changes.
   - `crud-projects-pattern.md` for CRUD flow patterns.
   - `security-baseline.md` for security controls and conventions.
   - A new reference file under `references/` for new patterns.
3. Write concisely: state the context, the decision, and the rationale.
4. Keep entries short and factual — avoid generic advice.

## Capture format

```markdown
### YYYY-MM-DD: Short title

**Context:** What prompted this.
**Decision:** What was chosen.
**Rationale:** Why this option over others.
**Consequences:** What this enables or rules out.
```

## Retrieval workflow

1. Check `references/knowledge/decisions.md` before making structural changes.
2. Check `references/knowledge/architecture-current.md` before reorganizing.
3. Check `references/knowledge/security-baseline.md` before making auth or security changes.
4. Check skill-specific reference files for patterns and gotchas.

## Rules

- Do not capture trivial or obvious decisions — only non-obvious or impactful ones.
- Do not overwrite previous entries — append new ones.
- Do not capture sensitive data, credentials, or internal vulnerability details in knowledge files.
- Do keep knowledge files under version control so they evolve with the project.

## References

- Read [references/memory-workflow.md](references/memory-workflow.md) for the detailed knowledge management playbook.
