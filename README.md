# Verso Blueprints

ForMath Seminar, IRIF, Université Paris Cité. Monday, 21 September 2026.
Emilio Jesús Gallego Arias, Senior Research Engineer — Lean FRO.

The local preview is at http://127.0.0.1:8876/ when the server is running.
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
