# Performance Optimization Reference

## Profiling tools

| Tool | Use case |
|---|---|
| `EXPLAIN` / `EXPLAIN ANALYZE` | Inspect MySQL query execution plan; look for `type: ALL` (full scan) |
| PHP `microtime(true)` | Add before/after timestamps at controller and service entry points |
| Xdebug profiler | Function-level call graph; output to cachegrind; visualise with KCachegrind |
| Blackfire | Production-safe profiler with call timeline; preferred when Xdebug not available |
| MySQL slow query log | `long_query_time=0.5` to capture queries > 500 ms |
| `SHOW PROCESSLIST` | Live view of running queries; useful to catch lock waits |

## N+1 query detection and fix

**Symptom**: query count grows linearly with result set size.

**Detection**: log or intercept SQL in `Database::query()` in one request; count by prefix (`SELECT`, `INSERT`).

**Fix**: eager-load related data in the repository layer before returning the collection.

```php
// Before: N+1
$projects = $this->db->fetchAll("SELECT * FROM projects");
foreach ($projects as &$p) {
    $p['owner'] = $this->db->fetchOne(
        "SELECT * FROM users WHERE id = ?", [$p['user_id']]
    );
}

// After: 2 queries
$projects = $this->db->fetchAll("SELECT * FROM projects");
$ids = array_column($projects, 'user_id');
$owners = $this->db->fetchAll(
    "SELECT * FROM users WHERE id IN (" . implode(',', array_fill(0, count($ids), '?')) . ")",
    $ids
);
$ownerMap = array_column($owners, null, 'id');
foreach ($projects as &$p) {
    $p['owner'] = $ownerMap[$p['user_id']] ?? null;
}
```

## Missing index checklist

Run `EXPLAIN` on the query. If `type` is `ALL` or `index`, an index is missing or not used.

```sql
-- Check existing indexes
SHOW INDEX FROM projects;

-- Add composite index for common filter + sort pattern
ALTER TABLE projects ADD INDEX idx_user_status_created (user_id, status, created_at);

-- After adding, confirm EXPLAIN shows type: ref or range
EXPLAIN SELECT * FROM projects WHERE user_id = 1 AND status = 'active' ORDER BY created_at DESC;
```

Index guidelines:
- Index foreign key columns on child tables (`user_id`, `project_id`).
- Composite indexes: put equality columns first, range/order column last.
- Avoid over-indexing write-heavy tables; each index slows `INSERT` and `UPDATE`.
- Use `FORCE INDEX` only as a last resort; rewriting the query is usually better.

## Caching patterns

### APCu (in-process, single server)

```php
function getCachedProjects(int $userId): array
{
    $key = "projects_user_{$userId}";
    $cached = apcu_fetch($key, $success);
    if ($success) {
        return $cached;
    }
    $result = $this->projectRepository->findByUser($userId);
    apcu_store($key, $result, 300); // TTL: 5 min
    return $result;
}

// Invalidate on write
function saveProject(array $data): void
{
    $this->projectRepository->save($data);
    apcu_delete("projects_user_{$data['user_id']}");
}
```

### File cache (multi-server safe, simple)

```php
function getCachedExpensiveReport(string $reportKey): array
{
    $path = sys_get_temp_dir() . "/cache_{$reportKey}.json";
    if (file_exists($path) && (time() - filemtime($path)) < 600) {
        return json_decode(file_get_contents($path), true);
    }
    $result = $this->reportService->generate($reportKey);
    file_put_contents($path, json_encode($result));
    return $result;
}
```

### Cache key conventions

```
{entity}_{scope}_{identifier}
projects_user_42
report_monthly_2024_06
settings_global
```

Always include a version prefix when the data schema changes: `v2_projects_user_42`.

## Query optimisation patterns

### Pagination with keyset instead of OFFSET

```sql
-- OFFSET pagination degrades with large offsets (MySQL scans all rows up to offset)
SELECT * FROM projects ORDER BY id DESC LIMIT 20 OFFSET 1000;

-- Keyset pagination: constant cost regardless of page depth
SELECT * FROM projects WHERE id < :last_seen_id ORDER BY id DESC LIMIT 20;
```

### Count avoidance

```sql
-- Expensive: COUNT(*) on large table
SELECT COUNT(*) FROM projects WHERE user_id = ?;

-- Alternative: maintain a counter column on the parent, increment/decrement on write
SELECT project_count FROM users WHERE id = ?;
```

### Batch inserts

```php
// Avoid: one query per row
foreach ($rows as $row) {
    $this->db->execute(
        "INSERT INTO log_entries (level, message) VALUES (?, ?)",
        [$row['level'], $row['message']]
    );
}

// Prefer: single INSERT with multiple value groups
$placeholders = implode(',', array_fill(0, count($rows), '(?,?)'));
$values = array_merge(...array_map(fn($r) => [$r['level'], $r['message']], $rows));
$this->db->execute("INSERT INTO log_entries (level, message) VALUES $placeholders", $values);
```

## PHP-level optimizations

- **Avoid repeated `count()` in loops**: cache `$count = count($arr)` before the loop.
- **Avoid `array_key_exists` vs `isset`**: `isset` is faster and sufficient when the value is not `null`.
- **String concatenation in loops**: use `implode()` or collect into an array; concatenating `$str .= ...` in a large loop copies the string on every iteration.
- **OPcache**: ensure `opcache.enable=1` and `opcache.validate_timestamps=0` in production; reset after deploy.
- **Autoloader optimization**: run `composer dump-autoload --optimize` before deploy to generate a class map instead of file-path scanning.

## Benchmarking checklist

Before optimizing:
- [ ] Record baseline: page load time (browser), DB query count and total time (logged), memory peak (`memory_get_peak_usage()`).

After optimizing:
- [ ] Re-run baseline measurement under the same conditions.
- [ ] Confirm improvement meets target (e.g., query count < 5, response < 200 ms).
- [ ] Add a test or assertion that prevents regression (e.g., mock DB and assert `query()` called ≤ N times).
- [ ] Note the fix and before/after numbers in `makis-digital-memory` if the change is architectural.
