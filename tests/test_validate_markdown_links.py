from __future__ import annotations

import importlib.util
from pathlib import Path

import pytest

_spec = importlib.util.spec_from_file_location(
    "validate_markdown_links",
    Path(__file__).resolve().parent.parent / "scripts" / "validate-markdown-links.py",
)
_mod = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_mod)

normalize_target = _mod.normalize_target
is_external_target = _mod.is_external_target
validate_markdown_file = _mod.validate_markdown_file


# ── normalize_target ───────────────────────────────────────────────────────


class TestNormalizeTarget:
    def test_plain_path_unchanged(self):
        assert normalize_target("file.md") == "file.md"

    def test_leading_trailing_whitespace_stripped(self):
        assert normalize_target("  file.md  ") == "file.md"

    def test_angle_bracket_wrapped_stripped(self):
        assert normalize_target("<file.md>") == "file.md"

    def test_angle_bracket_with_whitespace_inside(self):
        assert normalize_target("< file.md >") == "file.md"

    def test_empty_string_returns_empty(self):
        assert normalize_target("") == ""

    def test_whitespace_only_returns_empty(self):
        assert normalize_target("   ") == ""

    def test_https_url_unchanged(self):
        assert normalize_target("https://example.com") == "https://example.com"


# ── is_external_target ─────────────────────────────────────────────────────


class TestIsExternalTarget:
    def test_http_is_external(self):
        assert is_external_target("http://example.com") is True

    def test_https_is_external(self):
        assert is_external_target("https://example.com") is True

    def test_mailto_is_external(self):
        assert is_external_target("mailto:alice@example.com") is True

    def test_anchor_is_external(self):
        assert is_external_target("#section") is True

    def test_relative_path_is_not_external(self):
        assert is_external_target("file.md") is False

    def test_dotslash_path_is_not_external(self):
        assert is_external_target("./subdir/file.md") is False

    def test_dotdot_path_is_not_external(self):
        assert is_external_target("../other.md") is False


# ── validate_markdown_file ─────────────────────────────────────────────────


class TestValidateMarkdownFile:
    def _write(self, tmp_path: Path, filename: str, content: str) -> Path:
        p = tmp_path / filename
        p.write_text(content, encoding="utf-8")
        return p

    def test_no_links_no_errors(self, tmp_path):
        md = self._write(tmp_path, "source.md", "# Title\n\nJust text, no links.")
        assert validate_markdown_file(md, tmp_path) == []

    def test_external_https_link_skipped(self, tmp_path):
        md = self._write(tmp_path, "source.md", "[site](https://example.com)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_external_http_link_skipped(self, tmp_path):
        md = self._write(tmp_path, "source.md", "[site](http://example.com)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_mailto_link_skipped(self, tmp_path):
        md = self._write(tmp_path, "source.md", "[email](mailto:a@b.com)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_anchor_only_link_skipped(self, tmp_path):
        md = self._write(tmp_path, "source.md", "[jump](#heading)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_valid_relative_link_no_error(self, tmp_path):
        self._write(tmp_path, "other.md", "# Other")
        md = self._write(tmp_path, "source.md", "[link](other.md)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_missing_relative_link_reported(self, tmp_path):
        md = self._write(tmp_path, "source.md", "[link](nonexistent.md)")
        errors = validate_markdown_file(md, tmp_path)
        assert len(errors) == 1
        assert "nonexistent.md" in errors[0]

    def test_relative_link_with_anchor_resolves_file_part(self, tmp_path):
        self._write(tmp_path, "other.md", "# Other")
        md = self._write(tmp_path, "source.md", "[link](other.md#section)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_missing_file_with_anchor_reported(self, tmp_path):
        md = self._write(tmp_path, "source.md", "[link](missing.md#section)")
        errors = validate_markdown_file(md, tmp_path)
        assert len(errors) == 1

    def test_image_links_not_checked(self, tmp_path):
        md = self._write(tmp_path, "source.md", "![img](nonexistent.png)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_url_encoded_path_resolved(self, tmp_path):
        self._write(tmp_path, "my file.md", "# Space")
        md = self._write(tmp_path, "source.md", "[link](my%20file.md)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_subdirectory_link_resolved(self, tmp_path):
        subdir = tmp_path / "sub"
        subdir.mkdir()
        self._write(subdir, "page.md", "# Sub")
        md = self._write(tmp_path, "source.md", "[link](sub/page.md)")
        assert validate_markdown_file(md, tmp_path) == []

    def test_missing_subdirectory_link_reported(self, tmp_path):
        md = self._write(tmp_path, "source.md", "[link](sub/missing.md)")
        errors = validate_markdown_file(md, tmp_path)
        assert len(errors) == 1

    def test_multiple_broken_links_all_reported(self, tmp_path):
        content = "[a](missing-a.md)\n\n[b](missing-b.md)"
        md = self._write(tmp_path, "source.md", content)
        errors = validate_markdown_file(md, tmp_path)
        assert len(errors) == 2

    def test_error_contains_relative_file_path(self, tmp_path):
        subdir = tmp_path / "docs"
        subdir.mkdir()
        md = self._write(subdir, "source.md", "[link](nonexistent.md)")
        errors = validate_markdown_file(md, tmp_path)
        assert len(errors) == 1
        assert "docs/source.md" in errors[0]

    def test_angle_bracket_link_resolved(self, tmp_path):
        self._write(tmp_path, "other.md", "# Other")
        md = self._write(tmp_path, "source.md", "[link](<other.md>)")
        assert validate_markdown_file(md, tmp_path) == []
