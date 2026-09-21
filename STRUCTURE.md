# ForMath deck: current authoring map

Updated 21 September 2026. Audience: experts in formal proof and Rocq,
unfamiliar with Verso. Explain the document system, not proof assistants.

Active source: [Slides.lean](Slides.lean), in the ForMath repository root.
Confirmed event: ForMath Seminar, IRIF, Université Paris Cité, Monday,
21 September 2026. Speaker: Emilio Jesús Gallego Arias, Lean FRO.
Five substantive sections, plus backup. The main route has 23 slides including
the title; backup has 9. Horizontal sections retain vertical children.
40 minutes remains a provisional budget: rehearse and cut optional demos.

## Main route

| Section | Current content | Remaining editorial work |
| --- | --- | --- |
| Actual context | Madrid AI opener; sphere packing and its Blueprint; FLT scale and Prove2Me; dated reflection on mathematical direction | Six substantive slides. The Anthropic animation, smaller plan graph, and both quote excerpts are visible. Navier–Stokes and its image are in backup. Keep the community FLT demo distinct from Anthropic's artifact. Recheck announcement status before delivery. |
| Historical context | Blueprint lineage, LeanBlueprint, and why build VBP | The comparison with LeanBlueprint now closes this section. Retain attribution and credit existing capabilities. |
| Verso | David Thrane Christiansen's introduction; one source/output slide with a checked proof and resolved references; two-phase build; extension points | Former slides 4.2 and 4.3 are fused. The source and captured page use the same compiled example. No Lean tutorial. |
| Verso Blueprint | Rich theorem syntax with attached Lean; its rendered node; real Frey node; FLT graph; highlighted attribute authoring; Features; Validation | Show syntax before the node. Keep the Frey example substantial. End with the four Codex-assisted LaTeX ports and the review harness. |
| What's next | “Towards programmatic blueprints” uses a single list to frame VBP as core infrastructure for research projects; six-item Illuminate timeline | Two slides. Prove2Me, Trellis, and AutoformBot are potential beneficiaries, not claimed integrations. The September–December span is illustrative: items are equally spaced, without individual delivery dates. “1.0 release” accompanies the final item. The first item means formalizing VBP's custom database. |

Roadmap order: **Formal Database Model → Improved Skill → Improved Verso
Performance → Widget → Side-by-Side analysis → Direct agentic loop support**.

## Demonstrations

See [DEMO-RUNBOOK.md](DEMO-RUNBOOK.md).

- A complete Verso Manual file uses equality transport, checked Lean,
  mathematical notation, a declaration role, and a document reference.
- A deliberately small Blueprint exposes statement/proof facets, formal
  attachment, manual/automatic dependencies, source spans, retained TeX,
  ownership, tags, effort, priority, grouping, and derived progress.
- Two separately generated variants preserve Blueprint labels but attach
  incomplete/complete declarations. Completion changes a downstream task's
  proof readiness and the work queue.
- The five-node graph, summary, standalone panel, and CLI consume generated
  VBP data. No hand-maintained progress colors or fabricated query output.
- Frey and the full FLT graph are the real-project examples. The small graph
  remains available in the standalone demo.

The model diagram is now in the appendix. The dedicated anatomy, progress,
source-levels, CLI, and AI-review slides are removed. Features consolidates the
dependency, source-correspondence, project-state, and reuse capabilities. The
standalone before/after demos remain available for optional questions.

Section 5 is now: architecture, theorem syntax, rendered theorem, Frey node, FLT graph, code-first authoring,
Features, Validation. The small theorem deliberately separates introductory
syntax from the richer Frey example. Its attached inline Lean code compiles.
The After fixture now authors the same statement edges explicitly with `uses`;
manual origin takes precedence over inference. No node labels or edge targets
were changed. The Before fixture still demonstrates inferred statement edges.

The “why VBP?” slide argues for Lean-native authoring, connected evidence, and
programmable reuse. It explicitly credits LeanBlueprint's existing features;
it is not a claim that TeX is obsolete or that every project should migrate.

## Build and preview

From the repository root, using the already-built FLT artifact:

```bash
bash scripts/build-demo.sh
lake build
lake exe vbp-ucm-slides
python3 scripts/prepare-public-output.py _slides --source-root examples/verso-flt
```

Ordinary slide-only edits do not require regenerating unchanged demos.
The full cold workflow remains `scripts/build-pages.sh`.
No dependency pins were changed.

Serve with `python3 -m http.server 8877 --bind 127.0.0.1 --directory _slides`.
A server is already running at http://127.0.0.1:8877/; reuse it.

## Validation and boundaries

The feature pass compiled the deck and demo modules, generated all three demo
sites, checked both Blueprint variants with `vbp check` (11 entries each), and
queried actual dependencies/work queues. Publication normalization passed
without leaking local repository paths. The incomplete variant intentionally
contains `sorry`; the Verso source/output slide contains a checked proof.

Headless visual and interaction checks are recorded in the demo runbook.
The main-route visual/interaction review is in [REVIEW.md](REVIEW.md).
The browser assets are now bundled locally with verified checksums. Offline
interaction acceptance passes under a `/formath/` deployment prefix, including
native/embedded graphs, source provenance, Lean panels, and readiness badges.
Opening claims were reviewed against the authors' announcements and released
repositories, Buzzard's FLT checking report, and Clay's problem statement and
11 September announcement. Neither milestone artifact was independently rebuilt
or checked by the talk team. This is a source review, not a proof audit.

The deck now belongs to this ForMath repository. Preserve user edits, the
existing abstract and dependency pins, and the working generator. Do not
bootstrap another deck. Event metadata is confirmed; duration is provisional.

## Checkpoint and worktree retirement

The deck, demos, and build changes are checkpointed on `formath-bootstrap` at
`b93aac0` in the MadLean repository. This is a local checkpoint, not a push or
merge into the published MadLean talk.

Event metadata was finalized in `f56390f`. Integration merges that history with
the ForMath abstract and planning history. Each submodule has independent local
Git metadata and keeps its original revision and canonical upstream URL.
Build caches and generated artifacts are local conveniences, not tracked source.
Publication configuration and external demo source links remain separate
finishing work. The local offline/prefix rehearsal is automated in
`scripts/rehearse-offline.py` and is also wired into the Pages workflow.

Integration is committed as `6438117`. After validation, the clean bootstrap
worktree and its old preview server were removed. Its branch remains available
in the MadLean repository, and its commits are also ancestors of ForMath main.
The working preview now serves this repository at port 8877.
