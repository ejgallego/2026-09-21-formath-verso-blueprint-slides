# ForMath rehearsal review

21 September 2026. Main route: 27 slides including title. Backup: 11 slides.
Event: ForMath Seminar, IRIF, Université Paris Cité.
Preview: http://127.0.0.1:8877/.

## Readiness and priorities

The main narrative now gives this expert Rocq audience a concrete reason to
care, explains Verso before introducing VBP, and connects the abstract model
to the same node, graph, and proof-progress demonstration. The comparison with
LeanBlueprint credits its existing capabilities and motivates Lean integration.

1. **Offline graph support remains a real presentation risk.** Blocking external
   HTTP requests makes the embedded graph display “Unable to load Blueprint
   graph.” The runtime fetches D3 7.9.0 and D3-Graphviz 5.6.0 from jsDelivr.
   Google Fonts is also external, though the deck has font fallbacks. For now,
   verify connectivity and use the model slide and before/after table as the
   fallback. Do not promise a fully offline demo. A reproducible local asset
   bundle is the next infrastructure task.
2. **Rehearse the switches, not live proof typing.** Pre-open the Manual page,
   node panel, and two summaries. Stop after one reference/hover, one graph
   preview, and the corollary's readiness change. The corollary remains unproved.
3. **Check the smaller code blocks on the actual projector.** The complete
   source slide is the main reading surface. The shorter overview, diagnostic,
   and code-first snippets occupy less screen space and may need enlargement
   for a large room. Prefer the local editor if someone wants implementation
   details. No publication remote exists, so new declaration previews display
   local source paths rather than public source links.

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
  hover, graph preview, proof snapshots, and downstream readiness badges.
- The main-route visual audit reports no page exceptions, HTTP error responses,
  or tested element-boundary overflows online. Visual inspection found and fixed
  the title-name contrast and the LeanBlueprint screenshot layout.
- The external-network-blocked pass exposes the graph failure above. That pass
  is a diagnostic failure, not offline acceptance. It does not test every popup
  or external link. Deployment-prefix behavior and the backup deck are not
  included in main-route acceptance.

Repeat the checks from the repository root while the preview server runs:

```bash
uv run --with playwright python scripts/check-demo-browser.py
uv run --with playwright python scripts/review-deck-browser.py --output /tmp/formath-review
uv run --with playwright python scripts/review-deck-browser.py --offline --output /tmp/formath-offline
```

The last command should remain nonzero until the offline graph dependency is
resolved. These checks exercise the interface, not the speaker's pacing.
