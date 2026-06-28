---
name: makis-digital-verification-loop
description: Post-change verification workflow for the makis-digital PHP project. Use after implementing features, applying fixes, or refactoring to confirm the change is safe, tested, and ready before closing the task.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need a structured post-change verification step before marking work complete.
---

# Makis Digital Verification Loop

Use this skill after implementing a change to confirm builds, tests, and security checks pass before considering the task done.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand which files and folders the change might affect beyond the edited scope.
- Read `references/knowledge/decisions.md` if the change touches structural decisions.
- Read `references/knowledge/security-baseline.md` if the change touches auth, validation, CSRF, output, sessions, uploads, or APIs.

## Verification order

1. **Build check** — confirm the project loads without parse or syntax errors.
2. **Focused test suite** — run tests directly related to the changed code.
3. **Broader test suite** — run the full or related test suite to catch regressions.
4. **Security review** — trace entry points, validation, and authorized paths affected by the change.
5. **Diff review** — check the diff for accidental changes, debug code, hardcoded values, or comments that should not ship.
6. **Artifact preservation** — save test results and a summary of what was verified.

## Verification output

For each verification step, capture:
- What passed or failed.
- What was tested (file, test name, or scope).
- Any follow-up needed before the change is safe to close.

## Rules

- Do not skip the focused suite even when the broader suite passes.
- Do not skip security review when the change touches input, output, auth, sessions, uploads, or data mutation.
- Do not close a task with failing tests unless blocked and explicitly deferred.
- Do not ship debug output, dump statements, or hardcoded test credentials.

## Gotchas

- A passing build does not mean the change is safe — test coverage matters.
- A passing test suite does not mean the change is secure — security review is separate.
- A small diff can still have broad impact when it touches middleware, routing, or shared utilities.

## References

- Read [references/verification-checklist.md](references/verification-checklist.md) for the full verification checklist.
