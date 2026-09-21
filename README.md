# Verso Blueprints: Reimagining Blueprints for the AI Era

[View the slides](https://ejgallego.github.io/2026-05-27-madlean-verso-blueprint-slides/)

Talk presented at MadLean, UCM Mathematics Department, Madrid, on May 27, 2026.

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
artifact deployed by GitHub Pages:

```bash
git submodule update --init --recursive
scripts/build-pages.sh
```

The result is written to `_slides/`. Local slide extensions are documented in
[`Lib/README.md`](Lib/README.md).

## ForMath working version

The inherited event information above describes the source deck. The current
ForMath work is organized in [the authoring map](../../STRUCTURE.md), with
an expert Rocq/formal-proof audience and a dedicated Verso explanation.
See [DEMO-RUNBOOK.md](DEMO-RUNBOOK.md) for the small local demonstrations,
incremental build commands, and rehearsal sequence.

## License

Original source and slide content are available under Apache License 2.0.
Third-party asset attribution is recorded in [`ASSETS.md`](ASSETS.md).
