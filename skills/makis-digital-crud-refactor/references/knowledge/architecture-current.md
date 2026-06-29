# Current Architecture

- Active runtime code lives in `src/`, not `app/`.
- Entry point is `public/index.php`.
- Routes are registered in `config/routes.php`.
- Templates live in `views/`.
- Tests live in `tests/`.
- Security utilities live in `src/Security`.
- Persistence currently uses a JSON-backed storage layer behind SQL-like methods in `src/Database`.
