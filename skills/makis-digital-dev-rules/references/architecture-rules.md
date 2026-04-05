# Architecture Rules

## Preferred module shape

For non-trivial features, organize code in this direction:

- `Routes`: map URI to controller action.
- `Controller`: receive request data, call service, choose view or JSON response.
- `Service`: apply business rules and orchestration.
- `Repository` or persistence layer: read and write data source details.
- `Security`: authentication, authorization, CSRF, encoding, rate limiting, token logic.
- `View`: render already-prepared data.
- `Tests`: cover rules and regressions close to the feature.

## Controller rules

- Keep controllers thin.
- Avoid direct SQL or storage details in controllers unless the module is still trivial and the next refactor step is documented.
- Do not duplicate request validation across multiple actions when a reusable validator or request object would help.

## Service rules

- Create a service when logic is reused, branching, security-sensitive, or bigger than simple CRUD wiring.
- Make service inputs explicit.
- Keep side effects easy to trace.

## Persistence rules

- Centralize query patterns that are reused.
- Avoid spreading table field names across many files.
- Keep storage-specific work behind methods that express intent such as `findById`, `create`, `update`, `delete`, `listRecent`.

## View rules

- Pass only data needed by the template.
- Escape output at render time.
- Avoid authorization and persistence logic in templates.

## Refactor path for this project

When touching a CRUD module, prefer this sequence:

1. Stabilize behavior with tests.
2. Extract repeated validation.
3. Extract persistence into a repository.
4. Extract business rules into a service.
5. Simplify controller actions to orchestration only.
