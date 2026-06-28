---
name: makis-digital-deployment
description: Deployment patterns for the makis-digital PHP project covering build steps, release workflows, environment configuration, health checks, and rollback procedures. Use when setting up or modifying deployment pipelines.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents managing PHP application deployment.
---

# Makis Digital Deployment

Use this skill when setting up deployment, writing CI/CD workflows, configuring environments, or planning release procedures for `makis-digital`.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand entry points and file structure.
- Read `references/knowledge/security-baseline.md` before handling secrets in deployment config.

## Deployment workflow

1. **Build** — install dependencies, run static analysis, run tests.
2. **Package** — create a deployable artifact (zip, tar, or container image).
3. **Deploy** — transfer artifact to target, run migrations, verify health.
4. **Verify** — run smoke tests against the deployed instance.
5. **Rollback** — if verification fails, revert to previous version.

## Environment configuration

| Env var | Purpose | Example |
|---|---|---|
| `APP_ENV` | Runtime environment | `production` |
| `APP_DEBUG` | Debug mode | `false` |
| `APP_URL` | Application base URL | `https://example.com` |
| `DB_*` | Database connection | — |
| `API_KEY_*` | External API keys | — |

- Keep all environment-specific config in environment variables, not in code.
- Use a `.env.example` file with documented defaults — never commit real `.env`.
- Validate required env vars at boot and fail fast if missing.

## Health checks

- `GET /health` — returns 200 if the application is running and can connect to the database.
- `GET /health/db` — returns 200 if the database connection is responsive.
- `GET /health/ready` — returns 200 if migrations are up to date.

## Rollback procedure

1. Identify the previous working version from deployment history.
2. Revert the artifact to that version.
3. Run reverse migration if the schema change is not backward-compatible.
4. Verify health checks pass.
5. Notify the team.

## CI/CD rules

- Run the full test suite before every deployment.
- Run security checks (lint, static analysis, dependency audit) in CI.
- Run database migrations as a separate step before code deployment when possible.
- Deploy to a staging environment first for non-trivial changes.
- Tag releases with semantic versioning.

## References

- Read [references/deployment-guide.md](references/deployment-guide.md) for the full deployment playbook.
