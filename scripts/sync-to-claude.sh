#!/usr/bin/env bash
# Sync all repository skills to ~/.claude/skills/ for Claude Code.
# Usage: bash scripts/sync-to-claude.sh

set -uo pipefail

REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
SKILLS_SOURCE="$REPO_ROOT/skills"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SKILLS_DEST="$CLAUDE_HOME/skills"

if [ ! -d "$SKILLS_SOURCE" ]; then
  echo "Error: Skills source not found: $SKILLS_SOURCE"
  exit 1
fi

mkdir -p "$SKILLS_DEST"

count=0
failed_skills=()

for skill_dir in "$SKILLS_SOURCE"/*/; do
  skill_name="$(basename "$skill_dir")"
  dest="$SKILLS_DEST/$skill_name"

  if [ -d "$dest" ]; then
    rm -rf "$dest"
  fi

  if cp -r "$skill_dir" "$dest"; then
    echo "Synced $skill_name -> $dest"
    count=$((count + 1))
  else
    echo "Error: Failed to sync $skill_name" >&2
    failed_skills+=("$skill_name")
  fi
done

echo ""
echo "Done. $count skill(s) synced to $SKILLS_DEST."

if [ ${#failed_skills[@]} -gt 0 ]; then
  echo "Failed skills (${#failed_skills[@]}):" >&2
  for name in "${failed_skills[@]}"; do
    echo "  - $name" >&2
  done
  exit 1
fi

echo "Restart Claude Code to load updated skills."
