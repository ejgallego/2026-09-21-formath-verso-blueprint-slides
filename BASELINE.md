# ForMath Verso Blueprint baseline

This worktree bootstraps the ForMath deck from the MadLean deck.
Source checkout: `564a42e57554a7b3390fd5056a3b1e56e1786008`.
Branch: `formath-bootstrap`. Toolchain: `leanprover/lean4:v4.34.0-rc2`.

## Recursive submodules

- VBP: `19451b009e306e7436b82f4d9093c4d15f8cdfd8`
- FLT Blueprint: `5f5d02d8d3fc0d3949daa8a312b51ee09c2c2cf7`
- FLT: `1a310ae505e6af31534de4002d1955e8168ee2e1`
- FLT harness: `3f87181611d7f80da14f547cb6211df25dfbe63c`

## Evidence, 21 September 2026

The original cold `scripts/build-pages.sh` workflow completed with pinned FLT
artifacts. The subsequent feature pass ran `bash scripts/build-demo.sh`,
`lake build`, `lake exe vbp-ucm-slides`, and publication normalization
successfully. The full expensive FLT generation was not repeated for slide edits.
No dependency pins changed.

The active rendering examples are now equality transport and “left inverse
implies injectivity,” replacing the original addition fixture. They cover
complete Verso source, checked code, an enforced error, declaration/document
references, inline/display mathematics, and VBP's public preview/graph consumers.
The Frey curve still exercises the FLT manifest and shared TeX prelude.

Both small Blueprint variants pass `vbp check` (11 entries). Queries establish
automatic statement dependencies, the manual proof dependency, and a real
before/after change in the work queue. The before variant's `sorry` is intentional;
it must not be “fixed” without updating the demonstration.

The in-app browser connection was unavailable. Headless Chrome provides the
visual/interaction checks documented in [DEMO-RUNBOOK.md](DEMO-RUNBOOK.md).
Full offline and deployment-prefix checks remain outstanding.

The opening pass replaced generic context with three sourced slides: FLT and
Prove2Me coordination, the smooth-forced Navier–Stokes announcement targeting
Clay C/D, and blueprints before and after formalization. The deck now has 27
main slides including title, plus 11 backup. Incremental compilation,
generation, publication normalization, and browser rehearsal passed again.
The milestone review used published sources, not independent artifact builds.

## Integration, 21 September 2026

The original checkpoint `b93aac0` and metadata commit `f56390f` came from the
MadLean repository's `formath-bootstrap` branch. They are now integrated into
the ForMath repository while retaining its abstract and history. The public
MadLean branch remains untouched. The title slide and README now identify
ForMath Seminar, IRIF, Université Paris Cité, Monday, 21 September 2026.

All four recursive submodule pins above remain unchanged. The destination
has its own Git metadata for every submodule, canonical upstream URLs, and no
Git object alternates. Existing dependency caches were copied locally. The
deck's own build directory was set aside, then its modules and all three demo
documents were rebuilt at the new location. The large pinned FLT site was
reused with source paths normalized to relative paths by the existing
publication script. This was not a cold rebuild of FLT or its dependencies.

Nothing in this integration publishes the deck. The ForMath repository has
no remote configured yet.

The clean bootstrap worktree and its port-8876 preview server were retired
after integration. Its branch and source history remain recoverable. The
deck also builds after removal. The active preview uses port 8877.
See [REVIEW.md](REVIEW.md) for main-route rehearsal evidence and the known
offline graph limitation.

See [the authoring map](STRUCTURE.md) for the five-section structure,
audience, ordered roadmap, and remaining editorial work.
