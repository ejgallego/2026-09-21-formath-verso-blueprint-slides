import VersoSlides
import Verso.Doc.Elab

open Verso Doc
open Verso.Doc.Elab
open Lean

namespace VersoSlides

/-!
Small local layout directives for this deck.
-/

/--
Center the enclosed block content.

Examples:
```
:::center
Centered text.
:::

:::center
{image "static/images/example.png" (width := "70%")}[Example]
:::

::::center
:::hstack
Left.

Right.
:::
::::
```
-/
@[directive]
public meta def center : DirectiveExpanderOf Unit
  | (), stxs => do
    let attrs : Array (String × String) := #[("class", "center")]
    let blocks ← stxs.mapM fun stx => do
      let b ← elabBlock stx
      ``(Block.other (VersoSlides.BlockExt.attr $(quote attrs)) #[$b])
    ``(Block.concat #[$blocks,*])

end VersoSlides
