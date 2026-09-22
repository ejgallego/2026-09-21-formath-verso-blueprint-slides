#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
flt_dir="$repo_root/examples/verso-flt"
output_dir="${FLT_BLUEPRINT_OUTPUT:-_out/site}"

if ! git -C "$flt_dir" rev-parse --git-dir >/dev/null 2>&1; then
  git -C "$repo_root" submodule update --init -- examples/verso-flt
fi
if ! git -C "$repo_root/deps/verso-blueprint" rev-parse --git-dir >/dev/null 2>&1; then
  git -C "$repo_root" submodule update --init -- deps/verso-blueprint
fi
git -C "$flt_dir" \
  -c url.https://github.com/.insteadOf=git@github.com: \
  -c url.https://github.com/.insteadOf=ssh://git@github.com/ \
  submodule update --init --depth 1 --recursive

cd "$flt_dir"

lake exe cache get
lake build
lake exe vbp build --output "$output_dir"

rm -f "$output_dir/html-multi/-verso-data/blueprint-preview-manifest.json"
test -f "$output_dir/html-multi/-verso-data/blueprint-manifest.json"
test -f "$output_dir/html-multi/-verso-data/blueprint-html-cache.json"
