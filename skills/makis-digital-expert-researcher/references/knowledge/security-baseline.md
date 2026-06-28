# Security Baseline

- Session bootstrap is configured in `public/index.php`.
- CSRF uses `src/Security/CsrfToken.php`.
- Auth uses `src/Security/Auth.php`.
- Validation and output encoding are centralized in `src/Security`.
- API auth uses JWT support in `src/Security/JwtToken.php`.
- Browser mutations should keep CSRF protection.
