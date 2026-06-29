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

@test "sync-to-ecc exits 1 with clear message when CATALOG.md is missing" {
  mkdir -p "$TEMP_DIR/ecc"
  # Fake repo root without CATALOG.md
  FAKE_ROOT="$TEMP_DIR/fake-repo"
  mkdir -p "$FAKE_ROOT"
  export ECC_DIR="$TEMP_DIR/ecc"
  export REPO_ROOT="$FAKE_ROOT"
  run bash "$SYNC_ECC_SCRIPT"
  unset REPO_ROOT
  [ "$status" -eq 1 ]
  [[ "$output" == *"Source file not found"* ]]
}

# ── sync-to-claude.sh: partial failure handling ────────────────────────────

_make_failing_cp_mock() {
  local mock_dir="$1" fail_pattern="$2"
  mkdir -p "$mock_dir"
  cat > "$mock_dir/cp" << MOCKEOF
#!/usr/bin/env bash
if [[ "\$*" == *"$fail_pattern"* ]]; then
  echo "cp: cannot copy $fail_pattern: simulated failure" >&2
  exit 1
fi
exec /bin/cp "\$@"
MOCKEOF
  chmod +x "$mock_dir/cp"
}

@test "sync-to-claude continues syncing after one skill fails" {
  FAKE_ROOT="$TEMP_DIR/fake-repo"
  mkdir -p "$FAKE_ROOT/skills/skill-a"
  echo "good" > "$FAKE_ROOT/skills/skill-a/SKILL.md"
  mkdir -p "$FAKE_ROOT/skills/skill-bad"
  echo "bad" > "$FAKE_ROOT/skills/skill-bad/SKILL.md"
  mkdir -p "$FAKE_ROOT/skills/skill-z"
  echo "good" > "$FAKE_ROOT/skills/skill-z/SKILL.md"

  MOCK_BIN="$TEMP_DIR/bin"
  _make_failing_cp_mock "$MOCK_BIN" "skill-bad"

  export CLAUDE_HOME="$TEMP_DIR/claude"
  export REPO_ROOT="$FAKE_ROOT"
  export PATH="$MOCK_BIN:$PATH"
  run bash "$SYNC_CLAUDE_SCRIPT"

  [ "$status" -eq 1 ]
  # Both non-failing skills should have been synced
  [ -d "$TEMP_DIR/claude/skills/skill-a" ]
  [ -d "$TEMP_DIR/claude/skills/skill-z" ]
}

@test "sync-to-claude exits non-zero and reports failed skill name" {
  FAKE_ROOT="$TEMP_DIR/fake-repo2"
  mkdir -p "$FAKE_ROOT/skills/skill-a"
  echo "good" > "$FAKE_ROOT/skills/skill-a/SKILL.md"
  mkdir -p "$FAKE_ROOT/skills/skill-bad"
  echo "bad" > "$FAKE_ROOT/skills/skill-bad/SKILL.md"

  MOCK_BIN="$TEMP_DIR/bin2"
  _make_failing_cp_mock "$MOCK_BIN" "skill-bad"

  export CLAUDE_HOME="$TEMP_DIR/claude"
  export REPO_ROOT="$FAKE_ROOT"
  export PATH="$MOCK_BIN:$PATH"
  run bash "$SYNC_CLAUDE_SCRIPT"

  [ "$status" -eq 1 ]
  [[ "$output" == *"skill-bad"* ]]
}
