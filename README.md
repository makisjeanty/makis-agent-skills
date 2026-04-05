# Makis Agent Skills

Reusable local skill repository for Codex and Agent Skills-compatible coding agents.

## Included skills

- `makis-digital-dev-rules`
- `makis-digital-crud-refactor`
- `makis-digital-security-review`
- `makis-digital-test-first-bugfix`

## Repository layout

- `skills/`
  Self-contained skills with `SKILL.md`, agent metadata, references, and embedded knowledge.
- `CATALOG.md`
  Quick map of skills and starter bundles.
- `WORKFLOWS.md`
  Ordered playbooks for common work patterns.
- `scripts/sync-to-codex.ps1`
  Copies all repository skills into `~/.codex/skills`.
- `scripts/validate-skills.py`
  Validates skill frontmatter and required files for CI and local checks.

## Install or sync to Codex

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-codex.ps1
```

Then restart Codex so newly installed or updated skills are picked up.

## Validate locally

Run:

```powershell
python .\scripts\validate-skills.py
```

The same validation runs in GitHub Actions on push and pull request.
