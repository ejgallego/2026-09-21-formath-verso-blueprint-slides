# ForMath demo runbook

Audience: expert in formal proof and Rocq; unfamiliar with Verso.
Show document structure and mathematical coordination, not a proof-assistant tutorial.

## Rehearsal route

These are target budgets, not measured speaking times. The three demonstrations
take about seven minutes within the Verso and VBP sections.

| Demonstration | Budget | Audience takeaway | Stop after |
| --- | --- | --- | --- |
| Verso source and reader | 2 min | A document extension can resolve Lean objects and check code. | One document reference and one declaration hover. |
| Node, model, graph | 3 min | A Blueprint object connects a mathematical account to evidence and other nodes. | One source panel, one Lean panel, one graph preview. |
| Completion and readiness | 2 min | Completing a proof changes which downstream work is ready. | The theorem's status and the corollary's proof readiness. |

Lead-in: “The mathematics is deliberately elementary. Watch what the document
knows about it, and what changes when its formal evidence changes.”

The model slide is the pause between browsing the node and exploring the graph.
Keep ownership/tags, the full FLT graph, graph layout controls, live proof typing,
and terminal queries optional. The CLI slide is a short coda, not a fourth demo.
If a live control fails once, use the source/model slide and the verified
before/after table below instead of debugging in front of the audience.

## Preparation

Run in this worktree. The large pinned FLT artifact is already built.

```bash
bash scripts/build-demo.sh
lake build
lake exe vbp-ucm-slides
python3 scripts/prepare-public-output.py _slides --source-root examples/verso-flt
lake exe vbp check --site _slides/demo/before
lake exe vbp check --site _slides/demo/after
```

The before variant intentionally warns about `sorry`. The after proof is complete.
The deck's expected-error example is also intentional. Existing VBP universe
linter warnings are unrelated. Neither warning is a reason to change dependency pins.

Reuse http://127.0.0.1:8876/ while its existing server is running. Otherwise:

```bash
python3 -m http.server 8876 --bind 127.0.0.1 --directory _slides
```

Do not double-click HTML files: module/data loading needs HTTP.
For slide-only changes, reuse unchanged `_demo` outputs.
Styles are read from `static/custom.css` at generation time; a stylesheet edit
does not require recompiling Main.
The full cold workflow is `scripts/build-pages.sh`, including FLT generation.

## Demo 1: what Verso does (about 2 minutes)

