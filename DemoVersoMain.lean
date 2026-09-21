import VersoManual
import ForMathDemo.Verso

open Verso Doc
open Verso.Genre Manual

def main (args : List String) : IO UInt32 :=
  manualMain (%doc ForMathDemo.Verso) (options := args)
