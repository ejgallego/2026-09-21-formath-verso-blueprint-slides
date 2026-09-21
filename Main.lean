import VersoSlides
import VersoBlueprint.Slides
import Slides

open VersoSlides

def deckCss : IO CssFile := do
  let css ← IO.FS.readFile "static/custom.css"
  return { filename := "custom.css", contents := ⟨css⟩ }

def versoHighlightJsFilename : String :=
  "verso-highlight.js"

def blueprintGraphSlideJsFilename : String :=
  "blueprint-graph-slide.js"

def fltBlueprintDataDir : System.FilePath :=
  "examples/verso-flt/_out/site/html-multi/-verso-data"

def fltBlueprintManifestSource : System.FilePath :=
  fltBlueprintDataDir / Informal.PreviewManifest.manifestFilename

def fltBlueprintHtmlCacheSource : System.FilePath :=
  fltBlueprintDataDir / Informal.PreviewManifest.htmlCacheFilename

def fltBlueprintHtmlSource : System.FilePath :=
  "examples/verso-flt/_out/site/html-multi"

def fltBlueprintSlideBase : System.FilePath :=
  "blueprint"

private def writeBinFileWithDirs (path : System.FilePath) (bytes : ByteArray) : IO Unit := do
  let dir := path.parent.getD "."
  unless ← dir.pathExists do
    IO.FS.createDirAll dir
  IO.FS.writeBinFile path bytes

private partial def copyDirRecursive (src dst : System.FilePath) : IO Unit := do
  unless ← src.pathExists do
    throw <| IO.userError s!"missing FLT Blueprint HTML output at {src}"
  IO.FS.createDirAll dst
  for entry in ← src.readDir do
    let target := dst / entry.fileName
    if ← entry.path.isDir then
      copyDirRecursive entry.path target
    else
      writeBinFileWithDirs target (← IO.FS.readBinFile entry.path)

private def removePathIfExists (path : System.FilePath) : IO Unit := do
  if ← path.pathExists then
    if ← path.isDir then
      IO.FS.removeDirAll path
    else
      IO.FS.removeFile path

private def copyDirFresh (src dst : System.FilePath) : IO Unit := do
  removePathIfExists dst
  copyDirRecursive src dst

/--
Splits `s` at the first occurrence of `sep`. Returns `none` if `sep` does
not occur; otherwise returns the prefix before the separator and the suffix
after it.
-/
private def splitFirst (s sep : String) : Option (String × String) :=
  let parts := s.splitOn sep
  match parts with
  | [] => none
  | [_] => none
  | hd :: tail => some (hd, String.intercalate sep tail)

private def firstScriptContainingAux (needle : String) : List String → Option String
  | [] => none
  | part :: rest =>
    match splitFirst part "</script>" with
    | some (body, _) =>
      match splitFirst body needle with
      | some _ => some ("<script>" ++ body ++ "</script>")
      | none => firstScriptContainingAux needle rest
    | none => firstScriptContainingAux needle rest

private def firstScriptContaining (html needle : String) : Option String :=
  firstScriptContainingAux needle ((html.splitOn "<script>").drop 1)

private def readFltTexPreludeScript? : IO (Option String) := do
  let pagePath := fltBlueprintHtmlSource / "Dependency-Graph" / "index.html"
  if !(← pagePath.pathExists) then
    pure none
  else
    let html ← IO.FS.readFile pagePath
    pure <| firstScriptContaining html "window.bpTexPreludeTable = Object.assign"

private def takeTitleParagraph (s : String) : Option (String × String) :=
  match splitFirst s "<p>\n            " with
  | none => none
  | some (_, afterOpen) =>
    match splitFirst afterOpen "</p>\n          " with
    | none => none
    | some (p, rest) => some (p, rest)

private def titleNotes (s : String) : String :=
  match splitFirst s "<aside class=\"notes\">" with
  | none => ""
  | some (_, notes) => "<aside class=\"notes\">" ++ notes

/--
Rewrites the first generated slide into the Lean FRO title-slide template.

