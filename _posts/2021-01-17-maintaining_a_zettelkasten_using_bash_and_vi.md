---
layout: post
title: Maintaining a Zettelkasten using Bash and Vi
date: 2021-01-17T18:31:40.000Z
categories: writing
synopsis: change me
last-modified-date: "2021-06-12T16:40:01+01:00"
---

I've mentioned [earlier](2020-05-29-keeping_a_journal_in_vim) that I was trying
to use 'basic' tools like `Vi` and `Bash` preference to gui heavy tools.
Describing Vi and Bash as simple tools does them a disservice. Bash is powerful
enough to be used as a full programming language,even before you factor in the
range of external programs (`sed`, `perl`, `awk`, _ad infinitum_) that it can
call on. Vi has an established `vimscript` language and a long enough lifespan
to ensure anything you are trying to do has been attempted, and likely
documented before. Can these two tools be enough to manage a Zettelkasten
though?

## What's a Zettelkasten?

I'm getting ahead of myself. _Zettelkasten_ is the German term for 'slip box'.
It's the colloquial term used for managing and storing notes. The concept spans
back five hundred years or so to Conrad Gessner, and his
[bibliography](https://www.rcpe.ac.uk/heritage/conrad-gesner), but it's
[Niklas Luhmann](https://www.youtube.com/watch?v=U2hxygqjx2k) who raised the
profile of the idea. In simple terms, knowledge is added to cards. Each card is
contains a contained idea, but each card may reference others. For instance a
card about the stained glass used in Notre-Dame may reference a cards about
medieval glass making, religious iconography in the 13th century, lead smelting,
and so on. Storing the information is important, but linking ideas and knowledge
is where the system comes into its own. Rather than writing an encyclopedia of
knowledge, you end up writing something much closer to a wiki. Ideas are
captured concisely, reviewed regularly, and linked widely.
[This](https://www.goodreads.com/book/show/34507927-how-to-take-smart-notes)
book by Sönke Ahrens explains the process, and strategies in far greater (but
wonderfully digestible) detail.

## What Does an Electronic Zettelkasten Look Like?

If we're looking at making a wiki; that is absolutely possible, perhaps even in
Vi alone. Using markdown files, it is possible to king files together simply
with minimal effort. Managing and searching files however might need more heavy
lifting. The
[blog here](https://www.edwinwenink.xyz/posts/48-vim_fast_creating_and_linking_notes/)
was an excellent resource; the author covers all the functionality I wanted,
specifically, naming of cards, and finding them.

In large part, I've simply copied the code wholesale. The fuzzy-find/insert
function is perfect for my needs:

```vimscript
"
" see https://www.edwinwenink.xyz/posts/48-vim_fast_creating_and_linking_notes/
"

" CtrlP function for inserting a markdown link with Ctrl-X
function! CtrlPOpenFunc(action, line)
   if a:action =~ '^h$'
      " Get the filename
      let filename = fnameescape(fnamemodify(a:line, ':t'))
    let filename_wo_timestamp = fnameescape(fnamemodify(a:line, ':t:s/\d+-//'))

      " Close CtrlP
      call ctrlp#exit()
      call ctrlp#mrufiles#add(filename)

      " Insert the markdown link to the file in the current buffer
    let mdlink = "[ ".filename_wo_timestamp." ]( ".filename." )"
      put=mdlink
  else
      " Use CtrlP's default file opening function
      call call('ctrlp#acceptfile', [a:action, a:line])
   endif
endfunction

let g:ctrlp_open_func = {
         \ 'files': 'CtrlPOpenFunc',
         \ 'mru files': 'CtrlPOpenFunc'
         \ }
```

Although I tried the file naming function, I found that my combination of
multiple zettelkasten (One for work, one for study and a general one) meant a
function with hardcoded path wasn't workable. I decided that a shell function
would be easier to maintain across devices. a simple function to decide what
`ZETTEL_DIR` is based on context (is `pwd` in a study/work path) means the card
is created in the correct directory.

```bash
# New Zettle card
nz() {
  DATE_STR=$(date +"%Y%m%d%H%M")
  TITLE=$*
  CLEAN_TITLE=$(echo $* | sed 's/ /_/g'| tr '[:upper:]' '[:lower:]')
  ZETTLE=$ZETTLE_DIR$DATE_STR'-'$CLEAN_TITLE.md
  echo '# '$TITLE > $ZETTLE
  vi $ZETTLE
}
```
