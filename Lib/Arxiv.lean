import VersoSlides
import Verso.Doc.ArgParse
import Verso.Doc.Elab

open Verso Doc ArgParse
open Verso.Doc.Elab
open Lean

namespace VersoSlides

/-!
Local slide widgets for citing arXiv papers.

The public authoring surface is:

* `{arxiv "2601.22554" ...}`
* `{arXiv "2601.22554" ...}`
* `:::arxiv "2601.22554" ...`
* `:::arXiv "2601.22554" ...`

The command form renders a compact paper card. The directive form renders the
same card with arbitrary slide prose in the summary area.
-/

public meta structure ArxivArgs where
  id : String
  title : Option String := none
  authors : Option String := none
  published : Option String := none
  venue : Option String := none
  summary : Option String := none
  url : Option String := none
  pdf : Option String := none

public meta instance : FromArgs ArxivArgs DocElabM where
  fromArgs :=
    ArxivArgs.mk <$>
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

private def normalizeArxivId (raw : String) : String :=
  let s := raw.trimAscii.copy
  let s := dropPrefixCI "https://arxiv.org/abs/" s
  let s := dropPrefixCI "http://arxiv.org/abs/" s
  let s := dropPrefixCI "https://www.arxiv.org/abs/" s
  let s := dropPrefixCI "http://www.arxiv.org/abs/" s
  let s := dropPrefixCI "https://arxiv.org/pdf/" s
  let s := dropPrefixCI "http://arxiv.org/pdf/" s
  let s := dropPrefixCI "https://www.arxiv.org/pdf/" s
  let s := dropPrefixCI "http://www.arxiv.org/pdf/" s
  let s := dropPrefixCI "arxiv:" s
  let s := dropPrefixCI "abs/" s
  let s := dropPrefixCI "pdf/" s
  let s := if s.toLower.endsWith ".pdf" then s.dropSuffix ".pdf" else s
  s.trimAscii.copy

private def arxivAbsUrl (id : String) (url? : Option String) : String :=
  cleanOpt url? |>.getD s!"https://arxiv.org/abs/{id}"

private def arxivPdfUrl (id : String) (pdf? : Option String) : String :=
  cleanOpt pdf? |>.getD s!"https://arxiv.org/pdf/{id}"

private abbrev SlidesInline := Inline Slides
private abbrev SlidesBlock := Block Slides

private def spanClass (cls : String) (contents : Array SlidesInline) : SlidesInline :=
  Inline.other (InlineExt.styled #[("class", cls)]) contents

private def divClass (cls : String) (contents : Array SlidesBlock) : SlidesBlock :=
  Block.other (BlockExt.wrap #[("class", cls)]) contents

private def divClassAttrs
    (cls : String) (attrs : Array (String × String)) (contents : Array SlidesBlock) : SlidesBlock :=
  Block.other (BlockExt.wrap (#[("class", cls)] ++ attrs)) contents

private def pClass (cls : String) (contents : Array SlidesInline) : SlidesBlock :=
  Block.other (BlockExt.attr #[("class", cls)]) #[Block.para contents]

private def paperMeta (id absUrl : String) (published venue : Option String) : SlidesBlock :=
  let inlines : Array SlidesInline := Id.run do
    let mut xs := #[
      spanClass "arxiv-paper__badge" #[Inline.text "arXiv"],
      Inline.text " ",
      Inline.link #[Inline.text s!"arXiv:{id}"] absUrl
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
  if body.isEmpty then #[] else #[divClass "arxiv-paper__summary" body]

private def paperActions (absUrl pdfUrl : String) : SlidesBlock :=
  pClass "arxiv-paper__actions" #[
    Inline.link #[Inline.text "Abstract"] absUrl,
    Inline.text " ",
    Inline.link #[Inline.text "PDF"] pdfUrl
  ]

public def arxivPaperBlock
    (id : String) (title authors published venue summary url pdf : Option String)
    (body : Array SlidesBlock) :
    SlidesBlock :=
  let id := normalizeArxivId id
  let id := if id.isEmpty then "unknown" else id
  let title := cleanOpt title |>.getD s!"arXiv:{id}"
  let absUrl := arxivAbsUrl id url
  let pdfUrl := arxivPdfUrl id pdf
  let contents :=
    #[
      paperMeta id absUrl published venue,
      pClass "arxiv-paper__title" #[Inline.link #[Inline.text title] absUrl]
    ] ++
    paperAuthors authors ++
    paperSummary summary body ++
    #[paperActions absUrl pdfUrl]
  divClassAttrs "arxiv-paper" #[("data-arxiv-id", id)] contents

/--
Display an arXiv paper as a slide card.

Example:
```
{arxiv "2601.22554" (title := "LeanArchitect: Automating Blueprint Generation for Humans and AI")}
```
-/
@[block_command]
public meta def arxiv : BlockCommandOf ArxivArgs
  | args => do
    ``(arxivPaperBlock
        $(quote args.id)
        $(quote args.title)
        $(quote args.authors)
        $(quote args.published)
        $(quote args.venue)
        $(quote args.summary)
        $(quote args.url)
        $(quote args.pdf)
        #[])

@[block_command arXiv]
public meta def arXiv : BlockCommandOf ArxivArgs :=
  arxiv

/--
Display an arXiv paper as a slide card containing the directive body.

Example:
```
:::arxiv "2601.22554" (title := "LeanArchitect")
Blueprint generation becomes a Lean-side artifact.
:::
```
-/
@[directive arxiv]
public meta def arxivDirective : DirectiveExpanderOf ArxivArgs
  | args, stxs => do
    let body ← stxs.mapM elabBlock
    ``(arxivPaperBlock
        $(quote args.id)
        $(quote args.title)
        $(quote args.authors)
        $(quote args.published)
        $(quote args.venue)
        $(quote args.summary)
        $(quote args.url)
        $(quote args.pdf)
        #[$body,*])

@[directive arXiv]
public meta def arXivDirective : DirectiveExpanderOf ArxivArgs :=
  arxivDirective

end VersoSlides
