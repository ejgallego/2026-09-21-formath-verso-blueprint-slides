# Asset Attribution

Unless noted below, source code, slide text, and original diagrams in this
repository are licensed under Apache License 2.0 as described in `LICENSE`.

Third-party screenshots and marks remain the property of their respective
authors and owners. They are included here for identification, commentary, and
scholarly presentation; the repository license does not relicense them.

| Files | Source |
| --- | --- |
| `static/images/slide_1.1_erdos.png` | Screenshot of a Timothy Gowers social-media post linking an OpenAI article about the unit-distance problem. |
| `static/images/slide_2.2_deepmind.png` | Screenshot of a Przemek Chojecki social-media post discussing [Advancing Mathematics Research with AI-Driven Formal Proof Search](https://arxiv.org/abs/2605.22763). |
| `static/images/math_inc_2.png` | Screenshot from [Math Inc., Sphere Packing](https://www.math.inc/sphere-packing). |
| `static/images/sp_index.png`, `static/images/sp_graph.png` | Screenshots from the [Sphere Packing in Lean Blueprint](https://thefundamentaltheor3m.github.io/Sphere-Packing-Lean/blueprint/). |
| `static/images/lte1.png`, `static/images/lte2.png` | Screenshots of the Liquid Tensor Experiment Blueprint, generated with [LeanBlueprint](https://github.com/PatrickMassot/leanblueprint). |
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
