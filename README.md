# Verso Blueprint: Reimagining Blueprints for the AI Era

[View the slides](https://ejgallego.github.io/2026-09-21-formath-verso-blueprint-slides/)

Talk presented at the ForMath Seminar, IRIF, Université Paris Cité, on
21 September 2026 by Emilio Jesús Gallego Arias (Lean FRO).

Blueprints give mathematicians and formalizers a shared map of statements,
dependencies, source material, Lean declarations, and project status. This talk
introduces [Verso Blueprint](https://github.com/leanprover/verso-blueprint), a
Lean-native approach designed to make that map useful to people and AI agents.

The deck includes an interactive excerpt from the Fermat's Last Theorem
Blueprint, a checked Verso document, and a small Blueprint teaching example.

## Source and build

The slides are written in Lean with
[Verso Slides](https://github.com/leanprover/verso-slides). To build the same
artifact deployed by GitHub Pages:

```bash
git submodule update --init --recursive
scripts/build-pages.sh
```

The result is written to `_slides/`. Serve the whole directory over HTTP for
local preview:

```bash
python3 -m http.server 8877 --bind 127.0.0.1 --directory _slides
```

Run the packaging and offline browser checks with:

```bash
python3 -m unittest discover -s scripts -p 'test_*.py'
uv run --with playwright python scripts/rehearse-offline.py --output /tmp/formath-review
```

The `notes-and-appendix` branch retains the speaker notes, backup slides, and
ideas for future talks. Local slide extensions are described in
[`Lib/README.md`](Lib/README.md).

## License

Original source and slide content are available under Apache License 2.0.
Third-party asset attribution is recorded in [`ASSETS.md`](ASSETS.md).
