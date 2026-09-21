# Verso Blueprint: Reimagining Blueprints for the AI Era

ForMath Seminar, IRIF, Université Paris Cité. Monday, 21 September 2026.
Emilio Jesús Gallego Arias, Senior Research Engineer — Lean FRO.

The local preview is at http://127.0.0.1:8877/ when the server is running.
This ForMath deck has not been published.

Blueprints give mathematicians and formalizers a shared map of statements,
dependencies, source material, Lean declarations, and project status. This talk
introduces [Verso Blueprint](https://github.com/leanprover/verso-blueprint), a
Lean-native approach designed to make that map useful to both people and AI
agents.

The deck includes an interactive excerpt from the Fermat's Last Theorem
Blueprint and examples from recent large-scale and AI-assisted formalization
projects.

## Source

The slides are written in Lean with
[Verso Slides](https://github.com/leanprover/verso-slides). To build the same
HTML artifact:

```bash
git submodule update --init --recursive
scripts/build-pages.sh
```

The result is written to `_slides/`. Local slide extensions are documented in
[`Lib/README.md`](Lib/README.md).

## Offline preview and checks

Publication preparation bundles the graph libraries, WebAssembly runtime, and
Source Sans 3 font locally. Keep the entire `_slides/` directory together and
serve it over HTTP; opening `index.html` as a file does not support module loads.
External reference links still require internet access.

```bash
python3 -m http.server 8877 --bind 127.0.0.1 --directory _slides
```

The following checks use system Chrome. The rehearsal starts and stops its own
temporary server, tests a `/formath/` deployment prefix with external requests
blocked, and saves screenshots and a JSON layout report:

```bash
python3 -m unittest discover -s scripts -p 'test_*.py'
uv run --with playwright python scripts/rehearse-offline.py --output /tmp/formath-review
```

Pinned browser assets and their licenses are tracked under `static/vendor/`.
`prepare-public-output.py` verifies their SHA-256 digests and localizes generated
graph loaders, without editing dependency sources or requiring network access.
Run it after every slide generation, including incremental builds. A changed
upstream loader or corrupted asset fails publication preparation explicitly.

## ForMath working version

The ForMath work is organized in [the authoring map](STRUCTURE.md), with
an expert Rocq/formal-proof audience and a dedicated Verso explanation.
See [DEMO-RUNBOOK.md](DEMO-RUNBOOK.md) for the small local demonstrations,
incremental build commands, and rehearsal sequence.

The active source is [Slides.lean](Slides.lean) in this repository. The deck
was integrated from the local `formath-bootstrap` branch, preserving both its
history and this repository's original abstract. The executable name
`vbp-ucm-slides` is retained for compatibility with the inherited build scripts.

## License

Original source and slide content are available under Apache License 2.0.
Third-party asset attribution is recorded in [`ASSETS.md`](ASSETS.md).
