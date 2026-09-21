#!/usr/bin/env python3
"""Package small generated Blueprint consumers using their own emitted styles."""

from html.parser import HTMLParser
from pathlib import Path
import html
import shutil


class Styles(HTMLParser):
    def __init__(self):
        super().__init__()
        self.parts = []
        self.in_style = False

    def handle_starttag(self, tag, attrs):
        if tag == "style":
            self.in_style = True
            self.parts.append("<style>")
        if tag == "link" and dict(attrs).get("rel") == "stylesheet":
            self.parts.append(self.get_starttag_text())

    def handle_data(self, text):
        if self.in_style:
            self.parts.append(text)

    def handle_endtag(self, tag):
        if tag == "style":
            self.parts.append("</style>")
            self.in_style = False


for state in ("before", "after"):
    site = Path("_demo") / state / "html-multi"
    styles = Styles()
    styles.feed((site / "index.html").read_text())
    panel = Path("static/demo-panel.html").read_text()
    panel = panel.replace("<!-- GENERATED STYLES -->", "\n".join(styles.parts))
    panel = panel.replace("DEMO_STATE", html.escape(state))
    (site / "panel.html").write_text(panel)
    shutil.copyfile("static/demo-panel.js", site / "panel.js")
    shutil.copyfile("static/demo-notes.md", site / "demo-notes.md")
