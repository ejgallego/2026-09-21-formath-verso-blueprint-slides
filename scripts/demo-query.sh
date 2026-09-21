#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"
state="${1:-after}"
case "$state" in
  before|after) ;;
  *) echo "Usage: bash scripts/demo-query.sh [before|after]" >&2; exit 2 ;;
esac
lake exe vbp query --site "_demo/$state" node left_inverse_injective
lake exe vbp query --site "_demo/$state" uses left_inverse_injective
lake exe vbp query --site "_demo/$state" work-queue
