---
layout: post
title: Keeping a Journal in Vim
date: 2020-05-29T00:00:00.000Z
categories: code
synopsis: >-
  Making a journal in vim is surprisingly easy.  This post includes some simple
  scripts to demonstrate the process I currently use.
last-modified-date: '2021-06-12T16:39:56+01:00'

---

For me, keeping  a simple journal, provides a easy way of reflecting on the day. Done right, keeping a diary has been linked to [creativity](https://www.brainpickings.org/2014/09/04/famous-writers-on-keeping-a-diary/), and [reflective learning](https://www.kent.ac.uk/learning/PDP-and-employability/pdp/reflective.html).  Moreover, recording [one good thing per day](https://www.actionforhappiness.org/take-action/find-three-good-things-each-day)  has both mental health, and [positive habit forming](https://charlesduhigg.com/the-power-of-habit/) benefits.

Core to my ability to maintain the habit of keeping a journal is making it _as easy as possible_ to add / maintain entries.  My journal is a brief affair that balances the main benefits of capturing and reflecting on the day's events with the effort required to do so.

## Why Vim?

Given this focus on simplicity, why would I consider Vim?  Surely I'd be stuck in a single entry forever whilst I try to [exit](https://github.com/hakluke/how-to-exit-vim)?

In fact Vim is perfect for the task of journaling; it is readily, _freely_ available on my phone via [termux](https://wiki.termux.com/wiki/Text_Editors#Vim), my laptop, or at a push via ssh. Whilst the same may be said about other editors, Vim's super power as far as journaling is that it can apply templates contextually.  Tying these templates together with Vim's ability to process shell commands, makes it is possible to create a personalised entry with effectively zero effort.  Using a editor in a terminal means I don't have the visual cruft of a bespoke app with the associated [cognitive load](https://www.nngroup.com/articles/zen-mode/) and [interaction cost](https://www.nngroup.com/videos/interaction-cost/).  Finally, _rolling my own_ journal process, allwos me to fully own my data.  I'm not tied to a proprietary platform, and don't have to worry about about how the data is used.

## Ingredients

The solution I have come to is based on three apps:

1. Vim: to create and populate journal entries
2. [rclone](https://rclone.org/) to save entries to a cloud provider
3. Bash to handle file creation, and invoking vim/rclone

The first step would be to create a [template](https://shapeshed.com/vim-templates/).  For the journal, this is essentially a journal entry without the detail.  The template may be placed anywhere, but it makes sense to keep it in your `.vim` directory.  mine is stored in `~/.vim/templates/journal.skeleton`.  Wherever you store yours, it needs sourcing in your _local functions_.

```markdown
## What happened


## What went well


## What didn't go well
```

Next, we need to create a function to invoke the template.  My function is designed to only trigger if I create a new file in a specific directory, or any of its subdirectories.

This function is saved in `~/.vim/local_functions`.  Again, you can save yours elsewhere, but you'll need to make sure your `.vimrc` is sourcing the correct path

```vim

augroup journal
    autocmd!

    " populate journal template
    autocmd VimEnter */journal/**   0r ~/.vim/templates/journal.skeleton

    " set header for the particular journal
    autocmd VimEnter */journal/**   :call JournalMode()

    " https://stackoverflow.com/questions/12094708/include-a-directory-recursively-for-vim-autocompletion
    autocmd VimEnter */journal/**   set complete=k~/documents/journal/**/*

augroup end
```

we'll source this function in our `.vimrc`

```vim
source ~/.vim/local_functions
```

So far so good. If I create a file under any sub/directory of `~/documents/journal`, vim should paste the template  as it opens.  To make the journal entries a bit more specific why not add the date?  There's a few ways to achieve this, but in the spirit of keeping things simple, why not take the filename, and process that?  Let's create the function, again under `~/.vim/local_functions`

```vim
" set header title for journal & enter writing mode
function! JournalMode()
    execute 'normal gg'
" filename in format dd-mm-yy.md 
" add a line to file in format ## dd-mm-yy    
    let filename = '##' . ' ' . expand('%:r')
    call setline(1, filename)
    execute 'normal o'
endfunction
```

Now all we need is a script that will:

1. create the file
2. open it in vim
3. save it to our cloud storage

```bash
#!/bin/sh

# A Script to create a journal entry, open it in vim, and save it 
JOURNAL_DIR='~/documents/journal/'
# each year gets a dir, each month a subdir
ENTRY_DIR=$(date +%Y/%B)
mkdir -p $JOURNAL_DIR$ENTRY_DIR

cd $JOURNAL_DIR$ENTRY_DIR

vim $(date +%d-%m-%y).md
# my rclone is pointing to an instance of OwnCloud
rclone copy ~/documents/journal owncloud:journal
```

## Looking ahead

as I've been using this, I've found myself repeating simple prases.  To reduce this repetition, I've added the following abbreviations to my `.vimrc`

```vim
abbr _ok OK day, 
abbr _gd Good day,
abbr _pd Poor day, 
```

The journal process I have at the moment is a near perfect for my needs, it is low enough to not _get in the way_ of keeping the journal itself, meaning I get the benefit without extraneous effort.

Whilst it's ideal at the moment, there are a few things that could further enhance the process, namely:

- using a yaml block to capture richer data
- encryption of journal entries
- data analysis / sentiment analysis of journal entries

For the time being though, it's good enough to be bulding the habit and reflecting on each day.
