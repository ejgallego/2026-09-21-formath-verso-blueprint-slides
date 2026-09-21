#!/usr/bin/env python3

"""Make generated slide artifacts portable before publication."""

from __future__ import annotations

import argparse
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("output", nargs="?", default="_slides", type=Path)
    parser.add_argument(
        "--source-root", default=Path("examples/verso-flt"), type=Path
    )
    return parser.parse_args()


def files_containing(root: Path, needle: bytes) -> list[Path]:
    matches = []
    for path in root.rglob("*"):
        if path.is_file() and needle in path.read_bytes():
            matches.append(path)
    return matches


def main() -> int:
    args = parse_args()
    output = args.output.resolve()
    source_root = args.source_root.resolve()
    repository_root = Path.cwd().resolve()

    if not (output / "index.html").is_file():
        raise SystemExit(f"missing generated deck: {output / 'index.html'}")
    if not source_root.is_dir():
        raise SystemExit(f"missing Blueprint source root: {source_root}")

    changed_files = 0
    replacements = 0
    prefixes = (
        ((str(source_root) + "/").encode(), b""),
        ((str(repository_root / "ForMathDemo") + "/").encode(), b"ForMathDemo/"),
    )
    for source_prefix, replacement in prefixes:
        for path in files_containing(output, source_prefix):
            data = path.read_bytes()
            count = data.count(source_prefix)
            path.write_bytes(data.replace(source_prefix, replacement))
            changed_files += 1
            replacements += count

    for name in ("LICENSE", "NOTICE", "ASSETS.md"):
        source = repository_root / name
        if not source.is_file():
            raise SystemExit(f"missing publication metadata: {source}")
        (output / name).write_bytes(source.read_bytes())

    leaked = files_containing(output, (str(repository_root) + "/").encode())
    if leaked:
        rendered = "\n".join(f"  {path.relative_to(output)}" for path in leaked)
        raise SystemExit(f"generated output contains local repository paths:\n{rendered}")

    (output / ".nojekyll").touch()
    print(
        f"Normalized {replacements} generated source paths in "
        f"{changed_files} files; no local repository paths remain."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
