# First-session prompt for Codex

Current repository workflow is in `AGENTS.md`. Request or make a local commit
after each verified group of changes so completed slide work does not accumulate
uncommitted. The instructions below record the original bootstrap context.

Update, 21 September: the baseline exists and the speaker has prioritized
fixing the structure, then adding slide details. Read `STRUCTURE.md` first.
The active deck is `Slides.lean` in the ForMath repository root; its five-part
main route is now implemented. Continue here without repeating bootstrap.
The Verso/VBP feature pass and local demos are also implemented; consult
`DEMO-RUNBOOK.md`. The audience is expert in Rocq
and formal proof, unfamiliar with Verso. The speaker's six ordered roadmap
items in STRUCTURE.md supersede the historical proposal below. The current
timeline spans September–December without per-item delivery dates.
Confirmed event: ForMath Seminar, IRIF, Université Paris Cité, Monday,
21 September 2026. Retain the title and speaker affiliation. Duration remains
unconfirmed. The instructions below are historical bootstrap context, not a
request to create another worktree, delegate work, or use external checkouts.

Continue preparing this Verso Blueprint talk from the existing repository. Read `README.md`, the repository's `agents.md` / `AGENTS.md`, `Slides.lean`, `Main.lean`, `outline.md`, and this handoff bundle before changing files. Preserve existing repository instructions.

The speaker is bootstrapping the new deck from the old one. Inspect the actual working tree and preserve any bootstrap changes; do not overwrite or repeat completed setup. The inspected baseline was `6017b06e4308a159e3b67683b8d5d060e100c432`. Record the actual checkout SHA, toolchain, and recursive submodule SHAs. Work in a new local worktree, initialize its submodules, and keep the user's main checkout as staging. Do not update dependency pins, use external sibling checkouts, push, upload, or deploy.

First establish baseline build and browser evidence with `scripts/build-pages.sh` and the served `_slides`. If the user has already made changes, record them and use a separate clean worktree for an unmodified comparison rather than resetting their work. The handoff did not run these checks. If a build fails, investigate the specific failure without upgrading dependencies or hiding it.

Next implement the smallest rendering fixture covering real VBP embedding, literal Verso source, a genuinely checked Lean example, inline/display math, a macro shared with Blueprint content, and a graph interaction. Reuse the pinned upstream fixtures and the existing public preview/graph API. Distinguish checked examples from static excerpts. Test source fidelity, clipping, console/network errors, deployment-prefix URLs, and offline presentation assets. Do not replace working embedded nodes with hand-maintained copies.

Use Terra with medium reasoning for ordinary integration. Delegate bounded repository inventory to `repo_scout` and a difficult rendering task to `vbp_renderer` only as needed. `claim_reviewer` may audit the source ledger read-only in parallel. Use at most two concurrent subagents and only one writer for an overlapping file set. Return a minimal reproduction before escalating a failed attempt. Reserve Astra for problems not resolved by a focused Sol investigation.

Then use the revised `OUTLINE.md`, which incorporates the speaker's completed instructions. Preserve the five-part order: actual context; historical blueprint content; what is Verso (syntax, elaboration, linking, extensibility); Verso Blueprint (general guidelines, features, examples, limitations); what's next.

Give Verso a distinct explanation before the VBP example. Thread AI support and better integration as a reading/inference/database component throughout; do not replace the Verso section with a standalone agent section. Keep explicit facts, derived relationships, and AI suggestions distinguishable. Do not invent a shipped database, inference engine, or query API.

For the close, plan one timeline from 20 September through 31 December 2026 with AI-support and reading/inference/data tracks. The monthly themes are proposed directions, not delivery commitments; the timeline graphic has not been created in this handoff. The 40-minute duration remains provisional.

Preserve distinctions between formalization, mathematical discovery, exact problem variants, and independent checking. Keep the existing FLT demo separate from a newer FLT artifact. Recheck milestone sources before asserting current claims; mark roadmap features as proposals unless demonstrated.

For this first session, prioritize baseline reproduction and one accepted rendering slice rather than rewriting the whole talk. Finish with the files changed, commands actually run, checks passed/failed, source or model assumptions, and the next bounded task. Do not invent the next talk's venue, date, or audience.
