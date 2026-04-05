from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote


MARKDOWN_LINK_PATTERN = re.compile(r"(?<!\!)\[[^\]]+\]\(([^)]+)\)")
EXCLUDED_PREFIXES = ("http://", "https://", "mailto:", "#")


def normalize_target(raw_target: str) -> str:
    target = raw_target.strip()
    if target.startswith("<") and target.endswith(">"):
        target = target[1:-1].strip()
    return target


def is_external_target(target: str) -> bool:
    return target.startswith(EXCLUDED_PREFIXES)


def validate_markdown_file(markdown_file: Path, repo_root: Path) -> list[str]:
    errors: list[str] = []
    content = markdown_file.read_text(encoding="utf-8")
    relative_file = markdown_file.relative_to(repo_root)

    for match in MARKDOWN_LINK_PATTERN.finditer(content):
        raw_target = normalize_target(match.group(1))

        if not raw_target or is_external_target(raw_target):
            continue

        path_target = raw_target.split("#", 1)[0].strip()
        if not path_target:
            continue

        resolved = (markdown_file.parent / unquote(path_target)).resolve()
        if not resolved.exists():
            errors.append(f"{relative_file} -> missing target: {raw_target}")

    return errors


def main() -> int:
    repo_root = Path(__file__).resolve().parent.parent
    markdown_files = sorted(repo_root.rglob("*.md"))

    if not markdown_files:
        print("No markdown files found.", file=sys.stderr)
        return 1

    all_errors: list[str] = []
    for markdown_file in markdown_files:
        all_errors.extend(validate_markdown_file(markdown_file, repo_root))

    if all_errors:
        print("Markdown link validation failed:", file=sys.stderr)
        for error in all_errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print(f"Validated markdown links in {len(markdown_files)} file(s) successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
