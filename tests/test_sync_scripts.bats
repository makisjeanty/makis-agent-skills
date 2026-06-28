#!/usr/bin/env bats

REPO_ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
SYNC_CLAUDE_SCRIPT="$REPO_ROOT/scripts/sync-to-claude.sh"
SYNC_ECC_SCRIPT="$REPO_ROOT/scripts/sync-to-ecc.sh"

setup() {
  TEMP_DIR="$(mktemp -d)"
}

teardown() {
  rm -rf "$TEMP_DIR"
}

# ── sync-to-claude.sh ──────────────────────────────────────────────────────

@test "sync-to-claude creates CLAUDE_HOME/skills destination" {
  export CLAUDE_HOME="$TEMP_DIR/claude"
  run bash "$SYNC_CLAUDE_SCRIPT"
  [ "$status" -eq 0 ]
  [ -d "$TEMP_DIR/claude/skills" ]
}

@test "sync-to-claude syncs at least one skill directory" {
  export CLAUDE_HOME="$TEMP_DIR/claude"
  run bash "$SYNC_CLAUDE_SCRIPT"
  [ "$status" -eq 0 ]
  skill_count=$(ls "$TEMP_DIR/claude/skills" | wc -l)
  [ "$skill_count" -gt 0 ]
}

@test "sync-to-claude output reports skill count" {
  export CLAUDE_HOME="$TEMP_DIR/claude"
  run bash "$SYNC_CLAUDE_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"skill(s) synced"* ]]
}

@test "sync-to-claude output mentions restart instruction" {
  export CLAUDE_HOME="$TEMP_DIR/claude"
  run bash "$SYNC_CLAUDE_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Restart"* ]]
}

@test "sync-to-claude re-sync overwrites existing destination" {
  export CLAUDE_HOME="$TEMP_DIR/claude"
  bash "$SYNC_CLAUDE_SCRIPT"
  run bash "$SYNC_CLAUDE_SCRIPT"
  [ "$status" -eq 0 ]
}

# ── sync-to-ecc.sh ──────────────────────────────────────────────────────────

@test "sync-to-ecc exits 1 when ECC_DIR does not exist" {
  export ECC_DIR="$TEMP_DIR/nonexistent-ecc"
  run bash "$SYNC_ECC_SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" == *"ECC directory not found"* ]]
}

@test "sync-to-ecc copies CATALOG.md as makis-agent-catalog.md" {
  mkdir -p "$TEMP_DIR/ecc"
  export ECC_DIR="$TEMP_DIR/ecc"
  run bash "$SYNC_ECC_SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$TEMP_DIR/ecc/makis-agent-catalog.md" ]
}

@test "sync-to-ecc copies WORKFLOWS.md as makis-agent-workflows.md" {
  mkdir -p "$TEMP_DIR/ecc"
  export ECC_DIR="$TEMP_DIR/ecc"
  run bash "$SYNC_ECC_SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$TEMP_DIR/ecc/makis-agent-workflows.md" ]
}

@test "sync-to-ecc copies CONTRIBUTING.md as makis-agent-contributing.md" {
  mkdir -p "$TEMP_DIR/ecc"
  export ECC_DIR="$TEMP_DIR/ecc"
  run bash "$SYNC_ECC_SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$TEMP_DIR/ecc/makis-agent-contributing.md" ]
}

@test "sync-to-ecc reports done on success" {
  mkdir -p "$TEMP_DIR/ecc"
  export ECC_DIR="$TEMP_DIR/ecc"
  run bash "$SYNC_ECC_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Done"* ]]
}

@test "sync-to-ecc catalog content matches repo CATALOG.md" {
  mkdir -p "$TEMP_DIR/ecc"
  export ECC_DIR="$TEMP_DIR/ecc"
  bash "$SYNC_ECC_SCRIPT"
  diff "$REPO_ROOT/CATALOG.md" "$TEMP_DIR/ecc/makis-agent-catalog.md"
}
