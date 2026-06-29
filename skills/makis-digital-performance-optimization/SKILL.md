---
name: makis-digital-performance-optimization
description: Query tuning, caching strategies, and PHP performance profiling for the makis-digital codebase. Use when pages are slow, queries are inefficient, or a feature needs caching before going to production.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents working on PHP application codebases.
---

# Makis Digital Performance Optimization

Use this skill when a feature is slow, a database query is too expensive, or you need to add caching to a hot path. Do not optimize speculatively — profile first, then fix what the data shows.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` for project structure before locating the slow path.
- Read `references/knowledge/crud-projects-pattern.md` when the bottleneck is in the projects CRUD flow.
- Read `references/knowledge/security-baseline.md` when the fix involves caching user-specific or session-bound data.

## Workflow

1. **Profile** — identify the slow path before touching code. Use `EXPLAIN` / `EXPLAIN ANALYZE` for SQL, log execution time at controller and service boundaries, use Xdebug or Blackfire if available.
2. **Classify** — determine the root cause: N+1 query, missing index, excessive computation, repeated external calls, large unindexed result sets, missing cache.
3. **Scope** — establish a measurable target (e.g., reduce query count from 32 to 3, response time from 1.2 s to < 200 ms).
4. **Fix** — apply the smallest targeted change: add index, eager-load relations, add a cache layer, batch queries, or extract expensive computation to a background job.
5. **Verify** — re-run the profile baseline to confirm improvement. Add a regression test or benchmark if the path is business-critical.
6. **Document** — capture the decision in `makis-digital-memory` if the fix changes an architectural boundary (e.g., adding a cache layer, switching query strategy).

## Rules

- Never optimize without a measured baseline. Guessed optimizations create complexity without guaranteed benefit.
- Add a cache only after confirming the data is safe to cache: no user-specific writes, expiry set to the shortest acceptable TTL.
- Prefer database-level fixes (index, query rewrite) over application-level workarounds (PHP in-memory dedup, array loops) when the bottleneck is in SQL.
- Keep cache invalidation explicit: cache is invalidated in the same service method that writes the underlying data.
- Do not cache partial or inconsistent state: cache the full object or result, never a mid-transaction snapshot.
- Apply `makis-digital-security-review` before caching anything that contains auth tokens, CSRF tokens, or user PII.
- Always test cache-miss and cache-hit paths in the test suite.

## Gotchas

- **Stampede risk**: without a lock or single-flight pattern, high-traffic cache misses can all hit the DB simultaneously. Use a mutex or pre-warming for hot keys.
- **N+1 in views**: lazy-loaded relations called inside a loop (e.g., `foreach ($projects as $p) { $p->owner->name }`) generate one query per row. Eager-load in the repository.
- **`SELECT *` in tight loops**: column projection reduces data transfer and memory; matters most for wide tables or large result sets.
- **Index on foreign key, not just primary key**: `JOIN` and `WHERE` on foreign key columns need an index on the child table; MySQL does not add these automatically.
- **APC/OPcache state after deploy**: OPcache caches compiled PHP bytecode. After a deploy, trigger `opcache_reset()` or restart PHP-FPM; stale bytecode causes subtle bugs.
- **Session-bound cache**: never cache a response that contains session-specific data in a shared cache (APCu, Redis) without scoping the cache key to the session or user ID.

## References

- Read [references/performance-optimization.md](references/performance-optimization.md) for query patterns, caching recipes, and benchmarking checklists.
