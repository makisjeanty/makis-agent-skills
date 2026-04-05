# Module Blueprint

Use this blueprint when creating or upgrading a CRUD module.

## Suggested files

- `src/Controllers/<Feature>Controller.php`
- `src/Services/<Feature>Service.php`
- `src/Repositories/<Feature>Repository.php`
- `src/Validators/<Feature>Validator.php` if validation becomes non-trivial
- `views/<feature>/...`
- `tests/<Feature>...Test.php`

## Responsibility split

- Controller: HTTP concerns
- Service: use-case rules
- Repository: data access
- Validator: reusable input validation rules
- View: HTML rendering only

## Incremental migration strategy

If the feature already exists inside a controller:

1. Keep current routes.
2. Add tests around current behavior.
3. Extract read and write operations to a repository.
4. Extract business rules to a service.
5. Keep controller public API stable while moving internals.

## Definition of done

- behavior works
- tests cover happy path and failure path
- security checks are present
- naming is clear
- no duplicated validation in sibling actions
