# Verso Blueprint talk — revised outline

Updated 21 September 2026 with the speaker's audience and roadmap priorities. This is the longer editorial brief; `STRUCTURE.md` describes the implemented deck and demo runbook.

The title is “Verso Blueprint: Reimagining Blueprints for the AI Era.” The confirmed event is ForMath Seminar, IRIF, Université Paris Cité, Monday, 21 September 2026. The 40-minute allocation below remains a working assumption inherited from the old deck; duration remains to be confirmed. The audience is expert in formal proof and Rocq, but unfamiliar with Verso: explain the document language and data model, not Lean basics.

## The requested structure

**Actual context → historical blueprint content → what is Verso → Verso Blueprint → what's next.**

Two themes run through the whole talk, rather than forming a separate section at the expense of the Verso explanation:

- **AI support:** authoring, migration, contextualized tasks, checking, and human review.
- **Better integration as a reading, inference, and database component:** explain how the same mathematical objects could serve readers and tools without maintaining unrelated copies of their meaning or state.

The second theme is an architectural direction, not a claim that a complete inference engine or database service already ships with VBP. Explain demonstrated capabilities separately from proposed integrations.

## Main route and provisional timing

| Section | Minutes | Purpose |
| --- | ---: | --- |
| 1. Actual context | 7 | Use recent mathematics to make the issues concrete |
| 2. Historical blueprint content | 4 | Preserve the established motivation and lineage |
| 3. What is Verso? | 8 | Explain syntax, elaboration, linking, and extensibility |
| 4. Verso Blueprint | 15 | Cover guidelines, features, examples, and limitations |
| 5. What's next? | 6 | Programmatic blueprints, then the September–December roadmap |

Preserve the existing horizontal/vertical navigation convention. The section's first substantive slide should carry its opening message; avoid empty section dividers. Put optional depth in vertical children or backup slides. [R8]

## 1. Actual context — timing to rehearse

The implemented opening has six substantive slides. It starts with the Madrid slide on AI and mathematics, then moves through the sphere packing formalization and its Blueprint. The first FLT slide shows the reported scale with Anthropic's progress animation. The second shows the smaller Prove2Me plan graph between two visible excerpts, followed by a concise list of its functions. A dated sequence from the Leiden Declaration through Anthropic's FLT announcement to the Math and AI declaration closes the section, with SAIR's open models initiative presented as an undated response. Navier–Stokes and the supplied illustration are in backup.

The slide notes link dated primary announcements, released artifacts, Buzzard's FLT checking report, and Clay's official scope and evaluation statement. The September 21 review inspected those sources, not independent builds or checker runs. Artifact revision pinning and a pre-talk status recheck remain useful follow-ups. [M1–M5]

Keep the existing pinned FLT Blueprint demonstration separate from the newer FLT artifact discussed in the context section. If using the backup Navier–Stokes slide, specify hypotheses and problem variant rather than treating the name of the problem as a sufficient statement.

The closing opening slide connects checked results to understanding, attribution, research direction, and reusable work. Keep checking and correspondence qualifications in speaker notes rather than teaching this expert audience proof-assistant basics.

**Transition:** More output makes shared context and reviewable structure more important. The need for coordination is not new.

## 2. Historical blueprint content — 4 minutes

Preserve the speaker's established historical material, rather than reopening the history. Reuse the existing Feit–Thompson/Flyspeck coordination and LeanBlueprint/Liquid Tensor material, retaining attribution and making only supported corrections or timing cuts. [R5, R8]

The two main takeaways are that blueprints helped people communicate mathematical plans, and that dependencies and progress were already part of collaborative formalization. Explain evolving requirements without suggesting that earlier tools failed or that a TeX-based workflow cannot remain useful.

**Transition:** The coordination problem is established. Before introducing a new blueprint implementation, explain the document system on which it is built.

## 3. What is Verso? — 8 minutes

This is a distinct section, not a brief aside inside the VBP data model. Use one small source fragment throughout so the audience can connect authoring, processing, and reading.

### 3.1 Syntax: what an author writes

Show minimal source and rendered output together: a heading, prose, mathematical notation, an inline role, a directive, and a code example. Introduce unfamiliar syntax incrementally. Keep the source copyable and its extension openers valid; do not turn the slide into a markup reference manual. [R1, R5, U1, U2]

### 3.2 Elaboration: more than coloring text

Demonstrate one example that is actually checked during the build, plus a deliberately invalid example whose expected error is enforced. Show what succeeds or fails and where the diagnostic belongs.

Distinguish parsing markup, elaborating an extension or Lean example, and rendering the document. Do not imply that arbitrary mathematical prose is verified merely because its document elaborates. Use the rendering fixture as the evidence for the live demonstration. [U1]

### 3.3 Linking: connecting what the reader sees

Show one working document reference and one Lean-connected example, using syntax supported by the pinned checkout. Explain what identifies the target and what information the reader can access. A resolved reference and a faithful informal/formal correspondence are different claims.

Where hover, type, or proof-state interaction helps, include it only after testing the actual deck. Avoid requiring an untested interaction to make the basic explanation intelligible.

### 3.4 Extensibility: how a document becomes a specialized interface

Use one extension as the bridge to VBP. Explain what syntax it adds, what data or validation it contributes, and how its result is rendered. Prefer a small concrete extension over a comprehensive API tour. Verify implementation details against the pinned code before showing them.

Introduce the two themes here: structured documents can give AI tools better-defined inputs, and linking/extensibility can support richer reading and downstream data access. Label unimplemented integrations as design goals.

**Transition:** Verso is the extensible document substrate. VBP supplies the blueprint-specific objects, conventions, and views.

