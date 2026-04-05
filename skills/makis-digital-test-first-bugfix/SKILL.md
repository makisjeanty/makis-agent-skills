---
name: makis-digital-test-first-bugfix
description: Fix bugs in makis-digital with a test-first workflow that protects behavior and supports safe refactoring. Use when reproducing regressions, locking down expected behavior, fixing edge cases, or refactoring risky code that should keep the same external behavior.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents fixing regressions in PHP codebases with focused test-first workflows.
---

# Makis Digital Test First Bugfix

Use this skill when a bug, regression, or risky refactor should be handled by proving the behavior with tests before the main code change.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to choose the right test level.
- Read `references/knowledge/decisions.md` if the bug touches a known project decision.
- Read `references/knowledge/security-baseline.md` if the regression involves auth, validation, CSRF, output, sessions, uploads, or API security.
- Read `references/knowledge/crud-projects-pattern.md` if the bug is in the `projects` CRUD flow.

## Workflow

1. Reproduce the bug in one sentence.
2. Find the narrowest test level that proves it.
3. Write or update the failing test first.
4. Implement the smallest change that makes it pass.
5. Run the focused suite, then the related broader suite.

## Choose the test level

- Use unit tests for pure validators, helpers, and security utilities.
- Use integration-style tests for routing, controllers, persistence, and end-to-end CRUD behavior.
- Prefer the lowest level that still proves the bug.

## Bugfix rules

- Do not refactor widely before the failing test exists.
- Keep the fix small until the regression is covered.
- If a refactor is needed, split it into behavior lock-in first, cleanup second.

## Gotchas

- A manually reproduced bug is not protected until a test exists.
- A broad end-to-end test is not always the best first test.
- Do not hide uncertainty; document assumptions in the test name or setup.

## References

- Read [references/test-first-workflow.md](references/test-first-workflow.md) when handling regressions or risky refactors.
