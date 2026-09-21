import VersoManual
import VersoBlueprint.PreviewManifest
import ForMathDemo.After

open Verso Doc
open Verso.Genre Manual

def main (args : List String) : IO UInt32 :=
  Informal.PreviewManifest.blueprintMainWithPreviewData
    (%doc ForMathDemo.After) args
    (extensionImpls := by exact extension_impls%)
