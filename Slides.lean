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
- This challenges mathematicians and computer scientists.

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

The formalization followed a mathematical plan: statements, dependencies, and
progress were visible to collaborators.

::::class "sphere-images"
:::hstack

{image (width := "95%") "static/images/sp_index.png"}[Sphere-packing blueprint start page]

{image (width := "95%") "static/images/sp_graph.png"}[Sphere-packing blueprint graph]

:::
::::

*The Blueprint told people and agents where each proof belonged.*

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

Anthropic reports a complete Lean formalization of FLT, following the
Darmon–Diamond–Taylor exposition. Lean checked the proof.

```html
<video class="flt-progress-video" src="flt-progress.mp4" poster="flt-progress-poster.png" muted loop playsinline controls preload="metadata" aria-label="Time progression of Anthropic's FLT formalization"></video>
```

*How does a mathematician read a proof of this size?*

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

:::class "flt-plan-image"
{image (width := "100%") "static/images/flt-plan.png"}[Anthropic's Prove2Me plan showing the Mazur, Ribet, and Wiles branches leading to FLT]
:::

::::class "flt-quote"
:::fragment currentVisible (index := 1)
Anthropic: “they quickly lost track of the project’s state and stopped collaborating effectively.”
:::
::::

::::class "flt-quote"
:::fragment currentVisible (index := 2)
Anthropic: “The effort succeeded when we switched to using Prove2Me”
The plan kept a theorem DAG, separate statement and proof files, and natural-language descriptions.
:::
::::

:::notes
Reveal the failure first. Anthropic reports that unsuccessful attempts left
about 7% of the final non-boilerplate lines. Then reveal the change to
Prove2Me and its three functions: a theorem dependency graph for task choice,
separation of statements and proofs to improve compilation, and natural-language
descriptions for search and reuse. The slide quotes only short excerpts from
the supplied passage; the final line paraphrases its list. This is the team's
account of its workflow, not a controlled comparison or a claim that Verso
Blueprint powered the result.

[Anthropic announcement](https://www.anthropic.com/research/formalizing-fermats-last-theorem)
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

## What Kind Of Mathematics Do We Want?

Checked proofs give strong evidence of correctness. Mathematicians also need
to understand the ideas, credit the work, and decide which questions matter.

[A Severe Misalignment of AI in Mathematics](https://mathandai.org/) asks who
sets the agenda. The [Leiden Declaration](https://leidendeclaration.ai/) calls
for clear attribution and independent verification. [SAIR's open mathematics
initiative](https://sair.foundation/open-math-model/) emphasizes work that
others can examine and build on.

*Blueprints can connect a checked result to the mathematics around it.*

:::notes
The user called the third reference “SIAR”; the organization is SAIR. These
statements differ in emphasis. The slide extracts the concerns most relevant
to this talk and does not imply endorsement of every position in them.

A Blueprint records links and evidence. It does not itself certify that prose
faithfully represents a formal statement or proof. Nor did the FLT or NS
milestones use Verso Blueprint.

Transition: coordination and mathematical reading already mattered in large
formalization projects before the current wave of AI tools.
:::

# Blueprint: Historical Context

%%%
vertical := some true
%%%

:::::vstack

- *Feit-Thompson Theorem (~2010)*: Custom system to track progress, generated by CI
- *Flyspeck (~2010)*: _Mathwiki_

*Coordination was part of the mathematics*

*Formalization progress was non-linear*

:::hal "hal-00816699" (title := "A Machine-Checked Proof of the Odd Order Theorem") (authors := "Gonthier, Asperti, Avigad, Bertot, Cohen, Garillot, Le Roux, Mahboubi, O'Connor, Ould Biha, Pasca, Rideau, Solovyev, Tassi, Thery") (published := "Submitted to HAL Apr 22, 2013") (venue := "ITP 2013, LNCS 7998, pp. 163-179") (url := "https://hal.inria.fr/hal-00816699") (pdf := "https://www.msr-inria.fr/files/hal-00816699/file/main.pdf")
The paper reports the machine-checked formal proof of the Feit-Thompson Odd
Order Theorem in Coq/Rocq, built on the Mathematical Components library.
:::

:::::

## LeanBlueprint

:::::hstack

- Created by Patrick Massot for sphere eversion (2020), then used for
  the Liquid Tensor Experiment
- A LaTeX/plasTeX extension for formalization projects.
- Adds *dependency information*, *graph rendering*, and *formalization status*.
- Widely reused across Lean projects.

::::class "history-images"
:::vstack

{image "static/images/lte1.png"}[Liquid Tensor blueprint screenshot]

{image "static/images/lte2.png"}[Liquid Tensor blueprint screenshot]

:::
::::

:::::

## Blueprints As Coordination Infrastructure

:::::vstack
::::hstack
:::vstack

*Blueprints are coordination infrastructure*:

- mathematicians read the project map
- formalizers choose tasks from it
- maintainers track progress and blockers
- collaborators discuss the same labeled objects
:::

:::vstack
*LeanBlueprint is very successful, but the requirements are changing*:

- connect exposition to the evolving formal development
- expose project state to readers and tools
- give agents explicit tasks and checking evidence
:::
::::

{arxiv "2601.22554" (title := "LeanArchitect: Automating Blueprint Generation for Humans and AI") (authors := "Thomas Zhu, Pietro Monticone, Jeremy Avigad, Sean Welleck") (published := "Submitted Jan 30, 2026")}

:::::

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

# Verso Blueprint

%%%
vertical := some true
%%%

*Why VBP when LeanBlueprint already exists?*

LeanBlueprint already provides a mathematical plan, dependency graphs,
progress, and links to Lean. We retain that coordination model.

- *Lean-native authoring*: prose, checked examples, and extensions in one environment.
- *Connected evidence*: derive progress and optional dependencies from declarations.
- *Programmable reuse*: the same objects serve readers, project views, and tools.

The choice is tighter Lean integration—not a claim that TeX is obsolete.

:::notes
The reason to choose VBP is close integration with Lean and programmable reuse.
A working TeX/LeanBlueprint project already serves a valuable purpose.
VBP adds another implementation choice; this talk demonstrates what that enables.
Do not claim TeX cannot carry structure or that every project should migrate.
LeanBlueprint also checks declaration names with checkdecls; name validation is
not a unique VBP feature. See https://github.com/PatrickMassot/leanblueprint and
https://github.com/hanwenzhu/LeanArchitect for the existing ecosystem.
The Verso example has shown Lean-native authoring. Next, a node connects
mathematical content to formal evidence. Then changing that evidence changes
project state, which the reader and tools can both inspect.
:::

## Reading A Node: The Frey Curve

{blueprint_node "FreyCurve" (siteBase := "blueprint")}

:::notes
Start with the mathematics and the actual formal attachment. Frey is the real
project example; switch to the small authored example for controlled changes.
Explain the change of Weierstrass model when opening the declaration.
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

## From Dependencies To A Project View

{blueprintGraph (base := "demo/after/") (view := "full") (direction := "TB") (pack := "true") (class := "flt-graph-frame demo-graph-frame")}

[Open the progress summary](demo/after/Blueprint-Summary/)

:::notes
Locate `left_inverse_injective`, its prerequisites, and the downstream
`fibre_singleton` corollary. Open one node preview to recover the mathematics.
The same labels identify the mathematical objects in the document and graph.
The graph shows the completed theorem. What changes if its proof is unfinished?
Leave the full FLT graph, layout controls, and legend tour for questions.
:::

## Progress Is Connected To The Formal Development

{demoFrame "demo/before/panel.html" "Before and after completing the Lean proof"}

:::class "anatomy-key"
Before / After: completing this theorem makes the downstream corollary's
proof ready to formalize. The corollary still needs its own formalization.
:::

:::notes
Start with the unfinished state. Its statement is formalized, but its Lean
proof contains sorry. Switch to After: the associated proof is complete.
In Summary, expand Metadata then Quick wins to find `fibre_singleton`.
Its proof badge changes from not ready to
ready to formalize; it has not magically acquired a proof.
Both variants retain the Blueprint label and informal account. Their attached
declarations are in separate Draft and Complete namespaces.
This is the payoff of connected formal evidence: a local completion changes
the next available work. The subsequent CLI example accesses the same state.
The source-edit/rebuild path is optional; use the prepared variants in the talk.
:::

## Authoring: Prose, Code, Or Both

```code verso
:::theorem "left_inverse_injective"
A function admitting a left inverse is injective.
:::
```

Attach a labeled Lean block, name existing declarations with `lean :=`,
or introduce an object from a declaration carrying `@[blueprint]`.

```code lean
@[blueprint "equality_transport"]
theorem transportEq (g : Nat → Nat) {a b : Nat} (h : a = b) :
    g a = g b := congrArg g h
```

:::notes
The lower example is from ForMathDemo/Common.lean. The Blueprint label gives
the mathematical object a stable identity; the Lean declaration has its own
name. Demonstrate code-first use by opening Prerequisites in the generated
site. Metadata and prose-first authoring remain available when code alone
cannot express the intended account.
:::

## Mathematical And Formal Dependencies

- `uses` records an authored mathematical dependency.
- `bpref` adds a prose reference without an edge.
- `autoDeps` can derive edges from elaborated Lean declarations.

Types and proof bodies contribute to different dependency tracks.
Inferred edges retain their automatic origin.

:::notes
In this demo, left_inverse and injective are inferred from the theorem's type.
equality_transport is an explicit proof dependency. Inference can follow
unassociated helpers to associated declarations, but does not reconstruct
the author's intended mathematical explanation.
These are the arrows in the model diagram and graph.
:::

## Sources And Mathematical Correspondence

*Original source*: a document and a precise source span.

*Informal node*: the statement and proof as the Blueprint presents them.

*Formal attachments*: the declarations used as evidence.

[Inspect the demonstration source note](demo/after/demo-notes.md)

:::notes
The backup anatomy node exposes the source chip. Retained TeX is also available,
but is a separate informal representation. A resolved attachment and successful
compilation do not certify equivalence to the original mathematics.
The Frey curve's coordinate change gives a substantial example of this issue.
:::

## One Object, Several Consumers

```code bash
lake exe vbp query --site _demo/after node left_inverse_injective
lake exe vbp query --site _demo/after uses left_inverse_injective
lake exe vbp query --site _demo/after work-queue
```

The reader, graph, summary, slide, and query refer to the same labels.

The backup anatomy panel is a small client of VBP's public preview API.

:::notes
Run bash scripts/demo-query.sh after to obtain real query output. Show the
label, statementUses and proofUses, then the work queue. The CLI's JSON is
currently unstable. The source of the small browser client is
static/demo-panel.js; it requests the node by label.
Use this as a short coda, not a fourth live demo. If time is tight, point to
the commands: the graph and progress demonstration have already shown the data.
:::

## Authoring And Review With AI

- Give the task explicit mathematical scope and source context.
- Check declarations, references, and structural consistency.
- Compare the resulting exposition with its sources.
- Review the mathematical correspondence before integration.

[Migration review example](https://x80.org/flt-translation-review/)

:::notes
The migration harness is a separate client/workflow, not an automatic guarantee
provided by VBP. Keep the existing harness diagram in backup. Direct agentic
loop support belongs to the roadmap.
:::

## Current Boundaries

- Informal/formal correspondence remains a mathematical review task.
- Derived state describes a generated snapshot of the development.
- Custom clients pin the current APIs and data formats.
- Rich source comparison and direct agent loops have further roadmap work.

:::notes
Transition to the expected roadmap sequence. Today's source metadata and
node reuse provide useful building blocks for those later integrations.
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

## Anatomy Of A Node

{demoFrame "demo/after/panel.html" "Anatomy of a Blueprint theorem"}

:::class "anatomy-key"
The label `left_inverse_injective` connects the mathematical account
to formal evidence and dependencies.
:::

:::notes
Read the statement and its separate informal proof. Open the Lean chip:
it associates a declaration with this mathematical object. Open the source
chip: it identifies a passage of the demonstration note. The theorem's label
stays fixed across these views.
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

## leanblueprint-to-verso: Reference Blueprints

The harness was tested against four reference projects:

- [Kevin Buzzard's FLT blueprint](https://github.com/ejgallego/verso-flt)
- [Sphere Packing](https://github.com/ejgallego/verso-sphere-packing)
- [Carleson Operators on Doubling Metric Measure Spaces](https://github.com/ejgallego/verso-carleson), by Floris van Doorn
- [Noperthedron](https://github.com/ejgallego/verso-noperthedron), by David Renshaw and Jason Reed

The goal was a faithful port.

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

Thanks to David Christiansen and Kim Morrison for suggesting this direction.

::::

:::::


## Full FLT Graph

{blueprintGraph (view := "full") (class := "flt-graph-frame")}
