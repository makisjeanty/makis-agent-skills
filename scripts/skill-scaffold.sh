#!/usr/bin/env bash
# Scaffold a new makis-digital skill with standard structure.
# Usage: bash scripts/skill-scaffold.sh <skill-name> [--description "..."]

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ $# -lt 1 ]; then
  echo "Usage: bash scripts/skill-scaffold.sh <skill-name> [--description \"...\"]"
  echo ""
  echo "Examples:"
  echo "  bash scripts/skill-scaffold.sh makis-digital-cache-patterns"
  echo "  bash scripts/skill-scaffold.sh makis-digital-cache-patterns --description \"Caching strategies for PHP\""
  exit 1
fi

SKILL_NAME="$1"
DESCRIPTION=""
MAINTAINER="${GIT_AUTHOR_NAME:-$(whoami)}"

# Parse optional --description flag
while [ $# -gt 0 ]; do
  case "$1" in
    --description) shift; DESCRIPTION="$1" ;;
  esac
  shift
done

REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
SKILL_DIR="$REPO_ROOT/skills/$SKILL_NAME"

# Validate skill name format
if ! echo "$SKILL_NAME" | grep -qE '^[a-z0-9]+(-[a-z0-9]+)*$'; then
  echo -e "${RED}Error:${NC} Skill name must be lowercase alphanumeric with hyphens."
  exit 1
fi

if [ -d "$SKILL_DIR" ]; then
  echo -e "${RED}Error:${NC} Skill already exists: $SKILL_DIR"
  exit 1
fi

# Remove partially created directory if any subsequent step fails
trap 'rm -rf "$SKILL_DIR"' ERR

if [ -z "$DESCRIPTION" ]; then
  DESCRIPTION="Description for $SKILL_NAME"
fi

# Create directories
mkdir -p "$SKILL_DIR/agents"
mkdir -p "$SKILL_DIR/references"
mkdir -p "$SKILL_DIR/references/knowledge"

# Copy shared knowledge files from dev-rules (only if source files exist)
KNOWLEDGE_SOURCE="$REPO_ROOT/skills/makis-digital-dev-rules/references/knowledge"
if [ -d "$KNOWLEDGE_SOURCE" ]; then
  knowledge_files=("$KNOWLEDGE_SOURCE"/*.md)
  if [ -e "${knowledge_files[0]}" ]; then
    cp "${knowledge_files[@]}" "$SKILL_DIR/references/knowledge/"
  fi
fi

# Create SKILL.md
cat > "$SKILL_DIR/SKILL.md" << SKILLEOF
---
name: $SKILL_NAME
description: $DESCRIPTION
license: MIT
metadata:
  maintainer: ${MAINTAINER}
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents.
---

# $(echo "$SKILL_NAME" | sed 's/[^-]*-//' | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')

TODO: Write skill description.

## Knowledge loading

- Read \`references/knowledge/architecture-current.md\` for project structure.
- Read \`references/knowledge/decisions.md\` for past decisions.
- Read \`references/knowledge/security-baseline.md\` for security controls.
- Read \`references/knowledge/crud-projects-pattern.md\` for CRUD conventions.

## Workflow

1. TODO: Step one.
2. TODO: Step two.
3. TODO: Step three.

## Rules

- TODO: Rule one.
- TODO: Rule two.

## Gotchas

- TODO: Gotcha one.

## References

- Read [references/$(echo "$SKILL_NAME" | sed 's/makis-digital-//').md](references/$(echo "$SKILL_NAME" | sed 's/makis-digital-//').md) for detailed patterns.
SKILLEOF

# Create agents/openai.yaml
cat > "$SKILL_DIR/agents/openai.yaml" << YAMLEOF
interface:
  display_name: "$(echo "$SKILL_NAME" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')"
  short_description: "$DESCRIPTION"
  default_prompt: "Use \$$SKILL_NAME to TODO."
YAMLEOF

# Create empty reference file
REF_NAME="$(echo "$SKILL_NAME" | sed 's/makis-digital-//')"
cat > "$SKILL_DIR/references/$REF_NAME.md" << REFEOF
# $(echo "$REF_NAME" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')

TODO: Write reference content.
REFEOF

echo -e "${GREEN}Created skill:${NC} $SKILL_DIR"
echo ""
echo "  SKILL.md"
echo "  agents/openai.yaml"
echo "  references/$REF_NAME.md"
echo "  references/knowledge/ (shared)"
echo ""
echo "Next steps:"
echo "  1. Edit SKILL.md with your workflow and rules."
echo "  2. Edit references/$REF_NAME.md with detailed content."
echo "  3. Add the skill to CATALOG.md and dev-rules references/skill-catalog.md."
echo "  4. Run: python3 scripts/validate-skills.py"
