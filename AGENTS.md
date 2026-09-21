# ForMath deck workflow

Work in this repository's current checkout. Read `STRUCTURE.md` and
`DEMO-RUNBOOK.md` for the active slide order and demonstration routes. Preserve
edits already in the worktree, including changes made by the speaker.

After each coherent, verified group of slide or tooling changes, inspect the
diff and request a local commit. If the speaker has already authorized commits
for that work, commit it promptly on `main` instead of carrying completed work
across turns. Stage only the intended source, documentation, and presentation
assets. The ignored `drop/` directory is an upload inbox; copy selected assets
into `static/` before committing them.

Build the deck and run the relevant browser check before committing. Do not
push, publish, or deploy without an explicit request.
