#!/usr/bin/env bash
# Sync skill catalog and workflows to ~/.claude/skills/ecc for ECC integration.
# Usage: bash scripts/sync-to-ecc.sh

set -euo pipefail

REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
ECC_DIR="${ECC_DIR:-$HOME/.claude/skills/ecc}"

if [ ! -d "$ECC_DIR" ]; then
  echo "ECC directory not found: $ECC_DIR"
  echo "Create it first or set ECC_DIR to your ECC skills path."
  exit 1
fi

_sync_file() {
  local src="$1" dest="$2" label="$3"
  if [ ! -f "$src" ]; then
    echo "Error: Source file not found: $src" >&2
    exit 1
  fi
  cp "$src" "$dest"
  echo "Synced $label -> $dest"
}

_sync_file "$REPO_ROOT/CATALOG.md"      "$ECC_DIR/makis-agent-catalog.md"      "CATALOG.md"
_sync_file "$REPO_ROOT/WORKFLOWS.md"    "$ECC_DIR/makis-agent-workflows.md"    "WORKFLOWS.md"
_sync_file "$REPO_ROOT/CONTRIBUTING.md" "$ECC_DIR/makis-agent-contributing.md" "CONTRIBUTING.md"

echo ""
echo "Done. ECC catalog updated."
