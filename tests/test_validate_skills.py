from __future__ import annotations

import importlib.util
from pathlib import Path

import pytest

_spec = importlib.util.spec_from_file_location(
    "validate_skills",
    Path(__file__).resolve().parent.parent / "scripts" / "validate-skills.py",
)
_mod = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_mod)

parse_frontmatter = _mod.parse_frontmatter
validate_skill = _mod.validate_skill


# ── helpers ────────────────────────────────────────────────────────────────


def write_skill_md(path: Path, content: str) -> Path:
    p = path / "SKILL.md"
    p.write_text(content, encoding="utf-8")
    return p


def make_valid_skill(tmp_path: Path, name: str = "my-skill") -> Path:
    skill_dir = tmp_path / name
    skill_dir.mkdir()
    (skill_dir / "agents").mkdir()
    (skill_dir / "agents" / "openai.yaml").write_text("interface:\n  display_name: Test\n")
    (skill_dir / "SKILL.md").write_text(
        f"---\nname: {name}\ndescription: A test skill\nlicense: MIT\n---\n\n# Body\n"
    )
    return skill_dir


# ── parse_frontmatter ──────────────────────────────────────────────────────


class TestParseFrontmatter:
    def test_valid_simple(self, tmp_path):
        p = write_skill_md(tmp_path, "---\nname: my-skill\ndescription: A skill\n---\n")
        result = parse_frontmatter(p)
        assert result["name"] == "my-skill"
        assert result["description"] == "A skill"

    def test_missing_opening_delimiter(self, tmp_path):
        p = write_skill_md(tmp_path, "name: my-skill\n---\n")
        with pytest.raises(ValueError, match="must start with YAML frontmatter"):
            parse_frontmatter(p)

    def test_empty_file(self, tmp_path):
        p = write_skill_md(tmp_path, "")
        with pytest.raises(ValueError, match="must start with YAML frontmatter"):
            parse_frontmatter(p)

    def test_unclosed_frontmatter(self, tmp_path):
        p = write_skill_md(tmp_path, "---\nname: my-skill\n")
        with pytest.raises(ValueError, match="not closed"):
            parse_frontmatter(p)

    def test_unknown_key_raises(self, tmp_path):
        p = write_skill_md(tmp_path, "---\nname: my-skill\nunknown-field: value\n---\n")
        with pytest.raises(ValueError, match="Unexpected key 'unknown-field'"):
            parse_frontmatter(p)

    def test_line_without_colon_raises(self, tmp_path):
        p = write_skill_md(tmp_path, "---\nno-colon-here\n---\n")
        with pytest.raises(ValueError, match="Invalid frontmatter line"):
            parse_frontmatter(p)

    def test_indented_line_without_map_context_raises(self, tmp_path):
        p = write_skill_md(tmp_path, "---\n  orphan: value\n---\n")
        with pytest.raises(ValueError, match="Unexpected indented line"):
            parse_frontmatter(p)

    def test_nested_line_without_colon_raises(self, tmp_path):
        p = write_skill_md(tmp_path, "---\nmetadata:\n  no-colon-here\n---\n")
        with pytest.raises(ValueError, match="Invalid nested frontmatter line"):
            parse_frontmatter(p)

    def test_metadata_parsed_as_dict(self, tmp_path):
        content = '---\nmetadata:\n  maintainer: Alice\n  version: "1.0.0"\n---\n'
        p = write_skill_md(tmp_path, content)
        result = parse_frontmatter(p)
        assert isinstance(result["metadata"], dict)
        assert result["metadata"]["maintainer"] == "Alice"
        assert result["metadata"]["version"] == "1.0.0"

    def test_quoted_values_stripped(self, tmp_path):
        p = write_skill_md(tmp_path, '---\nname: "my-skill"\ndescription: "A desc"\n---\n')
        result = parse_frontmatter(p)
        assert result["name"] == "my-skill"
        assert result["description"] == "A desc"

    def test_empty_lines_ignored(self, tmp_path):
        content = "---\n\nname: my-skill\n\ndescription: A skill\n\n---\n"
        p = write_skill_md(tmp_path, content)
        result = parse_frontmatter(p)
        assert result["name"] == "my-skill"
        assert result["description"] == "A skill"

    def test_allowed_tools_key(self, tmp_path):
        p = write_skill_md(tmp_path, "---\nname: my-skill\nallowed-tools: Bash,Read\n---\n")
        result = parse_frontmatter(p)
        assert result["allowed-tools"] == "Bash,Read"

    def test_license_key(self, tmp_path):
        p = write_skill_md(tmp_path, "---\nname: my-skill\nlicense: MIT\n---\n")
        result = parse_frontmatter(p)
        assert result["license"] == "MIT"

    def test_content_after_frontmatter_ignored(self, tmp_path):
        content = "---\nname: my-skill\n---\n\n# Title\n\nBody text."
        p = write_skill_md(tmp_path, content)
        result = parse_frontmatter(p)
        assert list(result.keys()) == ["name"]

    def test_indented_line_after_non_map_key_raises(self, tmp_path):
        # current_map_key is reset to None after a non-metadata key, so the
        # indented line hits the "Unexpected indented line" branch
        content = "---\nname: my-skill\n  nested: oops\n---\n"
        p = write_skill_md(tmp_path, content)
        with pytest.raises(ValueError, match="Unexpected indented line"):
            parse_frontmatter(p)


