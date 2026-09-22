"""Regression checks for portable generated source paths."""

from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path
import unittest


SCRIPT = Path(__file__).with_name("prepare-public-output.py")
SPEC = spec_from_file_location("prepare_public_output", SCRIPT)
assert SPEC and SPEC.loader
MODULE = module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class CachedWorktreePathsTest(unittest.TestCase):
    def test_retired_worktree_source_is_relative(self):
        root = Path("/workspace/slides")
        old = b"/workspace/slides/.worktrees/old/examples/verso-flt/FLT/Proof.lean"
        current = b"/workspace/slides/examples/verso-flt/FLT/Proof.lean"
        data, count = MODULE.normalize_cached_worktree_paths(old + b" " + current, root)
        self.assertEqual(count, 1)
        self.assertEqual(data, b"FLT/Proof.lean " + current)


if __name__ == "__main__":
    unittest.main()
