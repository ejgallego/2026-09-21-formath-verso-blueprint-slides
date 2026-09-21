#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"
lake lean DemoVersoMain.lean -- --run DemoVersoMain.lean --output _demo/verso
lake lean DemoBeforeMain.lean -- --run DemoBeforeMain.lean --output _demo/before
lake lean DemoAfterMain.lean -- --run DemoAfterMain.lean --output _demo/after
python3 scripts/prepare-demo.py
