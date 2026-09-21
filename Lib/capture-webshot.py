#!/usr/bin/env python3
import argparse
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


def find_browser() -> str:
    for env_name in ("CHROMIUM", "CHROME"):
        value = os.environ.get(env_name)
        if value:
            return value
    for name in ("google-chrome", "chromium", "chromium-browser"):
        path = shutil.which(name)
        if path:
            return path
    raise RuntimeError("no Chromium-compatible browser found on PATH")


def main() -> int:
    parser = argparse.ArgumentParser(description="Capture a cached webpage screenshot for slides.")
    parser.add_argument("--url", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--width", type=int, default=1280)
    parser.add_argument("--height", type=int, default=720)
    parser.add_argument("--delay-ms", type=int, default=1000)
    parser.add_argument("--force", action="store_true")
    args = parser.parse_args()

    out = Path(args.output)
    if out.exists() and not args.force:
        print(f"webshot cache hit: {out}")
        return 0

    out.parent.mkdir(parents=True, exist_ok=True)
    browser = find_browser()

    with tempfile.TemporaryDirectory(prefix="codex-webshot-") as profile:
        cmd = [
            browser,
            "--headless=new",
            "--disable-gpu",
            "--disable-dev-shm-usage",
            "--no-first-run",
            "--hide-scrollbars",
            f"--user-data-dir={profile}",
            f"--window-size={args.width},{args.height}",
            f"--virtual-time-budget={args.delay_ms}",
            f"--screenshot={out}",
            args.url,
        ]
        proc = subprocess.run(cmd, text=True, capture_output=True, timeout=90)

    if proc.returncode != 0:
        sys.stderr.write(proc.stderr)
        return proc.returncode

    if not out.exists() or out.stat().st_size == 0:
        sys.stderr.write(f"browser did not create a non-empty screenshot at {out}\n")
        return 1

    print(f"webshot captured: {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
