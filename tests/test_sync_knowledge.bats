#!/usr/bin/env bats

REPO_ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
SCRIPT="$REPO_ROOT/scripts/sync-knowledge.sh"

setup() {
  TEMP_REPO="$(mktemp -d)"

  # Minimal fake repo: source skill with 2 knowledge files
  SOURCE_KNOWLEDGE="$TEMP_REPO/skills/makis-digital-dev-rules/references/knowledge"
  mkdir -p "$SOURCE_KNOWLEDGE"
  echo "# Architecture" > "$SOURCE_KNOWLEDGE/architecture-current.md"
  echo "# Decisions"    > "$SOURCE_KNOWLEDGE/decisions.md"

  # Skill A — will be synced
  mkdir -p "$TEMP_REPO/skills/skill-a/references/knowledge"

  # Skill B — will be synced (no .no-sync)
  mkdir -p "$TEMP_REPO/skills/skill-b/references/knowledge"

  # Skill C — will be skipped (.no-sync present)
  mkdir -p "$TEMP_REPO/skills/skill-c/references/knowledge"
  touch "$TEMP_REPO/skills/skill-c/.no-sync"

  export REPO_ROOT="$TEMP_REPO"
}

teardown() {
  rm -rf "$TEMP_REPO"
}

@test "copies knowledge files to skills without .no-sync" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$TEMP_REPO/skills/skill-a/references/knowledge/architecture-current.md" ]
  [ -f "$TEMP_REPO/skills/skill-a/references/knowledge/decisions.md" ]
}

@test "copies knowledge files to all eligible skills" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$TEMP_REPO/skills/skill-b/references/knowledge/architecture-current.md" ]
}

@test "skips skill with .no-sync marker" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Skipped skill-c"* ]]
}

@test "does not overwrite customised knowledge in .no-sync skill" {
  echo "# Custom content" > "$TEMP_REPO/skills/skill-c/references/knowledge/architecture-current.md"
  bash "$SCRIPT"
  grep -q "Custom content" "$TEMP_REPO/skills/skill-c/references/knowledge/architecture-current.md"
}

@test "does not sync knowledge back to dev-rules itself" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" != *"makis-digital-dev-rules"* ]]
}

@test "reports count of synced skills" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"2 skill(s) updated"* ]]
}

@test "reports count of skipped skills" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"1 skipped"* ]]
}

@test "exits 1 when source knowledge directory does not exist" {
  rm -rf "$TEMP_REPO/skills/makis-digital-dev-rules"
  run bash "$SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" == *"Knowledge source not found"* ]]
}

@test "creates references/knowledge dir in skill if missing" {
  rm -rf "$TEMP_REPO/skills/skill-a/references/knowledge"
  bash "$SCRIPT"
  [ -d "$TEMP_REPO/skills/skill-a/references/knowledge" ]
  [ -f "$TEMP_REPO/skills/skill-a/references/knowledge/architecture-current.md" ]
}

@test "synced files match source content" {
  bash "$SCRIPT"
  diff "$TEMP_REPO/skills/makis-digital-dev-rules/references/knowledge/decisions.md" \
       "$TEMP_REPO/skills/skill-a/references/knowledge/decisions.md"
}
