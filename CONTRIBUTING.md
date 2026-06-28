# Contributing

Thanks for contributing to `makis-agent-skills`!

## Adding a new skill

1. **Scaffold** the skill structure:
   ```bash
   make scaffold NAME=my-new-skill DESC="What it does"
   # or: bash scripts/skill-scaffold.sh makis-digital-my-new-skill --description "..."
   ```

2. **Edit** `skills/makis-digital-my-new-skill/SKILL.md`:
   - Keep the workflow focused and concrete.
   - Add `## Knowledge loading`, `## Workflow`, `## Rules`, `## Gotchas` sections.
   - Reference the shared knowledge files under `references/knowledge/`.

3. **Add a reference file** at `references/<topic>.md` with detailed patterns.

4. **Register the skill** in these files:
   - `CATALOG.md` — add to Core skills and add a starter bundle if appropriate.
   - `skills/makis-digital-dev-rules/references/skill-catalog.md` — same as CATALOG.
   - `skills/makis-digital-dev-rules/SKILL.md` — add to Specialized skills section.

5. **Validate**:
   ```bash
   make validate-all
   ```

## Skill structure

```
skills/makis-digital-<name>/
  SKILL.md              # Main skill file (required)
  agents/
    openai.yaml         # Agent metadata (required)
  references/
    <name>.md           # Detailed reference content
    knowledge/          # Shared project knowledge (copied from dev-rules)
```

## Naming conventions

- Skill directory name: `makis-digital-<hyphenated-name>`.
- `SKILL.md` `name` field must match the directory name.
- Reference files use the topic name without the `makis-digital-` prefix.

## Quality checklist

- [ ] SKILL.md has valid YAML frontmatter with `name`, `description`, `license`, `metadata`.
- [ ] `agents/openai.yaml` exists with `display_name`, `short_description`, `default_prompt`.
- [ ] All relative markdown links resolve to existing files.
- [ ] The skill is registered in CATALOG.md and dev-rules references/skill-catalog.md.
- [ ] `make validate-all` passes.

## Pull request process

1. Run `make validate-all` before opening a PR.
2. Keep PRs focused on one skill or logical group of changes.
3. Reference any issues the PR addresses.