The rewrite depends on the structure of the first slide, not on its exact text:
title, speaker, affiliation, event, and venue/date are read from the first
heading and four paragraph elements in `Slides.lean`.
-/
private def rewriteTitleSlide (html : String) : String :=
  let titleOpen := "<section>\n          <h2>\n            "
  let titleClose := "</h2>\n          "
  let sectionClose := "</section>"
  match splitFirst html titleOpen with
  | none => html
  | some (before, afterOpen) =>
  match splitFirst afterOpen titleClose with
  | none => html
  | some (title, afterTitle) =>
  match splitFirst afterTitle sectionClose with
  | none => html
  | some (body, afterSection) =>
  match takeTitleParagraph body with
  | none => html
  | some (speaker, rest) =>
  match takeTitleParagraph rest with
  | none => html
  | some (affiliation, rest) =>
  match takeTitleParagraph rest with
  | none => html
  | some (event, rest) =>
  match takeTitleParagraph rest with
  | none => html
  | some (venueDate, _) =>
    let (venue, date) :=
      match splitFirst venueDate " | " with
      | some (venue, date) => (venue, date)
      | none => (venueDate, "")
    let dateHtml :=
      if date.isEmpty then "" else s!"\n          <div class=\"date\">{date}</div>"
    let titleSlide :=
      "<section class=\"title-slide\">\n" ++
      "          <div class=\"top-area\"><img class=\"logo\" src=\"lean-logo-large.png\" alt=\"Lean Logo\"></div>\n" ++
      s!"          <div class=\"blue-band\"><h1>{title}</h1>\n" ++
      s!"          <div class=\"meta\"><strong>{speaker}</strong><br>{affiliation}<br>{event}<br>{venue}</div>" ++
      dateHtml ++
      "\n          </div>" ++
      titleNotes body ++
      "</section>"
    before ++ titleSlide ++ afterSection

private def removeLegacyBlueprintPreviewManifests (outputDir : System.FilePath) : IO Unit := do
  let legacyManifest := "blueprint-preview-manifest.json"
  removePathIfExists (outputDir / "-verso-data" / legacyManifest)
  removePathIfExists (outputDir / fltBlueprintSlideBase / "-verso-data" / legacyManifest)

def main : IO UInt32 := do
  let css ← deckCss
  let config : Config := {
    theme := "white",
    transition := "fade",
    slideNumber := true,
    center := false,
    margin := 0,
    width := 1280,
    height := 720,
    extraCss := #[css],
    extraJs := #[versoHighlightJsFilename, blueprintGraphSlideJsFilename]
  }
  let rc ← Informal.Slides.slidesMainWithBlueprintPreviews
    (config := config)
    (previewManifest? := some fltBlueprintManifestSource)
    (doc := %doc Slides)
    (previewHtmlCache? := some fltBlueprintHtmlCacheSource)
  let outputDir := config.outputDir

  let versoHighlightJs ← IO.FS.readFile "Lib/verso-highlight.js"
  IO.FS.writeFile (outputDir / versoHighlightJsFilename) versoHighlightJs
  let blueprintGraphSlideJs ← IO.FS.readFile "Lib/blueprint-graph-slide.js"
  IO.FS.writeFile (outputDir / blueprintGraphSlideJsFilename) blueprintGraphSlideJs
  copyDirFresh fltBlueprintHtmlSource (outputDir / fltBlueprintSlideBase)
  for state in ["verso", "before", "after"] do
    copyDirFresh (System.FilePath.mk "_demo" / state / "html-multi")
      (outputDir / "demo" / state)
  removeLegacyBlueprintPreviewManifests outputDir
  let logoBytes ← IO.FS.readBinFile "static/lean-logo.png"
  IO.FS.writeBinFile (outputDir / "lean-logo.png") logoBytes
  let logoLargeBytes ← IO.FS.readBinFile "static/lean-logo-large.png"
  IO.FS.writeBinFile (outputDir / "lean-logo-large.png") logoLargeBytes
  let fltVideoBytes ← IO.FS.readBinFile "static/videos/flt-progress.mp4"
  IO.FS.writeBinFile (outputDir / "flt-progress.mp4") fltVideoBytes
  let fltPosterBytes ← IO.FS.readBinFile "static/images/flt-progress-poster.png"
  IO.FS.writeBinFile (outputDir / "flt-progress-poster.png") fltPosterBytes

  let htmlPath := outputDir / "index.html"
  let html ← IO.FS.readFile htmlPath
  let html :=
    match ← readFltTexPreludeScript? with
    | some script => html.replace "</head>" (script ++ "\n    </head>")
    | none => html
  let html := html.replace
    "Reveal.initialize({"
    "Reveal.initialize({\n        disableLayout: true,\n        highlight: window.registerVersoHighlight ? { beforeHighlight: window.registerVersoHighlight } : {},"
  let html := rewriteTitleSlide html
  let slideHeader := "<div class=\"slide-header\"><img src=\"lean-logo.png\" alt=\"Lean\"></div>"
  let html := html.replace "<section>\n" s!"<section>\n          {slideHeader}\n"
  let html := html.replace "<section data-transition=\"fade\">\n" s!"<section data-transition=\"fade\">\n          {slideHeader}\n"
  let html := html.replace s!"<section>\n          {slideHeader}\n          <section>"
                          "<section>\n          <section>"
  let html := html.replace s!"<section>\n          {slideHeader}\n          <section data-transition=\"fade\">"
                          "<section>\n          <section data-transition=\"fade\">"
  IO.FS.writeFile htmlPath html
  return rc
