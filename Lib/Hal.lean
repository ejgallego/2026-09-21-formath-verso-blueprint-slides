import VersoSlides
import Verso.Doc.ArgParse
import Verso.Doc.Elab

open Verso Doc ArgParse
open Verso.Doc.Elab
open Lean

namespace VersoSlides

/-!
Local slide widgets for citing HAL papers and reports.

The public authoring surface is:

* `{hal "hal-00816699" ...}`
* `{HAL "hal-00816699" ...}`
* `:::hal "hal-00816699" ...`
* `:::HAL "hal-00816699" ...`

The command form renders a compact paper card. The directive form renders the
same card with arbitrary slide prose in the summary area.
-/

public meta structure HalArgs where
  id : String
  title : Option String := none
  authors : Option String := none
  published : Option String := none
  venue : Option String := none
  summary : Option String := none
  url : Option String := none
  pdf : Option String := none

public meta instance : FromArgs HalArgs DocElabM where
  fromArgs :=
    HalArgs.mk <$>
      .positional `id .string <*>
      .named `title .string true <*>
      .named `authors .string true <*>
      .named `published .string true <*>
      .named `venue .string true <*>
      .named `summary .string true <*>
      .named `url .string true <*>
      .named `pdf .string true

private def cleanOpt (value : Option String) : Option String :=
  value.bind fun s =>
    let s := s.trimAscii.copy
    if s.isEmpty then none else some s

private def dropPrefixCI (pre s : String) : String :=
  if s.toLower.startsWith pre.toLower then
    s.drop pre.length |>.copy
  else
    s

private def beforeSlash (s : String) : String :=
  match s.splitOn "/" with
  | [] => s
  | first :: _ => first

private def normalizeHalId (raw : String) : String :=
  let s := raw.trimAscii.copy
  let s := dropPrefixCI "https://hal.science/" s
  let s := dropPrefixCI "http://hal.science/" s
  let s := dropPrefixCI "https://www.hal.science/" s
  let s := dropPrefixCI "http://www.hal.science/" s
  let s := dropPrefixCI "https://hal.inria.fr/" s
  let s := dropPrefixCI "http://hal.inria.fr/" s
  let s := dropPrefixCI "https://inria.hal.science/" s
  let s := dropPrefixCI "http://inria.hal.science/" s
  let s := dropPrefixCI "https://hal.archives-ouvertes.fr/" s
  let s := dropPrefixCI "http://hal.archives-ouvertes.fr/" s
  let s := dropPrefixCI "hal:" s
  beforeSlash s |>.trimAscii |>.copy

private def halAbsUrl (id : String) (url? : Option String) : String :=
  cleanOpt url? |>.getD s!"https://hal.science/{id}"

private def halPdfUrl (id : String) (pdf? : Option String) : String :=
  cleanOpt pdf? |>.getD s!"https://hal.science/{id}/document"

private abbrev SlidesInline := Inline Slides
private abbrev SlidesBlock := Block Slides

private def spanClass (cls : String) (contents : Array SlidesInline) : SlidesInline :=
  Inline.other (InlineExt.styled #[("class", cls)]) contents

private def divClassAttrs
    (cls : String) (attrs : Array (String × String)) (contents : Array SlidesBlock) : SlidesBlock :=
  Block.other (BlockExt.wrap (#[("class", cls)] ++ attrs)) contents

private def pClass (cls : String) (contents : Array SlidesInline) : SlidesBlock :=
  Block.other (BlockExt.attr #[("class", cls)]) #[Block.para contents]

private def paperMeta (id absUrl : String) (published venue : Option String) : SlidesBlock :=
  let inlines : Array SlidesInline := Id.run do
    let mut xs := #[
      spanClass "arxiv-paper__badge hal-paper__badge" #[Inline.text "HAL"],
      Inline.text " ",
      Inline.link #[Inline.text s!"HAL:{id}"] absUrl
    ]
    if let some published := cleanOpt published then
      xs := xs.push (Inline.text s!" · {published}")
    if let some venue := cleanOpt venue then
      xs := xs.push (Inline.text s!" · {venue}")
    xs
  pClass "arxiv-paper__meta" inlines

private def paperAuthors (authors : Option String) : Array SlidesBlock :=
  match cleanOpt authors with
  | none => #[]
  | some authors => #[pClass "arxiv-paper__authors" #[Inline.text authors]]

private def paperSummary (summary : Option String) (body : Array SlidesBlock) : Array SlidesBlock :=
  let summaryBlocks :=
    match cleanOpt summary with
    | none => #[]
    | some summary => #[Block.para #[Inline.text summary]]
  let body := summaryBlocks ++ body
  if body.isEmpty then #[] else #[Block.other (BlockExt.wrap #[("class", "arxiv-paper__summary")]) body]

private def paperActions (absUrl pdfUrl : String) : SlidesBlock :=
  pClass "arxiv-paper__actions" #[
    Inline.link #[Inline.text "Record"] absUrl,
    Inline.text " ",
    Inline.link #[Inline.text "PDF"] pdfUrl
  ]

public def halPaperBlock
    (id : String) (title authors published venue summary url pdf : Option String)
    (body : Array SlidesBlock) :
    SlidesBlock :=
  let id := normalizeHalId id
  let id := if id.isEmpty then "unknown" else id
  let title := cleanOpt title |>.getD s!"HAL:{id}"
  let absUrl := halAbsUrl id url
  let pdfUrl := halPdfUrl id pdf
  let contents :=
    #[
      paperMeta id absUrl published venue,
      pClass "arxiv-paper__title" #[Inline.link #[Inline.text title] absUrl]
    ] ++
    paperAuthors authors ++
    paperSummary summary body ++
    #[paperActions absUrl pdfUrl]
  divClassAttrs "arxiv-paper hal-paper" #[("data-hal-id", id)] contents

/--
Display a HAL paper or report as a slide card.

Example:
```
{hal "hal-00816699" (title := "A Machine-Checked Proof of the Odd Order Theorem")}
```
-/
@[block_command]
public meta def hal : BlockCommandOf HalArgs
  | args => do
    ``(halPaperBlock
        $(quote args.id)
        $(quote args.title)
        $(quote args.authors)
        $(quote args.published)
        $(quote args.venue)
        $(quote args.summary)
        $(quote args.url)
        $(quote args.pdf)
        #[])

@[block_command HAL]
public meta def HAL : BlockCommandOf HalArgs :=
  hal

/--
Display a HAL paper or report as a slide card containing the directive body.

Example:
```
:::hal "hal-00816699" (title := "A Machine-Checked Proof of the Odd Order Theorem")
This reports the Coq/Rocq formalization of the Feit-Thompson theorem.
:::
```
-/
@[directive hal]
public meta def halDirective : DirectiveExpanderOf HalArgs
  | args, stxs => do
    let body ← stxs.mapM elabBlock
    ``(halPaperBlock
        $(quote args.id)
        $(quote args.title)
        $(quote args.authors)
        $(quote args.published)
        $(quote args.venue)
        $(quote args.summary)
        $(quote args.url)
        $(quote args.pdf)
        #[$body,*])

@[directive HAL]
public meta def HALDirective : DirectiveExpanderOf HalArgs :=
  halDirective

end VersoSlides
