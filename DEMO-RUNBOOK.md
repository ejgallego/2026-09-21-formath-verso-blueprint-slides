# ForMath demo runbook

Audience: experts in formal proof and Rocq, unfamiliar with Verso.
The current core teaches authoring syntax, then shows a substantial real node.

## Main route

- Verso: one document reference and one declaration hover, about two minutes.
- VBP: theorem syntax, Frey node, and an interactive graph, about three minutes.
- Code-first authoring and Features are short explanations, not extra demos.
- Validation ends the section with the four Codex-assisted LaTeX ports and the
  review harness. Open its external review page only if time permits.

The data-model diagram is in the appendix. The dedicated anatomy and progress
slides are removed. Their standalone pages remain optional resources.
The CLI is one line in Features, not a separate presentation segment.

## Preparation

Run in the ForMath repository root. The large pinned FLT artifact is already built.

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

Reuse http://127.0.0.1:8877/ while its existing server is running. Otherwise:

```bash
python3 -m http.server 8877 --bind 127.0.0.1 --directory _slides
```

Do not double-click HTML files: module/data loading needs HTTP.
For slide-only changes, reuse unchanged `_demo` outputs.
Styles are read from `static/custom.css` at generation time; a stylesheet edit
does not require recompiling Main.
The full cold workflow is `scripts/build-pages.sh`, including FLT generation.

## Demo 1: what Verso does (about 2 minutes)

Start on [the source and output slide](http://127.0.0.1:8877/#/3/1).
The actual file is [ForMathDemo/Verso.lean](ForMathDemo/Verso.lean).

1. Identify Lean imports, `#doc (Manual)`, and the transition into document markup.
2. Open [Applying a function](http://127.0.0.1:8877/demo/verso/Applying-a-function/).
3. Follow “applying a function”: it resolves the authored document target.
4. Hover `congrArg`: it shows the declaration type and documentation.
5. Hover `exact` to inspect the proof state. The proof is checked as part of
   the document build; the surrounding prose remains informal.

Fallback: the slide shows the document body (imports omitted) and a matching
capture of its rendered page. No live typing is required.

Spoken exit: “The document can resolve a declaration and check an example.
The surrounding exposition is still informal. Now we can add Blueprint-specific
objects to this document system.”

## Demo 2: theorem, Frey node, graph

The section opens with [the architecture](http://127.0.0.1:8877/#/4).

1. Start on [the theorem syntax](http://127.0.0.1:8877/#/4/1).
   Point out the stable label, authored dependencies, owner/tags, attached Lean
   block, and separate informal proof. The Lean block shares the node's label.
2. Show [the rendered theorem](http://127.0.0.1:8877/#/4/2).
   Its statement and informal proof come from the preceding source.
3. Open [the Frey node](http://127.0.0.1:8877/#/4/3).
   This deliberately uses a substantial FLT example rather than the elementary
   theorem from the syntax slide. Inspect its mathematical statement and Lean
   attachment. Explain the coordinate-changed Weierstrass model if needed.
4. Show [the FLT dependency graph](http://127.0.0.1:8877/#/4/4).
   Zoom in and open a node preview. It uses the same project as the Frey node.
5. [Code-first authoring](http://127.0.0.1:8877/#/4/5) shows the highlighted
   blueprint attribute. Features consolidates the capabilities.
6. [Validation](http://127.0.0.1:8877/#/4/7) closes with the reference ports.

The checked source is ForMathDemo/After.lean. The slide excerpt omits its
namespace, source-span record, and surrounding author/group registrations.
The labeled Lean block is adjacent to the theorem directive, as supported by
the pinned VBP authoring API. It attaches to the same node.

The After fixture now explicitly authors statement dependencies with uses.
autoDeps is also enabled on the inline Lean block, but manual origin takes
precedence for those edges. The labels and edge targets are unchanged.
The Before fixture retains its external declaration and inferred statement edges.

Fallback: stop on the theorem syntax and Frey node. Do not debug the graph live.

## Optional standalone demonstrations

- [After node panel](http://127.0.0.1:8877/demo/after/panel.html): source span,
  retained TeX, project metadata, and Lean attachment.
- [Before panel](http://127.0.0.1:8877/demo/before/panel.html): an incomplete
  declaration. Its Lean panel shows “[sorry in proof]”.
- The After Lean link now opens the attached inline proof code. It does not
  use the old external-declaration “[complete]” badge.
- Before/After summaries: Metadata, then Quick wins. The downstream corollary's
  proof readiness changes from “not ready” to “ready to formalize”; the
  corollary itself remains unformalized.
- Full FLT graph and the abstract data model are in the appendix.

These snapshots now also illustrate two authoring styles. They are not a
source diff containing only a proof-completion edit.

Optional queries:

```bash
lake exe vbp query --site _demo/after node left_inverse_injective
lake exe vbp query --site _demo/after uses left_inverse_injective
lake exe vbp query --site _demo/after work-queue
```

The three dependency targets remain left_inverse, injective, and
equality_transport. Before has two quick wins and After has one.
Query JSON is unstable. Source links in this unpublished repository are local.

## Repeatable checks

```bash
python3 -m unittest discover -s scripts -p 'test_*.py'
uv run --with playwright python scripts/rehearse-offline.py --output /tmp/formath-review
```

The script serves its own deployment prefix and blocks external requests.
It checks the revised section order, syntax highlighting, code readability,
Frey-node rendering, graph previews, and optional standalone demos.
Do not rebuild the shared output during a browser scan. Copy _slides and pass
--site /path/to/copy when another agent is generating the preview.

D3/Graphviz, Marked, and fonts are bundled locally. External reference links
still require internet access. The in-app browser was unavailable, so browser
checks use headless Chrome. Speaking time and projector readability still need
a live rehearsal.

Both small Blueprint sites pass vbp check with 11 manifest/cache entries.
The before fixture intentionally contains sorry. The Verso source/output slide
shows a checked proof; the old expected-error slide is removed. Dependency pins
remain unchanged.
