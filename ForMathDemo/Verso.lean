import VersoManual

open Verso.Genre Verso.Genre.Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Equality transport" =>

# Applying a function
%%%
tag := "transport"
%%%

If $`x = y`, then $`g(x) = g(y)`.
The Lean declaration is {name}`congrArg`.

```lean
#check congrArg
```

Return to {ref "transport"}[applying a function].
