import VersoSlides
import Verso.Doc.ArgParse
import Verso.Doc.Elab

open Verso Doc ArgParse
open Verso.Doc.Elab
open Lean

namespace VersoSlides

/-!
Cached webpage screenshots for slides.

The public authoring surface is `{webshot url cache ...}` or `{webShot url cache
...}`. The cache path is deliberately constrained to `static/webshots/*.png` so
cached images can be committed and reviewed as normal presentation assets.

The build only captures when the cache file is missing. Delete the cache image,
or change the cache filename, to force a refresh.
-/

public meta structure WebShotArgs where
  url : String
  cache : String
  alt : Option String := none
  width : Option String := none
  height : Option String := none
  «class» : Option String := none
  viewportWidth : Option Nat := none
  viewportHeight : Option Nat := none
  delayMs : Option Nat := none

public meta instance : FromArgs WebShotArgs DocElabM where
  fromArgs :=
    WebShotArgs.mk <$>
      .positional `url .string <*>
      .positional `cache .string <*>
      .named `alt .string true <*>
      .named `width .string true <*>
      .named `height .string true <*>
      .named `class .string true <*>
      .named `viewportWidth .nat true <*>
      .named `viewportHeight .nat true <*>
      .named `delayMs .nat true

private abbrev SlidesInline := Inline Slides
private abbrev SlidesBlock := Block Slides

private def cleanOpt (value : Option String) : Option String :=
  value.bind fun s =>
    let s := s.trimAscii.copy
    if s.isEmpty then none else some s

private def ensureWebShotCachePath (path : System.FilePath) : DocElabM Unit := do
  if path.isAbsolute then
    throwError "webshot cache must be relative, got '{path}'"
  let pathStr := path.toString
  if pathStr.contains ".." then
    throwError "webshot cache must not contain '..', got '{path}'"
  unless pathStr.startsWith "static/webshots/" do
    throwError "webshot cache must live under 'static/webshots/', got '{path}'"
  unless pathStr.toLower.endsWith ".png" do
    throwError "webshot cache must be a PNG file, got '{path}'"

private def ensureWebShot (args : WebShotArgs) : DocElabM Unit := do
  let cache : System.FilePath := ⟨args.cache⟩
  ensureWebShotCachePath cache
  if ← cache.pathExists then
    return
  let width := args.viewportWidth.getD 1280
  let height := args.viewportHeight.getD 720
  let delay := args.delayMs.getD 1000
  let out ← IO.Process.output {
    cmd := "python3"
    args := #[
      "Lib/capture-webshot.py",
      "--url", args.url,
      "--output", args.cache,
      "--width", toString width,
      "--height", toString height,
      "--delay-ms", toString delay
    ]
  }
  unless out.exitCode == 0 do
    throwError "failed to capture webshot for '{args.url}'\n{out.stderr}"

private def webShotBlock
    (url cache : String) (alt width height cssClass : Option String) :
    SlidesBlock :=
  let alt := cleanOpt alt |>.getD url
  let cssClass :=
    match cleanOpt cssClass with
    | none => some "webshot-image"
    | some cls => some s!"webshot-image {cls}"
  let image : SlidesInline :=
    Inline.other
      (InlineExt.image
        (ImgSrc.projectRelative cache)
        alt
        (cleanOpt width)
        (cleanOpt height)
        cssClass)
      #[]
  Block.other (BlockExt.wrap #[("class", "webshot")]) #[Block.para #[image]]

/--
Insert a cached screenshot of a webpage.

If the cache image exists, it is reused. Delete the image, or change the cache
path, to force a fresh capture on the next build.

Example:
```
{webshot "https://arxiv.org/abs/2601.22554" "static/webshots/leanarchitect.png" (width := "100%")}
```
-/
@[block_command]
public meta def webshot : BlockCommandOf WebShotArgs
  | args => do
    ensureWebShot args
    ``(webShotBlock
        $(quote args.url)
        $(quote args.cache)
        $(quote args.alt)
        $(quote args.width)
        $(quote args.height)
        $(quote args.class))

@[block_command webShot]
public meta def webShot : BlockCommandOf WebShotArgs :=
  webshot

end VersoSlides
