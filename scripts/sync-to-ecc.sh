#!/usr/bin/env bash
# Sync skill catalog and workflows to ~/.claude/skills/ecc for ECC integration.
# Usage: bash scripts/sync-to-ecc.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ECC_DIR="${ECC_DIR:-$HOME/.claude/skills/ecc}"

if [ ! -d "$ECC_DIR" ]; then
  echo "ECC directory not found: $ECC_DIR"
  echo "Create it first or set ECC_DIR to your ECC skills path."
  exit 1
fi

# Sync CATALOG.md as an ECC-readable skill index
cp "$REPO_ROOT/CATALOG.md" "$ECC_DIR/makis-agent-catalog.md"
echo "Synced CATALOG.md -> $ECC_DIR/makis-agent-catalog.md"

# Sync WORKFLOWS.md as an ECC-readable workflow reference
cp "$REPO_ROOT/WORKFLOWS.md" "$ECC_DIR/makis-agent-workflows.md"
echo "Synced WORKFLOWS.md -> $ECC_DIR/makis-agent-workflows.md"

# Sync CONTRIBUTING.md for reference
cp "$REPO_ROOT/CONTRIBUTING.md" "$ECC_DIR/makis-agent-contributing.md"
echo "Synced CONTRIBUTING.md -> $ECC_DIR/makis-agent-contributing.md"

echo ""
echo "Done. ECC catalog updated."