## 4. Verso Blueprint — 15 minutes

Cover all four requested dimensions: **general guidelines, features, examples, limitations**. Use one real node to connect them rather than four disconnected feature lists.

### 4.1 General guidelines: how to author a useful blueprint

State the mathematical intent clearly; use stable labels; retain statement/proof distinctions and explicit dependencies; attach real Lean evidence; preserve source provenance. Separate an informal explanation, a linked declaration, and the checking evidence for a formal result.

Present these as recommended authoring practices, not promises that every practice is automatically enforced. Emphasize that a useful blueprint should help both a person reading the mathematics and a tool consuming its structure.

### 4.2 Features: what the current checkout demonstrates

Show the actual node, rendered content, available Lean attachments, dependency view, and graph. The existing embedded `FreyCurve` example is a suitable anchor; preserve manifest-backed embedding and the public preview/graph route. [R1, R5, R6]

The implemented sequence is **why VBP → Frey node → anatomy of a rich small node → model diagram → authoring → dependency tracks → graph → before/after formal progress and summary → sources → consumers → review/boundaries**. Keep the dense field listing and full FLT graph in backup. The comparison credits LeanBlueprint's existing coordination features and argues for Lean-native authoring, connected evidence, and programmable reuse.

Every status or feature shown needs one of three descriptions: demonstrated in this checkout, an unvalidated prototype, or a proposal. Do not infer implementation from a persuasive diagram.

### 4.3 Examples: AI support and integrated use

Keep two concrete demonstrations within this section:

**Authoring and review.** Reuse a small source-to-VBP migration example from the existing material. Show one plausible but unfaithful transformation, the check or review view that exposes it, and the corrected change. Use actual recorded evidence or a clearly labeled synthetic fixture; do not invent experimental success rates. [R5, R8]

**One object, several consumers.** Reuse the same label to discuss a reader's view, an agent's task context, and a proposed structured query or export. Demonstrate a supported query/export only after inspecting its actual interface. Otherwise show a labeled design sketch, not fabricated output.

For the inference discussion, distinguish explicit source facts, relationships or project state derived by tools, and suggestions made by an AI system. Do not silently promote a suggestion into a verified dependency or completion status. Clarify the intended inference use case during authoring rather than assuming it means only an LLM or only a theorem prover.

For the database discussion, focus on identity, relationships, provenance, query needs, and update/version semantics. The talk need not commit to a storage backend, a new service, or a public query language.

### 4.4 Limitations: what the interfaces do not settle

Separate mathematical judgment and source fidelity from successful compilation and resolved links. Discuss actual integration friction found in the fixture, unsupported authoring cases, and API or schema boundaries after checking them. Avoid inventing limitations solely to make the roadmap compelling.

A small collaboration sketch may close the section: retrieve context, attempt a bounded change, check it, inspect the difference, review, and integrate. State which steps are implemented and which remain a workflow proposal.

**Transition:** The opportunity is not only a better web page. It is a blueprint that can participate in reading, inference, and data workflows while keeping evidence visible.

## 5. What's next? — 6 minutes

### 5.1 Towards programmatic blueprints

Adapt the Madrid closing slide: a blueprint remains readable by mathematicians
while exposing stable labels, relations, and project state to programs. This
is the transition from the demonstrated reader and query surfaces to the
proposed integrations.

### 5.2 Roadmap

Use the speaker's priorities in this order:

1. Formal Database Model
2. Improved skill
3. Improved Verso Performance
4. Widget
5. Side-by-Side analysis
6. Direct agentic loop support

The Illuminate timeline spans September–December 2026 and spaces the six items
evenly; the positions do not assign individual delivery dates. The first item
means formalizing VBP's custom database, as clarified by the speaker.
Distinguish today's source metadata, queries, and public embedding APIs from
the planned integrated experience.

The section now ends on the roadmap, without a separate thanks slide. Do not
promise that VBP replaces mathematical understanding, formal proof checking,
or human review.

## Demo and infrastructure requirements

The baseline and local demo sites are now built. Follow `STRUCTURE.md` and the worktree's `DEMO-RUNBOOK.md`, not a nonexistent `HANDOFF.md`. The examples cover embedded VBP content, complete Verso source, checked Lean and an enforced error, inline/display math, linking, and a small graph. Full offline and deployment-prefix acceptance remain outstanding.

Use a locally served generated deck for the main demonstration. Keep a clearly labeled fallback capture for each interaction that might fail. Test without external network access and under a deployment-like URL prefix. Speaker notes should record the intended takeaway, transition, and fallback—not an unbounded live exploration.

## Keep / revise / move

| Existing material | Treatment |
| --- | --- |
| Current-context examples | Refresh selectively, preserve exact claim scope, keep a replaceable milestone slot |
| Historical material | Preserve; shorten only as needed |
| Short Verso primer | Expand into the dedicated syntax/elaboration/linking/extensibility section |
| VBP node and graph | Keep as the continuous central example |
| Migration harness and source compare | Put inside VBP examples; use to demonstrate the AI-support thread |
| Dense data-model listing | Explain after the example or move to backup |
| Generic agent-only section | Replace with the two cross-cutting themes |
| General roadmap | Use the six speaker-supplied priorities in order, evenly spaced between September and December 2026 |
| Venue/date/duration | Leave unset until supplied; audience is expert Rocq/formal-proof researchers |

Historical source IDs are inherited from the earlier brief; `SOURCES.md` is not present here. Verify claims against primary sources before finalizing the current-context section. Current build and demo evidence is recorded in `STRUCTURE.md` and the worktree runbook.
