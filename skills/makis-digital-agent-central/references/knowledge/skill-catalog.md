# Skill Catalog

## Core skills

- `makis-digital-dev-rules`
  Use as the umbrella skill when a task spans architecture, security, testing, and delivery decisions.
- `makis-digital-crud-refactor`
  Use for CRUD reorganization, modularization, and safer controller/service/repository separation.
- `makis-digital-security-review`
  Use for validation, CSRF, auth, output escaping, upload safety, and general hardening reviews.
- `makis-digital-test-first-bugfix`
  Use for regressions, bug reproduction, and risky fixes that should start from a failing test.

## Starter bundles

- `safe-feature-delivery`
  Start with `makis-digital-dev-rules`, then use `makis-digital-crud-refactor`, and finish with `makis-digital-security-review`.
- `security-hardening`
  Start with `makis-digital-dev-rules`, then use `makis-digital-security-review`, and add `makis-digital-test-first-bugfix` if the fix is risky.
- `bugfix-with-confidence`
  Start with `makis-digital-test-first-bugfix`, then use `makis-digital-security-review` if the bug touches auth, input, output, uploads, or sessions.
