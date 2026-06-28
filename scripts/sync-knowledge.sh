#!/usr/bin/env bash
# Propagate shared knowledge files from makis-digital-dev-rules to all other skills.
# Skills with a .no-sync marker file are skipped.
# Usage: bash scripts/sync-knowledge.sh

set -euo pipefail

REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
SKILLS_ROOT="$REPO_ROOT/skills"
SOURCE_KNOWLEDGE="$SKILLS_ROOT/makis-digital-dev-rules/references/knowledge"

if [ ! -d "$SOURCE_KNOWLEDGE" ]; then
  echo "Error: Knowledge source not found: $SOURCE_KNOWLEDGE" >&2
  exit 1
fi

synced=0
skipped=0

for skill_dir in "$SKILLS_ROOT"/*/; do
  skill_name="$(basename "$skill_dir")"

  # Never sync back to the source skill
  if [ "$skill_name" = "makis-digital-dev-rules" ]; then
    continue
  fi

  if [ -f "$skill_dir/.no-sync" ]; then
    echo "Skipped $skill_name (.no-sync)"
    skipped=$((skipped + 1))
    continue
  fi

  dest_knowledge="$skill_dir/references/knowledge"
  if [ ! -d "$dest_knowledge" ]; then
    mkdir -p "$dest_knowledge"
  fi

  cp "$SOURCE_KNOWLEDGE"/*.md "$dest_knowledge/"
  echo "Synced knowledge -> $skill_name"
  synced=$((synced + 1))
done

echo ""
echo "Done. $synced skill(s) updated, $skipped skipped."
