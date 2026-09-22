import Verso
import VersoManual
import VersoBlueprint
import VersoBlueprint.Commands.Graph
import VersoBlueprint.Commands.Summary
import ForMathDemo.Common

open Verso.Genre Verso.Genre.Manual Informal

#doc (Manual) "Left inverse implies injectivity" =>

This is a small authored demonstration, with the Lean proof complete.
The before and after sites preserve the same Blueprint labels.

:::source_document "demo-notes"
%%%
title := "ForMath demonstration notes"
kind := .text
%%%
:::

:::author "presenter" (name := "Demonstration author")
:::

:::group "functions"
Functions, inverses, and cancellation.
:::

# Anatomy

:::theorem "left_inverse_injective" (uses := "left_inverse, injective") (parent := "functions") (owner := "presenter") (tags := "functions, demo") (effort := "small") (priority := "high")
%%%
source := {
  document := "demo-notes"
  spans := #[{
    anchor := "left-inverse"
    citation := "Proposition 1"
    text := some {
      path := "demo-notes.md"
      startLine := 3
      endLine := 7
    }
  }]
}
%%%
A function admitting a left inverse is injective.

For functions $`f,g : \mathbb{N} \to \mathbb{N}`,
$$`(\forall x,\ g(f(x))=x) \implies (\forall x,y,\ f(x)=f(y) \implies x=y).`
:::

```lean "left_inverse_injective" (autoDeps := true)
namespace ForMathDemo.Complete
theorem leftInverseInjective (f g : Nat → Nat)
    (hgf : LeftInverse f g) : Injective f := by
  intro x y h
  exact (hgf x).symm.trans ((transportEq g h).trans (hgf y))
end ForMathDemo.Complete
```

:::proof "left_inverse_injective" (uses := "equality_transport")
Apply $`g` to the equality $`f(x)=f(y)`, then use the left-inverse
identity at both endpoints.
:::

```tex "left_inverse_injective" (slot := statement)
\begin{proposition}
A function admitting a left inverse is injective.
\end{proposition}
```

# A Downstream Task

:::corollary "fibre_singleton" (parent := "functions") (uses := "left_inverse, injective") (owner := "presenter") (tags := "functions, demo") (effort := "small") (priority := "high")
If $`g` is a left inverse of $`f`, each nonempty fibre of $`f`
has exactly one element.
:::

:::proof "fibre_singleton" (uses := "left_inverse_injective")
Apply injectivity to two elements in the same fibre.
:::

{includeBlueprintModule 0 ForMathDemo.Common (title := "Prerequisites")}

{blueprint_graph (direction := TB) (pack := true)}
{blueprint_summary}