Start on [the complete source slide](http://127.0.0.1:8876/#/3/1).
The actual file is [ForMathDemo/Verso.lean](ForMathDemo/Verso.lean).

1. Identify Lean imports, `#doc (Manual)`, and the transition into document markup.
2. Open [Applying a function](http://127.0.0.1:8876/demo/verso/Applying-a-function/).
3. Follow “applying a function”: it resolves the authored document target.
4. Hover `congrArg`: it shows the declaration type and documentation.
5. Return to the diagnostics slide. Successful code and expected failure are
   both enforced at build time; prose is not thereby verified.

Fallback: the slide contains the whole compiled file. No live typing is required.

Spoken exit: “The document can resolve a declaration and check an example.
The surrounding exposition is still informal. Now we can add Blueprint-specific
objects to this document system.”

## Demo 2: anatomy, model, and graph (about 3 minutes)

Start on [node anatomy](http://127.0.0.1:8876/#/4/2).
For larger popovers use the
[standalone panel](http://127.0.0.1:8876/demo/after/panel.html).

1. Read the statement and its separate informal proof.
2. Open the source chip. It records a document, citation, anchor, and text span.
   “Source note” opens the actual note authored for this demonstration.
3. Open the Lean attachment: declaration identity and completion evidence.
   Use the editor source below if showing the actual proof body.
4. Pause on [the model diagram](http://127.0.0.1:8876/#/4/3). The central
   object has its own label. Its informal statement and proof are optional
   facets. Dashed links are associations. Arrows run from prerequisite nodes
   towards the dependent statement or proof, as in the graph.
5. Explain the dependency tracks. The theorem type refers to `left_inverse`
   and `injective`; these edges are automatic. `equality_transport` is an
   explicitly authored proof dependency.
6. Open the [five-node graph](http://127.0.0.1:8876/#/4/6). Find the same
   theorem, its prerequisites, and the downstream `fibre_singleton` corollary.
   Open one node preview, then stop. Save the summary for the progress demo.

Spoken exit: “The document and graph refer to the same mathematical objects.
The graph currently shows the completed theorem. What happens when its proof
is unfinished?”

Optional depth: owner, tags, effort, priority, and grouping are useful project
metadata. Group membership does not create a dependency. The diagram omits
these fields to keep the core relationships readable.

Retained TeX is an informal representation, separate from original-source
provenance. Neither proves informal/formal correspondence. The Frey example
makes this distinction substantive through its coordinate-changed model.

The panel calls the public preview API and loads the same emitted page runtime
as the canonical site, supplying native relation/nested-preview behavior.
It does not import private `Commands/*` implementations.
The page-runtime import is important: the preview renderer alone inserts the
node, but the rich dependency panels otherwise remain at “Loading preview.”

## Demo 3: a real state change (about 2 minutes)

Start on [formal progress](http://127.0.0.1:8876/#/4/7).

Use Before / After. The Blueprint label and informal content stay the same;
the two fixtures attach declarations in Draft and Complete namespaces.
The Lean attachment changes from “sorry in proof” to “complete.”

Pre-open the [Before summary](http://127.0.0.1:8876/demo/before/Blueprint-Summary/)
and [After summary](http://127.0.0.1:8876/demo/after/Blueprint-Summary/).
In each, expand **Metadata**, then **Quick wins**, and locate `fibre_singleton`.
Its row carries the explicit `proof:` readiness badge. The ordinary entry index
does not display this detail, so prepare these expanded views before speaking.
After switching the theorem, compare the downstream corollary's proof readiness.
Do not narrate this as a new proof of the corollary: it still needs formalization.

Spoken exit: “Completing this proof makes the corollary ready to work on.
The mathematical plan stayed the same; its formal evidence and derived
project state changed.”

Optional terminal coda, using actual queries:

```bash
bash scripts/demo-query.sh before
bash scripts/demo-query.sh after
```

Expected evidence:

| Query | Before | After |
| --- | --- | --- |
| Main theorem in work queue | Present; next step proof | Absent |
| Downstream corollary proof status | not ready | ready to formalize |
| Downstream corollary in queue | Present | Still present; it has no formal attachment |
| Main theorem statement uses | left_inverse, injective; automatic | Same |
| Main theorem proof uses | equality_transport; manual | Same |

Completion here is an observed status in the generated artifact, not a claim
that the informal account has been mathematically audited. Query JSON currently
reports `apiStability: unstable`.

Optional editor demonstration: open [Before.lean](ForMathDemo/Before.lean) and
replace its `sorry` with the proof in [After.lean](ForMathDemo/After.lean), retaining
the Draft namespace. Run the preparation commands and reload. This changes the
before fixture; restore only that deliberate edit after rehearsal. Do not reset
the entire file/worktree. Prefer the prebuilt snapshots for a short live talk.

Click outside the iframe to return keyboard focus to the slides.
Graph/Summary links open another tab; Before/After stays in the panel.

The new demo modules have not been published. Their generated external
declaration source links currently use the inherited repository location,
where these files do not exist. A local commit alone does not make those links
resolvable. Show the local editor files for Lean source, not those GitHub
links. The separate mathematical source-note link is local and works.

## Validation record and limits

With the local server running, repeat the interaction rehearsal with:

```bash
uv run --with playwright python scripts/check-demo-browser.py
```

Pass `--screenshots /tmp/formath-rehearsal` to retain captures, or `--url`
and `--browser` to select another local server or system Chrome executable.
This checks the intended clicks and visible results, not speaking time.

21 September 2026:

- All three demo documents and the deck compiled/generated.
- Both original and published small Blueprint variants passed `vbp check`
  with 11 manifest/cache entries each.
- Real queries confirmed the dependency and work-queue changes above.
- Generated HTML contains 27 main slides including title, plus 11 backup.
- Publication normalization removed 2,526 local source-path occurrences.
- Headless Chrome checked the source-file, diagnostics, comparison, model,
  authoring, roadmap, anatomy, and five-node graph layouts at 1280×720.
- Browser checks exercised Before/After navigation, source and Lean attachment
  panels, dependency previews with automatic-origin badges, and the Manual's
  document reference and declaration hover. No page errors were recorded.
- The narrative pass also exercised the graph's theorem preview and the
  Before/After summary readiness badges under Metadata / Quick wins.
- The opening pass checked all three revised slides for text overflow and
  repeated the reference, graph-preview, snapshot, and readiness interactions.

The in-app browser connection was unavailable; these checks used local headless
Chrome. Full offline, deployment-prefix, all graph controls, and whole-deck acceptance
remain outstanding. Upstream pages and inherited styling may use remote assets.
The opening now includes dated primary sources and qualifications in speaker
notes. Neither milestone artifact was independently rebuilt or checked here.
Inherited event metadata still needs confirmation. No changes were made to the
pinned VBP dependency.
