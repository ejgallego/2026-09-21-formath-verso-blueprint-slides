# ForMath deck: current authoring map

Updated 21 September 2026. Audience: experts in formal proof and Rocq,
unfamiliar with Verso. Explain the document system, not proof assistants.

Active source: [Slides.lean](Slides.lean), in the ForMath repository root.
Confirmed event: ForMath Seminar, IRIF, Université Paris Cité, Monday,
21 September 2026. Speaker: Emilio Jesús Gallego Arias, Lean FRO.
Five substantive sections, plus backup. The main route has 27 slides including
the title; backup has 11. Horizontal sections retain vertical children.
40 minutes remains a provisional budget: rehearse and cut optional demos.

## Main route

| Section | Current content | Remaining editorial work |
| --- | --- | --- |
| Actual context | FLT and Prove2Me coordination; smooth-forced Navier–Stokes, Clay C/D; blueprints before and after formalization | Three substantive slides with dated primary sources and reported checking evidence in notes. Keep the community FLT demo distinct from Anthropic's artifact. Recheck announcement status before delivery. |
| Historical context | Blueprint lineage, LeanBlueprint, coordination | Retain attribution and the distinction between sphere eversion origins and later Liquid Tensor use. |
| Verso | Language boundary and document kinds; complete compiled document; checked code and enforced diagnostic; document/Lean references; extensions | Rehearse the source-to-rendered-document demonstration. No Lean tutorial. |
| Verso Blueprint | Why another implementation; real Frey node; rich node anatomy; model diagram; prose/code authoring; dependency tracks; small graph; proof progress and summary; sources; public queries; AI review; boundaries | Rehearse the three timed demonstrations in the runbook. A recorded migration defect/correction remains optional future detail work. |
| What's next | Shared infrastructure; speaker's five ordered roadmap items; closing | No delivery dates. The first item means formalizing VBP's custom database. |

Roadmap order: **Formalizing VBP's custom database → improved skill → side-by-side
views → GitHub, Prove2Me, Trellis integrations → direct agentic loop support**.
This supersedes the earlier month-by-month proposal.

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
- Frey remains the real-project example; the full FLT graph is in backup.

The model slide uses an editable native Verso/Illuminate diagram grounded in
the same demonstration node. It separates optional informal facets, source
and declaration associations, and dependencies on other nodes. The graph now
precedes the proof-progress demo, so the downstream readiness change has an
explicit mathematical context. The runbook supplies target timings, spoken
transitions, stopping points, optional material, and fallbacks.

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

Serve with `python3 -m http.server 8876 --bind 127.0.0.1 --directory _slides`.
A server is already running at http://127.0.0.1:8876/; reuse it.

## Validation and boundaries

The feature pass compiled the deck and demo modules, generated all three demo
sites, checked both Blueprint variants with `vbp check` (11 entries each), and
queried actual dependencies/work queues. Publication normalization passed
without leaking local repository paths. The incomplete variant intentionally
contains `sorry`; the diagnostics slide intentionally requires an error.

Headless visual and interaction checks are recorded in the demo runbook.
These do not constitute full offline, deployment-prefix, or whole-deck acceptance.
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
Publication configuration, external demo source links, and full offline/prefix
testing remain separate finishing work.
