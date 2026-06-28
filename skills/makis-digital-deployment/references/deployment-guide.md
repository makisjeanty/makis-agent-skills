# Deployment Guide

Deployment procedures for `makis-digital`.

## Prerequisites

- PHP 8.1+ with required extensions
- Composer dependencies installed
- Database server accessible
- Web server configured (nginx or Apache)

## Build step (CI)

```bash
composer install --no-dev --optimize-autoloader
php vendor/bin/phpunit --coverage-text
# Run static analysis if configured
# Run security audit: composer audit
```

## Release tagging

- Use semantic versioning: `v{major}.{minor}.{patch}`.
- Tag from main branch after review and passing CI.
- Write release notes summarizing changes and migration steps.

## Environment checklist

- [ ] `APP_ENV=production`, `APP_DEBUG=false`
- [ ] Database credentials configured via env vars
- [ ] Application key / JWT secret generated and stored securely
- [ ] File permissions correct (web server can write to uploads, cache)
- [ ] PHP extensions: PDO, mbstring, json, curl, fileinfo
- [ ] HTTPS configured and HTTP redirects to HTTPS
- [ ] Error logging configured to file or service (not display)

## Health check endpoints

```php
// config/routes.php
$router->get('/health', function () {
    return jsonResponse(['status' => 'ok']);
});

$router->get('/health/db', function () use ($db) {
    $db->query('SELECT 1');
    return jsonResponse(['status' => 'ok', 'db' => 'connected']);
});
```

## Rollback script

```bash
# Revert to previous release
DEPLOY_DIR=/var/www/makis-digital
PREVIOUS_RELEASE=$(ls -t $DEPLOY_DIR/releases | head -2 | tail -1)

ln -sfn $DEPLOY_DIR/releases/$PREVIOUS_RELEASE $DEPLOY_DIR/current

# Run rollback migration if needed
# php $DEPLOY_DIR/current/bin/migrate rollback

# Restart php-fpm if needed
# sudo systemctl reload php8.1-fpm

# Verify health
curl -f http://localhost/health && echo "Rollback successful"
```
