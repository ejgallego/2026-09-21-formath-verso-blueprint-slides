import VersoSlides
import Verso.Doc.ArgParse
import Verso.Doc.Elab

open Verso Doc ArgParse
open Verso.Doc.Elab
open Lean

namespace VersoSlides

public meta structure BlueprintGraphArgs where
  key : Option String := none
  view : Option String := none
  direction : Option String := none
  pack : Option String := none
  «class» : Option String := none
  base : Option String := none

public meta instance : FromArgs BlueprintGraphArgs DocElabM where
  fromArgs :=
    BlueprintGraphArgs.mk <$>
      .named `key .string true <*>
      .named `view .string true <*>
      .named `direction .string true <*>
      .named `pack .string true <*>
      .named `class .string true <*>
      .named `base .string true

private abbrev SlidesBlock := Block Slides

private def cleanOpt (value : Option String) : Option String :=
  value.bind fun s =>
    let s := s.trimAscii.copy
    if s.isEmpty then none else some s

private def escapeHtmlAttr (s : String) : String :=
  let s := s.replace "&" "&amp;"
  let s := s.replace "\"" "&quot;"
  let s := s.replace "<" "&lt;"
  s.replace ">" "&gt;"

private def dataAttr (name : String) (value : Option String) : String :=
  match cleanOpt value with
  | none => ""
  | some value => s!" data-bp-graph-{name}=\"{escapeHtmlAttr value}\""

private def graphHostHtml (args : BlueprintGraphArgs) : String :=
  let cssClass :=
    match cleanOpt args.«class» with
    | none => "blueprint-graph-slide"
    | some cls => s!"blueprint-graph-slide {cls}"
  "<div class=\"" ++ escapeHtmlAttr cssClass ++ "\" data-bp-slide-graph=\"true\"" ++
    dataAttr "key" args.key ++
    dataAttr "view" args.view ++
    dataAttr "direction" args.direction ++
    dataAttr "pack" args.pack ++
    (match cleanOpt args.base with
     | some base => " data-bp-blueprint-base=\"" ++ escapeHtmlAttr base ++ "\""
     | none => "") ++
    "></div>"

public def blueprintGraphBlock
    (key view direction pack cssClass base : Option String) : SlidesBlock :=
  let args : BlueprintGraphArgs := {
    key := key
    view := view
    direction := direction
    pack := pack
    «class» := cssClass
    base := base
  }
  Block.other (BlockExt.diagram (graphHostHtml args) "100%" none) #[]

/--
Render a generated Blueprint graph directly in the slide deck.

The runtime script in `Lib/blueprint-graph-slide.js` loads graph data from
the copied Blueprint `-verso-data` directory and initializes it with VBP's
public `api/graph.mjs` entry point.
-/
@[block_command]
public meta def blueprintGraph : BlockCommandOf BlueprintGraphArgs
  | args => do
    ``(blueprintGraphBlock
        $(quote args.key)
        $(quote args.view)
        $(quote args.direction)
        $(quote args.pack)
        $(quote args.«class»)
        $(quote args.base))

end VersoSlides
