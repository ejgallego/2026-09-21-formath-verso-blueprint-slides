# ForMath rehearsal review

21 September 2026. Main route: 31 slides including title. Backup: 9 slides.
Event: ForMath Seminar, IRIF, Université Paris Cité.
Preview: http://127.0.0.1:8877/.

## Readiness and priorities

The main narrative now gives this expert Rocq audience a concrete reason to
care, explains Verso before introducing VBP, and connects the abstract model
to the same node, graph, and proof-progress demonstration. The comparison with
LeanBlueprint credits its existing capabilities and motivates Lean integration.

The opening now begins with the Madrid AI slide, then sphere packing and its
Blueprint, FLT, Navier–Stokes, and a reflection on mathematical understanding.
The opening now uses Anthropic's FLT progress animation and plan graph, short
staged excerpts from its Prove2Me account, and the supplied Navier–Stokes image.

1. **Rehearse the switches, not live proof typing.** Pre-open the Manual page,
   node panel, and two summaries. Stop after one reference/hover, one graph
   preview, and the corollary's readiness change. The corollary remains unproved.
2. **Check readability on the actual projector.** The overview, diagnostics,
   authoring, and CLI examples now use at least 20px text at 1280×720, without
   horizontal clipping. The complete source remains on one slide. A browser
   screenshot cannot establish back-row readability in the room.
3. **Keep the whole generated directory together.** The rehearsed local demo
   route now works with external requests blocked, including the graph. Serve
   `_slides/` over HTTP. External reference links still need internet access.
   No publication remote exists, so new declaration previews display local
   source paths rather than public source links.

## Suggested pacing

This is a target, not a measured speaking rehearsal or a confirmed duration.
If the slot is 40 minutes, aim for 33 minutes of talk and 7 for discussion:

| Segment | Minutes | Exit point |
| --- | ---: | --- |
| Title and opening | 5 | Blueprints before and after formalization |
| Historical context | 3 | Established coordination model |
| Verso, including its demo | 7 | Roles/directives can register specialized objects |
| VBP, including node and progress demos | 15 | One object supports readers and tools |
| Roadmap and closing | 3 | The speaker's five ordered priorities |

Keep FLT/Navier–Stokes to the opening's coordination and reading motivation.
Do not let the announcements turn into an AI debate before the audience sees
Verso. The seven-minute demo allocation in DEMO-RUNBOOK.md is included above.
First cuts if behind: terminal queries, ownership/tag details, external
migration-review navigation, and all backup material.

## Evidence and limits

- The integrated deck and three demo documents build at the repository root.
  Dependency caches and the pinned FLT site were reused; this was not a fresh
  build of all dependencies or an independent audit of the milestone proofs.
- `vbp check` passes for Before/After (11 entries each) and the copied FLT
  artifact (597 entries). No labels, dependency edges, or dependency pins changed.
- Headless Chrome at 1280×720 exercises the Manual reference and declaration
  hover, source provenance and local note, native and embedded graph previews,
  proof snapshots, and downstream readiness badges.
- The main-route visual audit reports no page exceptions, HTTP error responses,
  or tested element-boundary overflows online. Visual inspection found and fixed
  the title-name contrast and the LeanBlueprint screenshot layout.
- The original offline graph failure is resolved by a checked-in bundle of
  D3, D3-Graphviz (including its WebAssembly runtime), Marked, and Source Sans 3.
  Packaging verifies SHA-256 digests, respects Verso's HTML base URLs, and
  rewrites generated loaders without changing dependency sources.
- Offline interaction acceptance also passes under a `/formath/` deployment
  prefix: zero external asset requests, page exceptions, or HTTP error responses.
  This does not test every popup, graph control, or external link.
- The exact title is now “Verso Blueprint: Reimagining Blueprints for the AI Era”.
  The separate “Thanks, Questions?” slide is retained.

Repeat the checks from the repository root. The first browser command manages
its own temporary server and tests the deployment prefix; the second uses the
existing preview:

```bash
python3 -m unittest discover -s scripts -p 'test_*.py'
uv run --with playwright python scripts/rehearse-offline.py --output /tmp/formath-review
uv run --with playwright python scripts/check-demo-browser.py --offline
```

The Pages workflow runs packaging tests and the prefixed offline rehearsal
before uploading an artifact. It has not been run remotely for this repository.
These checks exercise the interface, not the speaker's pacing.
