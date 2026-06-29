from __future__ import annotations

import re
import sys
from pathlib import Path


ALLOWED_FRONTMATTER_KEYS = {
    "name",
    "description",
    "license",
    "metadata",
    "allowed-tools",
}
NAME_PATTERN = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")


def parse_frontmatter(skill_path: Path) -> dict[str, object]:
    content = skill_path.read_text(encoding="utf-8")
    lines = content.splitlines()

    if not lines or lines[0].strip() != "---":
        raise ValueError("SKILL.md must start with YAML frontmatter")

    try:
        closing_index = next(i for i in range(1, len(lines)) if lines[i].strip() == "---")
    except StopIteration as exc:
        raise ValueError("SKILL.md frontmatter is not closed") from exc

    frontmatter_lines = lines[1:closing_index]
    data: dict[str, object] = {}
    current_map_key: str | None = None

    for raw_line in frontmatter_lines:
        if not raw_line.strip():
            continue

        if raw_line.startswith("  "):
            if current_map_key is None:
                raise ValueError(f"Unexpected indented line in frontmatter: {raw_line}")

            nested = raw_line.strip()
            if ":" not in nested:
                raise ValueError(f"Invalid nested frontmatter line: {raw_line}")

            nested_key, nested_value = nested.split(":", 1)
            nested_key = nested_key.strip()
            nested_value = nested_value.strip().strip('"')

            nested_map = data.setdefault(current_map_key, {})
            if not isinstance(nested_map, dict):  # pragma: no cover — defensive: metadata is always initialised as {}
                raise ValueError(f"Frontmatter key '{current_map_key}' does not support nested values")

            nested_map[nested_key] = nested_value
            continue

        if ":" not in raw_line:
            raise ValueError(f"Invalid frontmatter line: {raw_line}")

        key, value = raw_line.split(":", 1)
        key = key.strip()
        value = value.strip()
        current_map_key = None

        if key not in ALLOWED_FRONTMATTER_KEYS:
            raise ValueError(
                f"Unexpected key '{key}'. Allowed keys: {', '.join(sorted(ALLOWED_FRONTMATTER_KEYS))}"
            )

        if key == "metadata":
            data[key] = {}
            current_map_key = key
            continue

        data[key] = value.strip('"')

    return data


def validate_skill(skill_dir: Path) -> list[str]:
    errors: list[str] = []
    skill_file = skill_dir / "SKILL.md"

    if not skill_file.exists():
        return [f"{skill_dir.name}: missing SKILL.md"]

    try:
        frontmatter = parse_frontmatter(skill_file)
    except ValueError as exc:
        return [f"{skill_dir.name}: {exc}"]

    name = str(frontmatter.get("name", "")).strip()
    description = str(frontmatter.get("description", "")).strip()
    metadata = frontmatter.get("metadata", {})

    if not name:
        errors.append(f"{skill_dir.name}: missing required 'name'")
    elif name != skill_dir.name:
        errors.append(f"{skill_dir.name}: name must match directory name")
    elif not NAME_PATTERN.fullmatch(name):
        errors.append(f"{skill_dir.name}: invalid skill name format")

    if not description:
        errors.append(f"{skill_dir.name}: missing required 'description'")
    elif len(description) > 1024:
        errors.append(f"{skill_dir.name}: description exceeds 1024 characters")

    if "license" in frontmatter and not str(frontmatter["license"]).strip():
        errors.append(f"{skill_dir.name}: license cannot be empty")

    if metadata and not isinstance(metadata, dict):  # pragma: no cover — defensive: parse_frontmatter always returns a dict for metadata
        errors.append(f"{skill_dir.name}: metadata must be a map")

    agents_yaml = skill_dir / "agents" / "openai.yaml"
    if not agents_yaml.exists():
        errors.append(f"{skill_dir.name}: missing agents/openai.yaml")

    return errors


def main() -> int:  # pragma: no cover
    repo_root = Path(__file__).resolve().parent.parent
    skills_root = repo_root / "skills"

    if not skills_root.exists():
        print("skills directory not found", file=sys.stderr)
        return 1

    skill_dirs = sorted(path for path in skills_root.iterdir() if path.is_dir())
    if not skill_dirs:
        print("No skill directories found", file=sys.stderr)
        return 1

    all_errors: list[str] = []
    for skill_dir in skill_dirs:
        all_errors.extend(validate_skill(skill_dir))

    if all_errors:
        print("Skill validation failed:", file=sys.stderr)
        for error in all_errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print(f"Validated {len(skill_dirs)} skill(s) successfully.")
    return 0


if __name__ == "__main__":  # pragma: no cover
    raise SystemExit(main())
