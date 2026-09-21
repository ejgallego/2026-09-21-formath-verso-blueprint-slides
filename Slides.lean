import VersoSlides
import VersoBlueprint.Graft
import VersoBlueprint.Slides
import Verso.Doc.Concrete
import Lib.Widgets

open VersoSlides

set_option verso.code.warnLineLength 100

#doc (Slides) "Verso Blueprint: Reimagining Blueprints for the AI Era" =>

# Verso Blueprint: Reimagining Blueprints for the AI Era

[Emilio Jesús Gallego Arias](https://x80.org/emilio)

Senior Research Engineer — Lean FRO

ForMath Seminar, IRIF, Université Paris Cité

Monday, 21 September 2026

# AI Is Changing Mathematics

%%%
vertical := some true
%%%

:::hstack

- AI systems are producing *serious mathematics*.
- Mathematicians need ways to _inspect_, _guide_, and _trust_ the process.
- _Mathematical output_ now includes complex artifacts that are hard to digest.
- Mathematics and computer science are facing a _hard_ challenge.

{image "static/images/slide_1.1_erdos.png"}[Erdos' Unit Problem Solution Tweet by Timothy Gowers]

:::

*Timothy Gowers*:

> "If you are a mathematician, then you may want to make sure you are sitting down before reading further."

:::notes
Adapted from the opening slide of the Madrid presentation. The Gowers image and
quotation introduce the change in pace; the next examples make the question of
human inspection concrete.
:::

## Sphere Packing In Dimension Eight

::::vstack

{arxiv "2604.23468" (title := "A Milestone in Formalization: The Sphere Packing Problem in Dimension 8") (authors := "Hariharan, Birkbeck, Lee, Ma, Mehta, Poiroux, Viazovska") (published := "Submitted Apr 25, 2026; v2 Apr 28, 2026") (summary := "The dimension-8 sphere-packing result was formally verified in February 2026, with final stages carried out by Math Inc.'s Gauss model.")}

:::center
{image "static/images/math_inc_2.png"}[Math Inc announcement of the formalization]
:::

::::

## The Sphere Packing Blueprint

:::::vstack

Auto-formalization crucially relied on a pre-existing Blueprint, and filled the gaps.

::::class "sphere-images"
:::hstack

{image (width := "95%") "static/images/sp_index.png"}[Sphere-packing blueprint start page]

{image (width := "95%") "static/images/sp_graph.png"}[Sphere-packing blueprint graph]

:::
::::

*Blueprint was essential, but how can we measure its importance?*

:::::

:::notes
These are the sphere packing slides from the Madrid deck, moved into the
opening. The Blueprint is the project map, not the checker. Emphasize its role
in coordinating a large formalization.
:::

## Fermat's Last Theorem: Scale

::::hstack

:::class "milestone-stat"
*13 million* Lean lines
:::

:::class "milestone-stat"
*30,300* theorems proved
:::

::::

Anthropic completed a [Lean formalization of FLT](https://www.anthropic.com/research/formalizing-fermats-last-theorem), following the Darmon–Diamond–Taylor exposition.

```html
<video class="flt-progress-video" src="flt-progress.mp4" poster="flt-progress-poster.png" muted loop playsinline controls preload="metadata" aria-label="Time progression of Anthropic's FLT formalization"></video>
```

*How do we handle a proof of this size?*

:::notes
The 13 million lines and 30,300 theorems are Anthropic's reported figures;
29,500 theorems occur in the final proof. Kevin Buzzard reports compiling the
released artifact and running the statement comparator. His community FLT
project and its Blueprint are distinct from Anthropic's artifact.

The theorem was already known. This achievement formalizes the
Darmon–Diamond–Taylor account of the Wiles–Taylor–Wiles argument. Buzzard's
community project follows a different, modern route and also aims to supply
reusable library contributions and an explorable mathematical document.

[Anthropic announcement, 4 September 2026](https://www.anthropic.com/research/formalizing-fermats-last-theorem)

The animation is Anthropic's “Time progression of FLT formalization” from that
announcement. The slide opens on a late frame; play the muted clip when ready.

[Released Lean artifact](https://github.com/anthropics/fermats-last-theorem)

[Buzzard's checking report and assessment, 4 September 2026](https://xenaproject.wordpress.com/2026/09/04/flt-anthropic-has-beaten-me-to-it/)
:::

## FLT: The Plan Behind The Proof

:::class "flt-opening-quote"
Anthropic: “... agents quickly lost track of the project’s state and stopped collaborating effectively.”
:::

:::class "flt-plan-image"
{image (width := "100%") "static/images/flt-plan.png"}[Anthropic's Prove2Me plan showing the Mazur, Ribet, and Wiles branches leading to FLT]
:::

:::class "flt-solution-quote"
Anthropic: “The effort succeeded when we switched to using Prove2Me”
:::

:::class "flt-functions"
- A theorem DAG kept tasks and dependencies visible.
- Separate statement and proof files made compilation cheaper.
- Natural-language descriptions made theorems easier to find and reuse.
:::

:::notes
Anthropic reports that unsuccessful attempts left about 7% of the final
non-boilerplate lines. The two short quotations come from its account; the
three bullets paraphrase Prove2Me's functions. This is the team's account of
its workflow, not a controlled comparison or a claim that Verso Blueprint
powered the result.

[Anthropic announcement](https://www.anthropic.com/research/formalizing-fermats-last-theorem)
:::

## Where is mathematics going?

:::class "math-direction-event"
*2 June 2026 · [Leiden Declaration](https://leidendeclaration.ai/)*
Mathematical practice in the age of AI agents.
:::

:::class "math-direction-event"
*4 September 2026 · [Anthropic's FLT formalization](https://www.anthropic.com/research/formalizing-fermats-last-theorem)*
Pushed the frontier on what's possible autonomously.
:::

:::class "math-direction-event"
*11 September 2026 · [A Severe Misalignment of AI in Mathematics](https://mathandai.org/)*
Do AI startups' incentives harm mathematical practice?
:::

:::class "math-direction-response"
[SAIR's open models initiative](https://sair.foundation/open-math-model/) argues for tools the community can inspect and shape, independent of market constraints.
:::

:::class "math-direction-conclusion"
We must provide tools to help address these issues and smooth human/agent interaction.
:::

:::notes
The user called the third reference “SIAR”; the organization is SAIR. Its
initiative page carries no publication date, so it is shown outside the dated
sequence. These statements differ in emphasis. The slide extracts the concerns
most relevant to this talk and does not imply endorsement of every position.

A Blueprint records links and evidence. It does not itself certify that prose
faithfully represents a formal statement or proof. Nor did the FLT or NS
milestones use Verso Blueprint.

Transition: coordination and mathematical reading already mattered in large
formalization projects before the current wave of AI tools.

[Leiden Declaration, 2 June 2026](https://leidendeclaration.ai/)

[Anthropic FLT announcement, 4 September 2026](https://www.anthropic.com/research/formalizing-fermats-last-theorem)

[Math and AI declaration, 11 September 2026](https://mathandai.org/)

[SAIR Open Models initiative](https://sair.foundation/open-math-model/)
:::

# Blueprint: Historical Context

%%%
vertical := some true
%%%

:::::vstack

- *Feit-Thompson Theorem (~2010)*: Custom system to track progress, generated by CI
- *Flyspeck (~2010)*: _Mathwiki_

Large-scale formal developments pose many coordination and alignment challenges.

:::hal "hal-00816699" (title := "A Machine-Checked Proof of the Odd Order Theorem") (authors := "Gonthier, Asperti, Avigad, Bertot, Cohen, Garillot, Le Roux, Mahboubi, O'Connor, Ould Biha, Pasca, Rideau, Solovyev, Tassi, Thery") (published := "Submitted to HAL Apr 22, 2013") (venue := "ITP 2013, LNCS 7998, pp. 163-179") (url := "https://hal.inria.fr/hal-00816699") (pdf := "https://www.msr-inria.fr/files/hal-00816699/file/main.pdf")
The paper reports the machine-checked formal proof of the Feit-Thompson Odd
Order Theorem in Coq/Rocq, built on the Mathematical Components library.
:::

:::::

## LeanBlueprint

::::class "leanblueprint-history"

- Created by [Patrick Massot](https://www.imo.universite-paris-saclay.fr/~patrick.massot/)
  for [sphere eversion](https://leanprover-community.github.io/sphere-eversion/) (2020),
  then used for the Liquid Tensor Experiment.
- [LeanBlueprint](https://github.com/PatrickMassot/leanblueprint) extends
  LaTeX/plasTeX with dependencies, graph rendering, and formalization status.
- Widely used and very influential across Lean projects; it is our starting point.

:::class "leanblueprint-graph"
{image "static/images/lte2.png"}[Liquid Tensor Experiment Blueprint dependency graph]
:::

::::

## Why Build Verso Blueprint?

:::class "why-vbp-lead"
A shared mathematical plan is most useful when it tracks changes in the Lean
development.
:::

Verso Blueprint gives each mathematical object a stable label connecting its
explanation, Lean evidence, dependencies, and status.

Readers, contributors, and agents can then work from the same project state
and checking evidence.

:::notes
The historical blueprints established a way to coordinate mathematical work.
LeanBlueprint already provides dependency graphs, progress, and links to Lean.
The aim here is tighter Lean integration and programmable reuse, building on
that model. This does not claim that every project should migrate from TeX.
LeanBlueprint also checks declaration names with checkdecls.
Links and formal completion do not establish that the informal account is
mathematically equivalent to the Lean declaration; that still needs review.

LeanArchitect is another example of using a blueprint to coordinate people
and AI tools: https://arxiv.org/abs/2601.22554.
:::

# What Is Verso?

%%%
vertical := some true
%%%

Verso is an extensible document system implemented in Lean.

```code lean
import VersoManual
open Verso.Genre
#doc (Manual) "A mathematical document" =>
```

Above `#doc`: Lean imports and declarations.
After `=>`: document markup, with extensions supplied by those imports.

The document kind, here `Manual`, determines its structure and rendering.

:::notes
The audience knows Rocq and formal proof. Explain the language boundary, not
proof assistants. Blueprint extends Manual; this presentation uses Slides.
:::

## A Complete Verso Document

:::class "feature-source"
````code lean
import VersoManual
open Verso.Genre Verso.Genre.Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Equality transport" =>
# Applying a function
%%%
tag := "transport"
%%%
If $`x = y`, then $`g(x) = g(y)`.
The Lean declaration is {name}`congrArg`.

```lean
#check congrArg
```
Return to {ref "transport"}[applying a function].
````
:::

[Open the rendered document](demo/verso/Applying-a-function/)

:::notes
The file starts in Lean. The #doc command introduces a document whose markup
can call extensions supplied by the imports. Manual is one document kind.
Open the rendered page, follow the document reference, then hover congrArg.
The reader sees prose, but this name still has its declaration and type.
Return to the next slide: what does the build check?
:::

## Elaboration And Diagnostics

The embedded code is elaborated during the document build.

```lean -panel -stretch
example (g : Nat → Nat) (x y : Nat) (h : x = y) :
    g x = g y := congrArg g h
```

This block requires an error; an unexpected success fails the document build.

```lean +error -panel -stretch
example (x y : Nat) : x = y := rfl
```

:::notes
The first example elaborates. The second is deliberately false in general,
and its error is expected. Both belong to the document's build contract.
The mathematical prose remains informal. This is the boundary between a
checked document extension and verification of the surrounding exposition.
:::

## Links With Mathematical Context

A Lean name resolves in the elaboration environment: {name}`congrArg`.

```code verso
The Lean declaration is {name}`congrArg`.
Return to {ref "transport"}[applying a function].
```

A document reference resolves an authored target.
A Lean reference carries information about a declaration.

[Rendered reference and declaration](demo/verso/Applying-a-function/)

:::notes
Recall the reference and hover just shown. A document target belongs to the
document structure; congrArg resolves in Lean's elaboration environment.
VBP will add a third kind of identity: the mathematical object in a blueprint.
:::

## From Document Extensions To Blueprint Objects

Imports supply roles, directives, elaboration, and rendering.

```code verso
:::theorem "left_inverse_injective"
A function admitting a left inverse is injective.
:::
```

The Blueprint extension registers a mathematical object under this label.

Its statement, proof, attachments, and relationships can contribute from
different parts of the document or imported modules.

:::notes
Verso provides the document framework. VBP extends the Manual genre with the
Blueprint model. The slide genre can reuse the resulting Blueprint objects.
:::

# A Theorem In Verso Blueprint

%%%
vertical := some true
%%%

:::class "theorem-source"
````code verso
:::theorem "left_inverse_injective"
    (uses := "left_inverse, injective")
    (owner := "presenter") (tags := "functions, demo")
A function admitting a left inverse is injective.
:::

```lean "left_inverse_injective" (autoDeps := true)
theorem leftInverseInjective (f g : Nat → Nat)
    (hgf : LeftInverse f g) : Injective f := by
  intro x y h
  exact (hgf x).symm.trans ((transportEq g h).trans (hgf y))
```

:::proof "left_inverse_injective" (uses := "equality_transport")
Apply g to the equality, then use the left-inverse identity.
:::
````
:::

One label connects the mathematical statement, Lean declaration, and proof.

:::notes
The statement and proof have separate mathematical dependencies. The labeled
Lean block attaches a checked declaration to the same node. autoDeps also
reads its elaborated type and proof. Owner and tags are project metadata.
The prerequisite definitions and author registration come from the surrounding
document. The namespace and source-span metadata are omitted in this excerpt.
The rendered Frey node next shows a richer mathematical example from FLT.
:::

## Reading A Node: The Frey Curve

{blueprint_node "FreyCurve" (siteBase := "blueprint")}

:::notes
Start with the mathematics and the actual formal attachment. Frey is the real
project example; switch to the small authored example for controlled changes.
Explain the change of Weierstrass model when opening the declaration.
:::

## The Dependency Graph

{blueprintGraph (base := "demo/after/") (view := "full") (direction := "TB") (pack := "true") (class := "flt-graph-frame demo-graph-frame")}

[Open the progress summary](demo/after/Blueprint-Summary/)

:::notes
Locate `left_inverse_injective`, its prerequisites, and the downstream
`fibre_singleton` corollary. Open one node preview to recover the mathematics.
The same labels identify the mathematical objects in the document and graph.
This is the small theorem from the syntax slide, not the much larger FLT graph.
Leave the full FLT graph, layout controls, and legend tour for questions.
:::

## Code-First Authoring

```code lean
@[blueprint "equality_transport"]
theorem transportEq (g : Nat → Nat) {a b : Nat} (h : a = b) :
    g a = g b := congrArg g h
```

A declaration can introduce a Blueprint node through `@[blueprint]`.

Prose elsewhere can contribute its statement and proof under the same label.

Use `lean := "Existing.declaration"` to associate existing compiled code.

:::notes
This declaration comes from ForMathDemo/Common.lean and supports the small
theorem example. The label identifies the mathematical node. The Lean name
identifies the declaration. They serve different purposes.
:::

## Features

- *Mathematical content*: statement, informal proof, checked Lean, and retained TeX.
- *Dependencies*: authored or inferred, with separate statement and proof dependencies.
- *Source correspondence*: original document and spans, informal node, formal attachments.
- *Project information*: groups, owners, tags, effort, and priority.
- *Progress*: formalization status and downstream readiness from the generated development.
- *Reuse*: readers, graphs, summaries, slides, and CLI/API clients share the same nodes.

:::notes
uses adds a mathematical dependency. bpref adds a prose link without an edge.
autoDeps reads elaborated declarations and retains the automatic origin.
Source spans, informal exposition, and formal attachments are distinct levels.
A link between them does not certify mathematical equivalence.
The public preview API can render a node in another application. CLI JSON
and custom-client formats are currently unstable and should be pinned.
Readiness describes a generated snapshot. Rich side-by-side integration and
direct agentic loops belong to the roadmap.
:::

## Validation

We ported using Codex these selected LaTeX examples of blueprints:

- [Kevin Buzzard’s FLT blueprint](https://github.com/ejgallego/verso-flt)
- [Sphere Packing](https://github.com/ejgallego/verso-sphere-packing)
- [Carleson Operators on Doubling Metric Measure Spaces](https://github.com/ejgallego/verso-carleson), by Floris van Doorn
- [Noperthedron](https://github.com/ejgallego/verso-noperthedron), by David Renshaw and Jason Reed

The harness checks structure and Lean links, and supports comparison with
the source and rendered output.

[Review a migration](https://x80.org/flt-translation-review/)

:::notes
The migrations exercised the authoring and rendering features on existing
mathematical projects. The harness exposes translation errors such as label
drift, missing structure, or weak source correspondence. These checks support
human review. They do not prove equivalence between the original text and
the formal declarations. The harness diagram is in the appendix.
:::

# What's Next?

%%%
vertical := some true
%%%

Develop VBP as shared infrastructure for mathematical reading,
formalization, and AI-assisted work.

The next steps connect its data model, authoring tools, review interfaces,
and project workflows.

## Expected Roadmap Sequence

1. *Formalizing VBP's custom database*
2. *Improved skill*
3. *Side-by-side views*
4. *GitHub, Prove2Me, and Trellis integrations*
5. *Direct agentic loop support*

Expected order, with timing to be determined.

:::notes
These are the speaker's priorities in temporal order. No delivery dates are
assigned. Present the already available source metadata, CLI, and embedding
APIs as foundations; distinguish those from the planned integrated experience.
:::

## Shared Mathematical Context

A blueprint gives readers and tools a common account of the mathematics.

Formal evidence, source correspondence, and project state stay inspectable.

Let us know how Verso Blueprint could help with your work.

## Thanks, Questions?

# Backup: Architecture

%%%
vertical := some true
%%%

[https://github.com/leanprover/verso-blueprint](https://github.com/leanprover/verso-blueprint)

:::hstack

- Directly inspired by LeanBlueprint, LeanArchitect, and Side to Side
- *Core model in Lean*: labels, nodes, metadata, code links, status
- *Document layer in Verso*: rich, extensible markup and interactive output
- Same data feeds graphs, summaries, previews, slides, and tools

{image (width := "96%") "static/images/vbp-architecture.svg"}[Verso Blueprints architecture diagram]

:::

## Navier–Stokes: A Different Scale

::::hstack

:::vstack

OpenAI announced breakdown results on 8 September 2026 for *three-dimensional
incompressible Navier–Stokes with smooth forcing*.

The mathematical manuscript and Lean artifact are far shorter than the FLT
formalization. Understanding the construction still takes mathematical work.

The result addresses Clay alternatives *C and D*, for the whole-space and
periodic cases.

:::

:::class "ns-visual"
{image (width := "100%") "static/images/navier-stokes.webp"}[Visualization of inward spiral and axial stretching in the Navier–Stokes construction]
:::

::::

:::notes
The announced result concerns positive viscosity, smooth initial data, and
smooth external forcing. C concerns the whole space and D the periodic case.
Both are explicitly accepted alternatives in Clay's problem statement.
This does not establish breakdown for the unforced Navier–Stokes problem.
Keep the accompanying unforced Euler result separate.

Clay's 11 September statement describes an apparent settlement and an ongoing,
deliberately unhurried evaluation process. It is not a prize adjudication.
The released repository includes comparator challenges and instructions.
The exposition and formal artifact serve different reading needs.

[OpenAI announcement, 8 September 2026](https://openai.com/index/navier-stokes-solution/)

The image was supplied for this talk and illustrates the inward spiral and
axial stretching described in OpenAI's announcement.

[Released Lean artifact and checking instructions](https://github.com/openai/NavierStokesAndEuler)

[Clay's official problem statement](https://www.claymath.org/wp-content/uploads/2022/06/navierstokes.pdf)

[Clay statement, 11 September 2026](https://www.claymath.org/news/navier-stokes-announcement/)
:::

## The Abstract Data Model

```diagram (background := "#ffffff")
open Illuminate Lean in
let ink := rgb!"#1e293b"
let teal := rgb!"#007da5"
let txt (s : String) (size : Float := 15) (bold := false) : Diagram SVG :=
  Diagram.text s { fontSize := size, fontFamily := "sans-serif", color := ink, bold }
let item (name : Name) (title body : String) : Diagram SVG :=
  Diagram.vsep 7 [txt title 16 true, txt body]
    |>.padXY 8 7
    |>.namedWithAnchors name
let identity :=
  Diagram.vsep 7 [txt "Blueprint node" 17 true,
    Diagram.text "left_inverse_injective"
      { fontSize := 15, fontFamily := "monospace", color := teal }]
    |>.padXY 8 7
    |>.namedWithAnchors `identity
    |>.translate 0 105
let statement := item `statement "Informal statement" "Left inverse implies injectivity"
    |>.translate 0 20
let proof := item `proof "Informal proof" "Apply g to the equality"
    |>.translate 0 (-65)
let node := identity.compose statement |>.compose proof
    |>.padXY 16 16
    |>.filledFrame (fill := rgb!"#f0f9fc")
      (stroke := { color := teal, width := 1.5 })
let source := item `source "Source reference" "demo-notes\nProposition 1, lines 3–7"
    |>.translate (-315) 105
let lean := item `lean "Lean association" "leftInverseInjective"
    |>.translate 315 105
let statementDeps := item `statementDeps "Statement dependencies" "left_inverse\ninjective"
    |>.translate (-315) 20
let proofDeps := item `proofDeps "Proof dependency" "equality_transport"
    |>.translate 315 (-65)
let ah : Arrowhead := { type := .stealth }
node.compose source |>.compose lean |>.compose statementDeps |>.compose proofDeps
  |>.connect `identity.west `source.east
    (stroke := { color := rgb!"#64748b", width := 1.2, dash := .dashed })
  |>.connect `identity.east `lean.west
    (stroke := { color := rgb!"#64748b", width := 1.2, dash := .dashed })
  |>.connect `statementDeps.east `statement.west (arrowhead := ah)
    (stroke := { color := teal, width := 1.5 })
  |>.connect `proofDeps.west `proof.east (arrowhead := ah)
    (stroke := { color := teal, width := 1.5 })
```

:::class "model-key"
Small controlled example: `left_inverse_injective`.

Dashed links: associations. Arrows: prerequisite to dependent.

Progress and readiness derive from formal evidence and dependencies.
:::

:::notes
The center is one mathematical object with its own stable label. Statement and
proof are optional facets; their contributions may come from separate places.
The dashed links connect it to source passages and Lean declarations. In
general there may be several, and declaration associations are many-to-many.
Each solid edge relates this node to another Blueprint node, not a raw
declaration name. Arrows point from prerequisite towards the dependent facet,
matching the graph convention.
Here the statement edges are automatic and the proof edge is authored.
Owner, tags, priority, effort, grouping, and retained markup are additional
metadata, omitted from the picture. Group membership is not a dependency.
Progress is computed from the evidence and graph; it is not an authored badge.
Recording an association does not establish mathematical equivalence.
:::

## Blueprint Data Model

:::::hstack

:::vstack

- globally stable label
- informal statement and proof facets
- dependencies and reverse dependencies
- parent group, owner, tags, priority, effort
- one-to-many code relationships
- Lean declarations, inline code, and other source witnesses

:::

::::attr (style := "flex: 1.35 1 0; align-self: stretch;")
:::vstack

```
Informal.Data
  labels  : LabelMap Node
  groups  : LabelMap Group
  authors : AuthorMap Author
  sources : SourceMap Source

Node(label)
  identity
    global label
    parent? / group?

  mathematical facets
    statement?
    proof?
    source witnesses

  project metadata
    owner? tags priority effort
    uses / used-by

  formal attachments
    Lean declarations
    inline Lean / Rust blocks
    status and preview keys
```

:::
::::

:::::

## DeepMind: 9 Erdos Problems Solved In Collaboration With Lean

:::::vstack

::::hstack

:::arxiv "2605.22763v1" (title := "Advancing Mathematics Research with AI-Driven Formal Proof Search") (authors := "Tsoukalas et al.") (published := "Submitted May 21, 2026")
The paper reports AI-driven formal proof search over open Erdos problems and
OEIS conjectures, using Lean verification as the guardrail.
:::

{image "static/images/slide_2.2_deepmind.png"}[DeepMind Erdos solution]
::::

The May 2026 DeepMind formal-proof-search result makes *Lean* and *Mathlib* central to the proving loop.
:::::

## Formal Frontiers: Side-By-Side Demo

[Mathlib Initiative](https://mathlib-initiative.org/) supports the scaling
infrastructure around Mathlib and research formalization.

[Formal Frontiers](https://github.com/FormalFrontier/Etingof-RepresentationTheory-draft1)
is a new project for responsible AI-based autoformalization.

::::hstack

:::vstack

- Source document, generated VBP nodes, and Lean files become one review problem.
- The review surface is a projection of the structured output.
- Demo: [https://x80.org/vbp-etingof/blueprint/source-compare.html](https://x80.org/vbp-etingof/blueprint/source-compare.html)
:::

::::

## A Proposed Human-AI Workflow

::::hstack

:::vstack

Proposed workflow: use a blueprint node to organize a bounded formalization task.

- *select*: ready, blocked, next
- *ground*: statement, dependencies, source witnesses
- *attempt*: human or agent produces Lean work
- *verify*: compiler, links, structure checks
- *review*: explain the result against the node

Checking and human review remain separate responsibilities.

:::

:::vstack

```diagram (background := "#ffffff")
open Illuminate Lean in
let ah : Arrowhead := { type := .stealth }
let txt (s : String) (size : Float := 8) : Diagram SVG :=
  Diagram.text s { fontSize := size, fontFamily := "sans-serif" }
let box (name : Name) (label : String) (fill : Color) : Diagram SVG :=
  txt label
    |>.padXY 8 5
    |>.filledFrame
      (fill := fill)
      (stroke := { color := rgb!"#64748b", width := 1 })
      (cornerRadius := 4)
    |>.namedWithAnchors name
let source := box `source "mathematical\nsource" (rgb!"#f8fafc")
let node := box `node "blueprint node" (rgb!"#dcfce7")
let review := box `review "human\nreview" (rgb!"#fff7ed")
let queue := box `queue "human / agent\nwork queue" (rgb!"#fef9c3")
let lean := box `lean "Lean\ndeclaration" (rgb!"#dbeafe")
let compiler := box `compiler "compiler\nfeedback" (rgb!"#e0f2fe")
Diagram.grid (hSpacing := 30) (vSpacing := 15) #[
  #[none, some source, none],
  #[none, some node, some review],
  #[none, some queue, some lean],
  #[none, some compiler, none]
]
  |>.connect `source.south `node.north (arrowhead := ah)
  |>.connect `review.west `node.east (arrowhead := ah)
  |>.connect `node.south `queue.north (arrowhead := ah)
  |>.connect `queue.east `lean.west (arrowhead := ah)
  |>.connect `lean.south `compiler.east (arrowhead := ah)
  |>.connect `compiler.north `queue.south (arrowhead := ah)
  |>.connect `lean.north `review.south (arrowhead := ah)
  |>.scale 1.25
```

:::

::::

## Migration Review Harness

The leanblueprint-to-verso project ports LaTeX blueprints with AI assistance.

The migration experience motivates a review loop:

:::::hstack

::::vstack

- it looked plausible
- it was not faithful
- labels drifted
- structure was invented
- source correspondence was weak

Natural-language instructions alone were not enough.

The fix was a deterministic harness plus a review surface.

Review demo: [https://x80.org/flt-translation-review/](https://x80.org/flt-translation-review/)

::::

::::vstack

The harness makes translation failures visible.

:::class "review-loop-diagram"
```diagram (background := "#ffffff")
open Illuminate Lean in
let ah : Arrowhead := { type := .stealth }
let txt (s : String) (size : Float := 8) : Diagram SVG :=
  Diagram.text s { fontSize := size, fontFamily := "sans-serif" }
let box (name : Name) (label : String) (fill : Color) : Diagram SVG :=
  txt label
    |>.padXY 8 5
    |>.filledFrame
      (fill := fill)
      (stroke := { color := rgb!"#64748b", width := 1 })
      (cornerRadius := 4)
    |>.namedWithAnchors name
let source := box `source "source\nTeX" (rgb!"#f8fafc")
let agent := box `agent "agent\ntranslation" (rgb!"#dbeafe")
let vbp := box `vbp "VBP\nnodes" (rgb!"#dcfce7")
let structureCheck := box `structureCheck "structure\nchecks" (rgb!"#fff7ed")
let similarity := box `similarity "similarity\nchecks" (rgb!"#fff7ed")
let grounding := box `grounding "grounding\nchecks" (rgb!"#fff7ed")
let rendered := box `rendered "rendered\nreview" (rgb!"#fef9c3")
let lean := box `lean "Lean/link\nchecks" (rgb!"#fef9c3")
let audit := box `audit "human\naudit" (rgb!"#fef9c3")
Diagram.grid (hSpacing := 34) (vSpacing := 14) #[
  #[some source, none],
  #[some agent, some vbp],
  #[some structureCheck, some rendered],
  #[some similarity, some lean],
  #[some grounding, some audit]
]
  |>.connect `source.south `agent.north (arrowhead := ah)
  |>.connect `agent.east `vbp.west (arrowhead := ah)
  |>.connect `agent.south `structureCheck.north (arrowhead := ah)
  |>.connect `structureCheck.south `similarity.north (arrowhead := ah)
  |>.connect `similarity.south `grounding.north (arrowhead := ah)
  |>.connect
    { point := `grounding.west, angle := some pi, pull := 0.35 }
    { point := `agent.west, angle := some (0 : Float), pull := 0.35, arrowhead := some ah }
    (stroke := { color := rgb!"#2563eb", width := 1.2 })
    (label := some { label := txt "feedback" 6, pos := 0.52, shift := ⟨-6, 0⟩, upright := true })
  |>.connect `vbp.south `rendered.north (arrowhead := ah)
  |>.connect `rendered.south `lean.north (arrowhead := ah)
  |>.connect `lean.south `audit.north (arrowhead := ah)
  |>.scale 1.35
```
:::

::::

:::::

:::notes
Thanks to David Christiansen and Kim Morrison for suggesting this direction.
:::


## Full FLT Graph

{blueprintGraph (view := "full") (class := "flt-graph-frame")}
