# Local Verso Slides Extensions

These extensions support this deck and are examples rather than part of the
Verso Blueprint API. Import them with:

```lean
import Lib.Widgets
```

## Paper Cards

`Arxiv.lean` provides command and directive forms for arXiv references:

```lean
{arxiv "2601.22554" (title := "LeanArchitect: Automating Blueprint Generation for Humans and AI") (authors := "Thomas Zhu, Pietro Monticone, Jeremy Avigad, Sean Welleck") (published := "Submitted Jan 30, 2026")}
```

```lean
:::arxiv "2601.22554" (title := "LeanArchitect")
Blueprint generation becomes a Lean-side artifact.
:::
```

The identifier may be bare or an arXiv URL. Optional arguments are `title`,
`authors`, `published`, `venue`, `summary`, `url`, and `pdf`. `arXiv` is an
alias.

`Hal.lean` provides the corresponding `{hal ...}` and `:::hal ...` forms:

```lean
{hal "hal-00816699" (title := "A Machine-Checked Proof of the Odd Order Theorem") (authors := "Gonthier et al.")}
```

HAL record and PDF URLs default to `https://hal.science/{id}` and
`https://hal.science/{id}/document`. `HAL` is an alias.

## Layout

`Layout.lean` provides a centered block wrapper:

```lean
:::center
{image "static/images/example.png" (width := "70%")}[]
:::
```

## Cached Webshots

`WebShot.lean` and `capture-webshot.py` implement cached Chromium screenshots:

```lean
{webshot "https://arxiv.org/abs/2601.22554" "static/webshots/leanarchitect.png" (alt := "LeanArchitect arXiv page") (width := "100%")}
```

Cache paths must be PNG files below `static/webshots/`. Existing files are
reused; delete a cache file to recapture it. Optional arguments are `height`,
`class`, `viewportWidth`, `viewportHeight`, and `delayMs`. Set `CHROMIUM` or
`CHROME` when the browser is not discoverable on `PATH`.

## Blueprint Graphs

`BlueprintGraph.lean` emits the host element for a generated Blueprint graph:

```lean
{blueprintGraph (view := "full") (class := "flt-graph-frame")}
```

`blueprint-graph-slide.js` loads the public preview API, obtains the graph API
through `api.graphApiModuleUrl()`, and renders finalized graph data. Consumers
should not import generated internal chunks directly. The relevant JavaScript
shape is:

```javascript
const previewModule = await import(previewApiModuleUrl);
const api = previewModule.createPreview({
  dataBaseUrl: "blueprint/-verso-data/",
  canonicalBaseUrl: "blueprint/"
});
const graphModule = await import(api.graphApiModuleUrl());
const [graph] = await graphModule.loadGraphs();

await graphModule.renderGraphData(document.querySelector("#graph-host"), graph, {
  previewUtils: api,
  layout: "fill",
  refresh: true
});
```

## Blueprint Nodes In Slides

The Blueprint integration itself comes from `VersoBlueprint.Slides`. A deck can
render manifest-backed nodes with `{blueprint_node ...}` and initialize preview
behavior with `Informal.Slides.slidesMainWithBlueprintPreviews`:

```lean
import VersoSlides
import VersoBlueprint.Graft
import VersoBlueprint.Slides

open VersoSlides

def main : IO UInt32 := do
  let config : Config := { theme := "white" }
  Informal.Slides.slidesMainWithBlueprintPreviews
    (config := config)
    (previewManifest? := some (blueprintDataDir / Informal.PreviewManifest.manifestFilename))
    (previewHtmlCache? := some (blueprintDataDir / Informal.PreviewManifest.htmlCacheFilename))
    (doc := %doc Slides)
```

This deck builds the FLT Blueprint first, copies its HTML under
`_slides/blueprint/`, and supplies its manifest and HTML cache to the slide
renderer. `verso-highlight.js` adds the small Verso syntax highlighter used by
the source examples.
