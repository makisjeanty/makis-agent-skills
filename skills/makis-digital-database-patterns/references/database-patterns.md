# Database Patterns

Use this playbook when designing or refactoring persistence in `makis-digital`.

## Repository pattern

- One repository class per entity or aggregate.
- Methods named after domain operations: `findById`, `findActive`, `save`, `delete`.
- Repositories receive the storage dependency through constructor injection.
- Repositories return domain objects, not raw arrays or storage rows.

## Query organization

- Keep simple CRUD queries in the repository.
- Extract complex queries (joins, aggregations, reports) into dedicated query classes or service methods.
- Name query methods after intent, not SQL structure: `findProjectsByStatus` not `selectWhereStatus`.

## Migration workflow

- Schema changes go through a migration script or sequence.
- Each migration is reversible when possible.
- Migrations are tested against a copy of the schema before applying to shared environments.
- Migration files are versioned and ordered.

## Data integrity

- Use transactions for multi-step writes.
- Validate data before persisting — use the same validator the controller uses.
- Set explicit default values in the schema for nullable columns.
- Avoid storing serialized objects or arrays in single columns when a normalized structure is possible.

## Safe query practices

- Always use parameterized queries or prepared statements.
- Validate sort and filter parameters from user input against an allow-list of columns.
- Apply pagination limits at the query level, not by loading all rows and slicing in memory.
