"""Fast offline packaging regressions; no Lean build or browser required."""

import hashlib
import json
from pathlib import Path
import tempfile
import unittest

from public_assets import GRAPH_LIBRARIES, MARKED_FILE, MARKED_URL, package_assets


class PublicAssetsTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        root = Path(self.temp.name)
        self.vendor = root / "vendor"
        self.output = root / "site"
        self.vendor.mkdir()
        self.output.mkdir()
        manifest = {}
        for name in [*GRAPH_LIBRARIES.values(), MARKED_FILE]:
            content = name.encode()
            (self.vendor / name).write_bytes(content)
            manifest[name] = {"sha256": hashlib.sha256(content).hexdigest()}
        (self.vendor / "manifest.json").write_text(json.dumps(manifest))
        self.modules = []
        for prefix in ("", "demo/after/", "blueprint/"):
            module = self.output / (prefix + "-verso-data/Commands/graph.mjs")
            module.parent.mkdir(parents=True)
            module.write_text("const libraries = [" + ",".join(
                json.dumps(url) for url in GRAPH_LIBRARIES) + "];")
            self.modules.append(module)

    def test_reader_html_script_and_integrity(self):
        page = self.output / 'demo/after/index.html'
        page.write_text(f'<script src="{MARKED_URL}" integrity="unchanged"></script>')
        package_assets(self.output, self.vendor)
        expected = f'<script src="../../vendor/{MARKED_FILE}" integrity="unchanged"></script>'
        self.assertEqual(page.read_text(), expected)
        package_assets(self.output, self.vendor)
        self.assertEqual(page.read_text(), expected)

    def test_reader_html_base_relative_to_site_root(self):
        page = self.output / 'demo/after/Chapter/index.html'
        page.parent.mkdir()
        page.write_text(f'<base href="./../"><script src="{MARKED_URL}"></script>')
        package_assets(self.output, self.vendor)
        self.assertIn(f'src="../../vendor/{MARKED_FILE}"', page.read_text())

    def test_reject_external_reader_base(self):
        page = self.output / 'index.html'
        page.write_text(f'<base href="https://example.com/"><script src="{MARKED_URL}"></script>')
        with self.assertRaisesRegex(ValueError, "non-portable HTML base"):
            package_assets(self.output, self.vendor)

    def test_nested_modules_and_idempotence(self):
        self.assertEqual(package_assets(self.output, self.vendor), 3)
        for module in self.modules:
            source = module.read_text()
            self.assertNotIn("https://", source)
            self.assertIn("import.meta.url", source)
            depth = len(module.parent.relative_to(self.output).parts)
            for filename in GRAPH_LIBRARIES.values():
                self.assertIn("../" * depth + "vendor/" + filename, source)
                self.assertEqual((self.output / "vendor" / filename).read_bytes(),
                                 (self.vendor / filename).read_bytes())
        before = [module.read_bytes() for module in self.modules]
        self.assertEqual(package_assets(self.output, self.vendor), 3)
        self.assertEqual(before, [module.read_bytes() for module in self.modules])

    def test_checksum_mismatch(self):
        (self.vendor / next(iter(GRAPH_LIBRARIES.values()))).write_text("corrupt")
        with self.assertRaisesRegex(ValueError, "checksum mismatch"):
            package_assets(self.output, self.vendor)
        self.assertFalse((self.output / "vendor").exists())

    def test_unknown_upstream_loader_fails_before_rewriting(self):
        original = self.modules[0].read_bytes()
        self.modules[-1].write_text("const libraries = {};")
        with self.assertRaisesRegex(ValueError, "unrecognized graph library"):
            package_assets(self.output, self.vendor)
        self.assertEqual(self.modules[0].read_bytes(), original)

    def test_missing_graph_modules(self):
        empty = self.output / "empty"
        empty.mkdir()
        with self.assertRaisesRegex(ValueError, "no generated Blueprint"):
            package_assets(empty, self.vendor)

    def test_manifest_path_traversal(self):
        (self.vendor / "manifest.json").write_text('{"../escape": {}}')
        with self.assertRaisesRegex(ValueError, "invalid vendor filename"):
            package_assets(self.output, self.vendor)


if __name__ == "__main__":
    unittest.main()