# ── validate_skill ─────────────────────────────────────────────────────────


class TestValidateSkill:
    def test_missing_skill_md(self, tmp_path):
        skill_dir = tmp_path / "my-skill"
        skill_dir.mkdir()
        errors = validate_skill(skill_dir)
        assert len(errors) == 1
        assert "missing SKILL.md" in errors[0]

    def test_valid_skill_no_errors(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        assert validate_skill(skill_dir) == []

    def test_parse_error_reported_as_single_error(self, tmp_path):
        skill_dir = tmp_path / "bad-skill"
        skill_dir.mkdir()
        write_skill_md(skill_dir, "not-valid-frontmatter\n")
        errors = validate_skill(skill_dir)
        assert len(errors) == 1
        assert "bad-skill" in errors[0]

    def test_missing_name(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        write_skill_md(skill_dir, "---\ndescription: A skill\n---\n")
        errors = validate_skill(skill_dir)
        assert any("missing required 'name'" in e for e in errors)

    def test_name_must_match_directory(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path, name="my-skill")
        write_skill_md(skill_dir, "---\nname: wrong-name\ndescription: A skill\n---\n")
        errors = validate_skill(skill_dir)
        assert any("name must match directory name" in e for e in errors)

    def test_invalid_name_format_underscore(self, tmp_path):
        skill_dir = tmp_path / "my_skill"
        skill_dir.mkdir()
        (skill_dir / "agents").mkdir()
        (skill_dir / "agents" / "openai.yaml").write_text("")
        write_skill_md(skill_dir, "---\nname: my_skill\ndescription: A skill\n---\n")
        errors = validate_skill(skill_dir)
        assert any("invalid skill name format" in e for e in errors)

    def test_invalid_name_format_double_hyphen(self, tmp_path):
        skill_dir = tmp_path / "my--skill"
        skill_dir.mkdir()
        (skill_dir / "agents").mkdir()
        (skill_dir / "agents" / "openai.yaml").write_text("")
        write_skill_md(skill_dir, "---\nname: my--skill\ndescription: A skill\n---\n")
        errors = validate_skill(skill_dir)
        assert any("invalid skill name format" in e for e in errors)

    def test_missing_description(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        write_skill_md(skill_dir, "---\nname: my-skill\n---\n")
        errors = validate_skill(skill_dir)
        assert any("missing required 'description'" in e for e in errors)

    def test_description_too_long(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        long_desc = "x" * 1025
        write_skill_md(skill_dir, f"---\nname: my-skill\ndescription: {long_desc}\n---\n")
        errors = validate_skill(skill_dir)
        assert any("description exceeds 1024 characters" in e for e in errors)

    def test_description_exactly_1024_chars_ok(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        long_desc = "x" * 1024
        write_skill_md(skill_dir, f"---\nname: my-skill\ndescription: {long_desc}\n---\n")
        errors = [e for e in validate_skill(skill_dir) if "description" in e]
        assert errors == []

    def test_empty_license(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        write_skill_md(skill_dir, "---\nname: my-skill\ndescription: A skill\nlicense:\n---\n")
        errors = validate_skill(skill_dir)
        assert any("license cannot be empty" in e for e in errors)

    def test_non_empty_license_ok(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        errors = validate_skill(skill_dir)
        assert not any("license" in e for e in errors)

    def test_missing_openai_yaml(self, tmp_path):
        skill_dir = make_valid_skill(tmp_path)
        (skill_dir / "agents" / "openai.yaml").unlink()
        errors = validate_skill(skill_dir)
        assert any("missing agents/openai.yaml" in e for e in errors)

    def test_multiple_errors_accumulated(self, tmp_path):
        skill_dir = tmp_path / "my-skill"
        skill_dir.mkdir()
        write_skill_md(skill_dir, "---\nname: my-skill\n---\n")
        errors = validate_skill(skill_dir)
        assert len(errors) >= 2

    def test_error_includes_skill_dir_name(self, tmp_path):
        skill_dir = tmp_path / "named-skill"
        skill_dir.mkdir()
        errors = validate_skill(skill_dir)
        assert all("named-skill" in e for e in errors)
