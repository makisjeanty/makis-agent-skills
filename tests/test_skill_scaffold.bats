#!/usr/bin/env bats

SCRIPT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)/scripts/skill-scaffold.sh"

setup() {
  TEMP_REPO="$(mktemp -d)"
  mkdir -p "$TEMP_REPO/skills"
  export REPO_ROOT="$TEMP_REPO"
  TEST_SKILL_NAME="test-bats-scaffold"
  TEST_SKILL_DIR="$TEMP_REPO/skills/$TEST_SKILL_NAME"
}

teardown() {
  rm -rf "$TEMP_REPO"
}

@test "no arguments exits with usage error" {
  run bash "$SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "invalid name with uppercase exits with error" {
  run bash "$SCRIPT" "Invalid-Name"
  [ "$status" -eq 1 ]
  [[ "$output" == *"lowercase"* ]]
}

@test "invalid name with underscore exits with error" {
  run bash "$SCRIPT" "invalid_name"
  [ "$status" -eq 1 ]
}

@test "invalid name with leading hyphen exits with error" {
  run bash "$SCRIPT" "-bad-name"
  [ "$status" -eq 1 ]
}

@test "valid name succeeds" {
  run bash "$SCRIPT" "$TEST_SKILL_NAME"
  [ "$status" -eq 0 ]
}

@test "creates SKILL.md" {
  bash "$SCRIPT" "$TEST_SKILL_NAME"
  [ -f "$TEST_SKILL_DIR/SKILL.md" ]
}

@test "creates agents/openai.yaml" {
  bash "$SCRIPT" "$TEST_SKILL_NAME"
  [ -f "$TEST_SKILL_DIR/agents/openai.yaml" ]
}

@test "creates references directory" {
  bash "$SCRIPT" "$TEST_SKILL_NAME"
  [ -d "$TEST_SKILL_DIR/references" ]
}

@test "SKILL.md contains the skill name" {
  bash "$SCRIPT" "$TEST_SKILL_NAME"
  grep -q "name: $TEST_SKILL_NAME" "$TEST_SKILL_DIR/SKILL.md"
}

@test "SKILL.md contains MIT license" {
  bash "$SCRIPT" "$TEST_SKILL_NAME"
  grep -q "license: MIT" "$TEST_SKILL_DIR/SKILL.md"
}

@test "SKILL.md includes custom description" {
  bash "$SCRIPT" "$TEST_SKILL_NAME" --description "My custom description"
  grep -q "My custom description" "$TEST_SKILL_DIR/SKILL.md"
}

@test "default description used when none provided" {
  bash "$SCRIPT" "$TEST_SKILL_NAME"
  grep -q "Description for $TEST_SKILL_NAME" "$TEST_SKILL_DIR/SKILL.md"
}

@test "existing skill dir exits with error" {
  mkdir -p "$TEST_SKILL_DIR"
  run bash "$SCRIPT" "$TEST_SKILL_NAME"
  [ "$status" -eq 1 ]
  [[ "$output" == *"already exists"* ]]
}

@test "openai.yaml contains short_description" {
  bash "$SCRIPT" "$TEST_SKILL_NAME" --description "My description"
  grep -q "short_description" "$TEST_SKILL_DIR/agents/openai.yaml"
}

@test "creates a reference markdown file" {
  bash "$SCRIPT" "$TEST_SKILL_NAME"
  local ref_name
  ref_name="$(echo "$TEST_SKILL_NAME" | sed 's/makis-digital-//')"
  [ -f "$TEST_SKILL_DIR/references/${ref_name}.md" ] || \
  [ -f "$TEST_SKILL_DIR/references/$TEST_SKILL_NAME.md" ]
}
