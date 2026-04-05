# Incremental CRUD Migration

## Migration path

Use this order unless there is a strong reason not to:

1. Freeze the current behavior with tests.
2. Extract repository methods for repeated queries and mutations.
3. Extract service methods for create, update, delete, list, or show flows.
4. Reduce controller actions to orchestration only.
5. Simplify views after the controller contract is stable.

## Controller checklist

- Is input validation explicit?
- Is auth or authorization close to the mutation?
- Does the controller call named methods that describe intent?
- Can the controller be read top-to-bottom without scanning storage details?

## Repository checklist

- Are table or storage details centralized?
- Are method names intent-based?
- Are missing-record behaviors explicit?

## Service checklist

- Are business rules grouped by use case?
- Are dependencies obvious?
- Are errors translated into a controlled response path?
