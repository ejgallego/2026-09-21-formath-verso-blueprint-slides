"""Package pinned browser assets without network access or dependency edits."""

import hashlib
from html.parser import HTMLParser
import json
import os
from pathlib import Path
import shutil
from urllib.parse import urlsplit


GRAPH_LIBRARIES = {
    "https://cdn.jsdelivr.net/npm/d3@7.9.0/dist/d3.min.js": "d3-7.9.0.min.js",
    "https://cdn.jsdelivr.net/npm/d3-graphviz@5.6.0/build/d3-graphviz.min.js":
        "d3-graphviz-5.6.0.min.js",
}
MARKED_URL = "https://cdn.jsdelivr.net/npm/marked@11.1.1/marked.min.js"
MARKED_FILE = "marked-11.1.1.min.js"


class DocumentBase(HTMLParser):
    def __init__(self):
        super().__init__()
        self.href = "./"

    def handle_starttag(self, tag, attrs):
        if tag == "base":
            self.href = dict(attrs).get("href", "./")


def package_assets(output: Path, vendor: Path) -> int:
    """Verify the bundle, localize generated graph loaders, and copy assets.

    URLs are relative to each module, so nested sites and deployment prefixes
    work identically. Only generated output is modified; unknown loader shapes
    fail closed. Repeating publication preparation is safe.
    """
    manifest = json.loads((vendor / "manifest.json").read_text())
    for name, asset in manifest.items():
        if Path(name).name != name:
            raise ValueError(f"invalid vendor filename: {name}")
        digest = hashlib.sha256((vendor / name).read_bytes()).hexdigest()
        if digest != asset["sha256"]:
            raise ValueError(f"vendor checksum mismatch: {name}")
    for name in [*GRAPH_LIBRARIES.values(), MARKED_FILE]:
        if name not in manifest:
            raise ValueError(f"missing graph library in vendor manifest: {name}")

    modules = list(output.rglob("-verso-data/Commands/graph.mjs"))
    if not modules:
        raise ValueError("no generated Blueprint graph modules found")
    rewrites = []
    for module in modules:
        source = module.read_text()
        for remote, filename in GRAPH_LIBRARIES.items():
            relative = Path(os.path.relpath(output / "vendor" / filename,
                                           module.parent)).as_posix()
            local = f"new URL({json.dumps(relative)}, import.meta.url).href"
            old = json.dumps(remote)
            if source.count(old) == 1 and local not in source:
                source = source.replace(old, local)
            elif source.count(local) != 1 or old in source:
                raise ValueError(f"unrecognized graph library URL in {module}: {filename}")
        rewrites.append((module, source))

    # Verso Manual pages embed this script in their HTML, with an upstream SRI
    # hash. Preserve that hash: the vendored distribution is byte-identical.
    for page in output.rglob("*.html"):
        source = page.read_text()
        if MARKED_URL in source:
            document = DocumentBase()
            document.feed(source)
            href = urlsplit(document.href)
            if href.scheme or href.netloc or href.path.startswith("/"):
                raise ValueError(f"non-portable HTML base in {page}: {document.href}")
            base = (page.parent / href.path).resolve()
            if not base.is_relative_to(output.resolve()):
                raise ValueError(f"HTML base escapes output in {page}")
            relative = Path(os.path.relpath(output / "vendor" / MARKED_FILE,
                                           base)).as_posix()
            rewrites.append((page, source.replace(MARKED_URL, relative)))

    destination = output / "vendor"
    destination.mkdir(exist_ok=True)
    for name in [*manifest, "manifest.json"]:
        shutil.copyfile(vendor / name, destination / name)
    for module, source in rewrites:
        module.write_text(source)
    return len(modules)
