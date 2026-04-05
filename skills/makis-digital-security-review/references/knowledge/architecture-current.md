# Current Architecture

- Security controls are mostly centralized in `src/Security`.
- Entry flow begins in `public/index.php` and `config/routes.php`.
- Both browser and API flows exist and must be reviewed separately.
