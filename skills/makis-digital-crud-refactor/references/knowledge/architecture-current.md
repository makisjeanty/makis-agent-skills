# Current Architecture

- Active runtime code lives in `src/`.
- CRUD changes usually touch `config/routes.php`, controllers in `src/Controllers`, templates in `views/`, and tests in `tests/`.
- Persistence is currently JSON-backed through `src/Database/Database.php`.
