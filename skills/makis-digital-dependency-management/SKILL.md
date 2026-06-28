---
name: makis-digital-dependency-management
description: Dependency management patterns for the makis-digital PHP project covering Composer workflows, update strategies, security auditing, and version policies. Use when adding, updating, or auditing project dependencies.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents managing PHP project dependencies via Composer.
---

# Makis Digital Dependency Management

Use this skill when adding a new dependency, updating existing packages, auditing for vulnerabilities, or reviewing the project's dependency strategy.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand how dependencies are loaded.
- Read `references/knowledge/security-baseline.md` before adding packages that handle auth, input, or output.
- Read `references/knowledge/decisions.md` for past dependency choices.

## Adding a dependency

1. Question whether the dependency is necessary — can you write it in 20 lines or less?
2. Check the package's maintenance: last release, PHP version support, open issues.
3. Prefer packages with stable releases, active maintenance, and a public repository.
4. Install with exact version constraint: `composer require "vendor/package:^x.y"`.
5. Review the package's own dependencies for conflicts and security issues.
6. After install, commit both `composer.json` and `composer.lock`.

## Update workflow

1. Review changelog and breaking changes before updating.
2. Update dev dependencies separately from production dependencies.
3. Run the full test suite after any update.
4. Run `composer audit` after updates to check for known vulnerabilities.
5. Update one major version at a time when possible — do not skip versions.

## Security audit

- Run `composer audit` regularly to check for known vulnerabilities.
- Review `composer audit` output for severity and applicable scope.
- Apply security patches promptly for production dependencies.
- Consider using a dependency auditing tool in CI.

## Version policy

| Type | Constraint | Rationale |
|---|---|---|
| Production | `^x.y` | Safe minor and patch updates |
| Dev | `^x.y` | Same as production |
| New / experimental | `@beta` or `@alpha` | Only for evaluation, pin exact version |
| Abandoned | Replace immediately | Security risk |

## composer.json hygiene

- Keep `require` and `require-dev` clearly separated.
- Remove unused dependencies — do not leave abandoned packages in `composer.json`.
- Document why a specific version constraint exists if it is not the latest.
- Keep the PHP version constraint realistic: `"php": ">=8.1"`.

## References

- Read [references/dependency-guide.md](references/dependency-guide.md) for detailed dependency management workflows.
