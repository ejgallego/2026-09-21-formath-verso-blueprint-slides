import Lake
open Lake DSL

require VersoBlueprint from "deps/verso-blueprint"

package «vbp-ucm-slides» where
  version := v!"0.1.0"
  precompileModules := false
  leanOptions := #[⟨`experimental.module, true⟩]

lean_lib ForMathDemo where
  roots := #[`ForMathDemo.Common, `ForMathDemo.Before, `ForMathDemo.After, `ForMathDemo.Verso]

lean_lib Slides where
  roots := #[
    `Slides,
    `Lib.Arxiv,
    `Lib.BlueprintGraph,
    `Lib.Demo,
    `Lib.Hal,
    `Lib.Layout,
    `Lib.WebShot,
    `Lib.Widgets
  ]

@[default_target]
lean_exe «vbp-ucm-slides» where
  root := `Main
