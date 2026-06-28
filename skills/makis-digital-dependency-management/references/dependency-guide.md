# Dependency Guide

Dependency management workflows for `makis-digital`.

## Adding a package checklist

- [ ] Is this package really needed? Could 20 lines of project code replace it?
- [ ] Is the package actively maintained? Check last release date.
- [ ] Does it support the project's PHP version?
- [ ] Does it have a security policy and history of patching vulnerabilities?
- [ ] Are its own dependencies compatible with the project's existing packages?
- [ ] Is there a stable release (not alpha/beta/ dev)?
- [ ] Has `composer audit` been run after install?

## Regular maintenance

```bash
# Check for outdated packages
composer outdated

# Update all minor/patch versions
composer update

# Update a single package
composer update vendor/package

# Check for known vulnerabilities
composer audit

# Remove unused dependency
composer remove vendor/package
```

## CI checks

```yaml
# Example CI steps
- name: Validate composer.json
  run: composer validate --strict

- name: Install dependencies
  run: composer install --no-interaction --prefer-dist

- name: Security audit
  run: composer audit

- name: Check for abandoned packages
  run: composer outdated --direct --abandoned
```

## When to replace a dependency

| Signal | Action |
|---|---|
| No releases in 2+ years | Evaluate alternatives |
| PHP version no longer supported | Fork or replace |
| Known unpatched CVE | Replace immediately |
| Package abandoned | Remove or replace |
| Breaking changes in every minor | Pin exact version, evaluate alternatives |

## Lock file management

- Always commit `composer.lock` to version control.
- Never edit `composer.lock` manually — use `composer update` or `composer require`.
- Keep `composer.lock` in sync across environments via CI validation.
- Review `composer.lock` diff in PRs for unexpected dependency changes.
