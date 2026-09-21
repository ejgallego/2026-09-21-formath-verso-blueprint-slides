import VersoSlides
import Verso.Doc.Elab
import Verso.Doc.ArgParse

open Verso Doc Elab ArgParse
open Lean

namespace VersoSlides

public meta structure DemoFrameArgs where
  path : String
  title : String

public meta instance : FromArgs DemoFrameArgs DocElabM where
  fromArgs := DemoFrameArgs.mk <$> .positional `path .string <*> .positional `title .string

/-- A local demo page, isolated from the slide runtime and keyboard navigation. -/
@[block_command]
public meta def demoFrame : BlockCommandOf DemoFrameArgs := fun {path, title} => do
  unless path.startsWith "demo/" && !(path.splitOn "/").contains ".." do
    throwError "demoFrame expects a local path under demo/"
  let escape (s : String) :=
    s.replace "&" "&amp;" |>.replace "\"" "&quot;" |>.replace "<" "&lt;"
  let html := "<iframe class=\"demo-frame\" src=\"" ++ escape path ++
    "\" title=\"" ++ escape title ++ "\"></iframe>"
  ``(Block.other (BlockExt.diagram $(quote html) "100%" none) #[])

end VersoSlides
