---
name: makis-digital-database-patterns
description: Database access patterns for the makis-digital PHP project covering persistence layer design, query organization, migration workflows, and data integrity. Use when designing repositories, writing data access code, planning schema changes, or optimizing queries.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents working with persistence layers in PHP projects.
---

# Makis Digital Database Patterns

Use this skill when the task involves data persistence, schema changes, query design, or repository organization in `makis-digital`.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` before changing how data access is structured.
- Read `references/knowledge/decisions.md` before changing the storage backend or migration approach.
- Read `references/knowledge/crud-projects-pattern.md` when working on the `projects` persistence layer.
- Read `references/knowledge/security-baseline.md` when persistence touches authentication, sessions, or user data.

## Workflow

1. Understand the current persistence layer before proposing changes.
2. Keep query logic in a dedicated repository or persistence class — do not scatter SQL or file access across controllers.
3. Use parameterized queries or prepared statements for all dynamic values — never concatenate input into queries.
4. Add focused persistence tests for read, write, update, and delete paths.
5. Document the schema and key query patterns in the project knowledge base.

## Architecture rules

- Keep persistence details behind a repository or database-focused layer.
- Keep repositories stateless and focused on one entity or aggregate.
- Keep transaction logic at the service layer, not inside repositories.
- Keep schema decisions (table structure, file format, index strategy) documented and reviewable.

## Persistence patterns

- Use repositories for entity reads and writes.
- Use a dedicated migration workflow for schema changes — never alter schema directly in production.
- Use transactions for operations that modify multiple related records.
- Use pagination for list queries that may return many rows.

## Testing rules

- Test each repository method with real read, write, update, and delete operations.
- Cover edge cases: empty result sets, duplicate keys, missing records, concurrent writes.
- Use a test database or isolated storage to avoid polluting development data.
- Cover transaction rollback and error recovery paths.

## Gotchas

- Do not mix view formatting logic into persistence classes.
- Do not bypass the repository layer for "one-off" queries — extract a method instead.
- Do not add indexes without understanding the query patterns they serve.
- Do not use the same connection or store for test and development data.

## References

- Read [references/database-patterns.md](references/database-patterns.md) for the detailed database playbook.
