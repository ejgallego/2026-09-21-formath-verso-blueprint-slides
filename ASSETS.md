# Asset Attribution

Unless noted below, source code, slide text, and original diagrams in this
repository are licensed under Apache License 2.0 as described in `LICENSE`.

Third-party screenshots and marks remain the property of their respective
authors and owners. They are included here for identification, commentary, and
scholarly presentation; the repository license does not relicense them.

| Files | Source |
| --- | --- |
| `static/images/slide_1.1_erdos.png` | Screenshot of a Timothy Gowers social-media post linking an OpenAI article about the unit-distance problem. |
| `static/images/math_inc_2.png` | Screenshot from [Math Inc., Sphere Packing](https://www.math.inc/sphere-packing). |
| `static/images/sp_index.png`, `static/images/sp_graph.png` | Screenshots from the [Sphere Packing in Lean Blueprint](https://thefundamentaltheor3m.github.io/Sphere-Packing-Lean/blueprint/). |
| `static/videos/flt-progress.mp4`, `static/images/flt-progress-poster.png`, `static/images/flt-plan.png` | Anthropic's progress animation and Prove2Me plan graph from [Formalizing Fermat's Last Theorem](https://www.anthropic.com/research/formalizing-fermats-last-theorem), supplied for this talk. The poster is a frame from the animation. |
| `static/videos/verso-documentation-dsl.mp4`, `static/images/verso-dsl-poster.png` | Local 360p copy and title-frame poster of David Thrane Christiansen's [Lean Together 2024 talk, “Verso: Documentation as a DSL”](https://www.youtube.com/watch?v=dv_vmVs3SQQ), used for the Verso introduction. |
| `static/webshots/verso-equality-transport.png` | Local browser capture of this deck's generated Verso Manual demonstration page, used to show source and rendered document side by side. |
| `static/images/lte2.png` | Screenshot of the Liquid Tensor Experiment Blueprint, generated with [LeanBlueprint](https://github.com/PatrickMassot/leanblueprint). |
| `static/lean-logo.png`, `static/lean-logo-large.png` | Lean logo, used descriptively. Lean and its logo are associated with Lean FRO and the Lean project. |

The `examples/verso-flt`, `deps/verso-blueprint`, and nested submodules retain
their own licenses and copyright notices.

## Offline browser bundle

`static/vendor/manifest.json` records exact download URLs and SHA-256 digests.
Publication verifies these tracked files and copies them to `_slides/vendor/`;
ordinary builds do not download browser assets.

| Asset | Version / license |
| --- | --- |
| D3 | 7.9.0, ISC; `d3-LICENSE` |
| D3-Graphviz | 5.6.0, BSD-3-Clause; `d3-graphviz-LICENSE` |
| Marked (Verso reader-page Markdown parser) | 11.1.1, MIT; `marked-LICENSE.md` |
| Source Sans 3 variable fonts, upright and italic | Adobe release 3.052R, SIL Open Font License 1.1; `SourceSans3-LICENSE.md` |

The D3-Graphviz distribution includes the HPCC WebAssembly Graphviz runtime.
The HPCC Apache-2.0 and Graphviz EPL-1.0 license texts are included as
`hpcc-js-wasm-LICENSE` and `Graphviz-LICENSE`. The bundle is retained byte-for-byte;
its checksum, not a guessed transitive dependency version, identifies it.
Generated graph-loader and reader-page URLs are rewritten to local assets;
upstream bundles and dependency sources remain unchanged.
