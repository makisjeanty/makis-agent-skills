#!/usr/bin/env bash
# Sync all repository skills to ~/.claude/skills/ for Claude Code.
# Usage: bash scripts/sync-to-claude.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SOURCE="$REPO_ROOT/skills"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SKILLS_DEST="$CLAUDE_HOME/skills"

if [ ! -d "$SKILLS_SOURCE" ]; then
  echo "Error: Skills source not found: $SKILLS_SOURCE"
  exit 1
fi

mkdir -p "$SKILLS_DEST"

count=0
for skill_dir in "$SKILLS_SOURCE"/*/; do
  skill_name="$(basename "$skill_dir")"
  dest="$SKILLS_DEST/$skill_name"

  if [ -d "$dest" ]; then
    rm -rf "$dest"
  fi

  cp -r "$skill_dir" "$dest"
  echo "Synced $skill_name -> $dest"
  count=$((count + 1))
done

echo ""
echo "Done. $count skill(s) synced to $SKILLS_DEST."
echo "Restart Claude Code to load updated skills."
