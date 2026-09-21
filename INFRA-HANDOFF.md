# Offline/readability handoff — 21 September 2026

The other presentation agent owns the ongoing opening/narrative pass. Do not
overwrite their edits or bootstrap another worktree.

## This pass

- Exact title: **Verso Blueprint: Reimagining Blueprints for the AI Era**.
- Short code examples enlarged from roughly 13px to 21–22px at 1280×720.
  The existing Verso layout and source format are retained.
- D3 7.9.0, D3-Graphviz 5.6.0 (including its bundled WebAssembly runtime),
  Marked 11.1.1, and Source Sans 3 are tracked with licenses and SHA-256 digests.
- `prepare-public-output.py` verifies/copies the bundle and localizes generated
  graph modules and reader-page scripts, respecting HTML base URLs. It is
  idempotent and requires no browser-asset downloads. Dependency pins and
  Blueprint labels/edges are unchanged.
- Eight packaging tests and a self-serving offline browser rehearsal are added.
  The Pages workflow runs the main-route rehearsal before uploading artifacts;
  it has not been run remotely here. System Chrome is required.

## Build and rehearse

For slide-only changes, reuse the existing demo and FLT outputs:

```bash
lake build
lake exe vbp-ucm-slides
python3 scripts/prepare-public-output.py _slides --source-root examples/verso-flt
python3 -m unittest discover -s scripts -p 'test_*.py'
uv run --with playwright python scripts/rehearse-offline.py --output /tmp/formath-review
```

The rehearsal serves its own temporary `/formath/` prefix and rejects external
HTTP requests. It does not start or stop the existing preview on port 8877.
For backup-layout acceptance, additionally pass `--include-backup`.
Do not regenerate the shared `_slides` directory during a browser scan; use
a copied artifact if another agent is building concurrently.

## Evidence and remaining work

- The pre-expansion main route (28 slides including the separate closing slide)
  passed offline visual and interaction acceptance under a deployment prefix.
- A fixed snapshot of the expanded opening (32 main slides, 8 backups) passed
  the same interaction rehearsal, with no external requests, page exceptions,
  or HTTP errors. All main-slide tested bounds passed. The optional backup scan
  still flags the acknowledgment beneath the Migration Review Harness diagram.
  The full FLT graph loads offline.
- Before/After copied artifacts pass `vbp check` with 11 entries each; the FLT
  artifact passes with 597. No cold FLT rebuild or proof audit was performed.
- The incoming opening includes two image placeholders (FLT and Navier–Stokes)
  and an Anthropic quotation placeholder. These are editorial TODOs, not broken
  runtime assets. The new opening claims were not independently re-audited by
  this infrastructure pass.
- The shared source/CSS retain the presentation agent's changes, plus proposed
  sphere-image and migration-diagram layout classes. Let that agent finish and
  validate those together. Earlier review/authoring documents need their counts
  and opening descriptions reconciled with the final narrative.
- External reference links still require internet access. Actual projector
  readability and spoken pacing remain to be rehearsed. No push or deployment
  was performed, and the repository still has no remote configured.
