---
name: makis-digital-testing-strategy
description: Testing strategy and coverage planning for the makis-digital PHP project. Use when deciding what to test, at what level, and how much coverage is appropriate for a given change or feature.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need to plan or review test coverage for PHP applications.
---

# Makis Digital Testing Strategy

Use this skill when planning test coverage for a feature, reviewing existing tests, or deciding which testing approach fits a given change.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand module boundaries and test file locations.
- Read `references/knowledge/decisions.md` for past testing decisions.

## Test levels

| Level | Scope | Speed | When to use |
|---|---|---|---|
| Unit | Single class or function | Fast | Pure logic, validators, helpers, security utilities |
| Integration | Route → controller → service → persistence | Medium | CRUD flows, auth flows, API endpoints |
| End-to-end | Full browser or API flow | Slow | Critical user paths, payment, cross-module flows |

## Coverage priorities

1. **Business rules** — every conditional branch in services and validators.
2. **Security paths** — auth failures, unauthorized access, CSRF rejection, validation bypass.
3. **Error paths** — not-found, conflict, rate-limit, external service failure.
4. **Happy paths** — the primary success flow for each endpoint or feature.
5. **Edge cases** — empty lists, duplicate keys, max-length input, special characters.

## Decision tree

```
Is it pure logic (no I/O)?
  → Unit test
Does it touch a route or controller?
  → Integration test
Does it touch persistence?
  → Integration test with test database
Is it a critical user path?
  → Add an end-to-end test
Does it fix a bug?
  → Write the test first (see test-first-bugfix)
```

## Rules

- Test one behavior per test method — use descriptive names.
- Use factories or fixtures for test data, not hardcoded arrays in every test.
- Prefer in-memory or test-database persistence over mocking the repository layer.
- Mock only external services (APIs, mail, file system) — not your own code.
- Keep tests independent — no shared state or test ordering dependencies.

## Coverage targets

- New features: at least happy path + validation error + auth failure.
- Bug fixes: the failing case becomes a test that stays in the suite.
- Security-sensitive code: all auth, CSRF, and validation paths.
- Refactors: existing test suite must pass before and after.

## References

- Read [references/testing-playbook.md](references/testing-playbook.md) for detailed testing patterns and examples.
