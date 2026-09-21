import Lib.Arxiv
import Lib.BlueprintGraph
import Lib.Demo
import Lib.Hal
import Lib.Layout
import Lib.WebShot

/-!
Reusable local widgets for this Verso Slides deck.

Import this module from deck files that need the local presentation widgets.

Public authoring commands:

* `{arxiv ...}` / `{arXiv ...}` for paper cards.
* `{blueprintGraph ...}` for a slide-native Blueprint graph.
* `:::arxiv ...` / `:::arXiv ...` for paper cards with slide prose.
* `{hal ...}` / `{HAL ...}` for HAL paper cards.
* `:::hal ...` / `:::HAL ...` for HAL paper cards with slide prose.
* `:::center` for centered block content and centered layout wrappers.
* `{webshot ...}` / `{webShot ...}` for cached webpage screenshots.
-/
