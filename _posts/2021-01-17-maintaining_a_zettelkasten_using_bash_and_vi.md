---
layout: post
title:  Maintaining a Zettelkasten using Bash and Vi
date:    2021-01-17 18:31:40 
categories: writing
synopsis: change me
---

I've mentioned [earlier]() that I was trying to use 'basic' tools like `Vi` and `Bash` preference to gui heavy tools.  Describing Vi and Bash as simple tools does them a disservice.  Bash is powerful enough to be used as a full programming lanuage,even before you factor in the range of external programs (`sed`, `perl`, `awk`, _ad infinitum_) that it can call on. Vi has an established `vimscript` language and a long enough lifespan to ensure anything you are trying to do has been attempted, and likely documented before.  Can these two tools be enough to manage a Zettelkasten though?

## What's a Zettelkasten?

I'm getting ahead of myself.  _Zettelkasten_ is the German term for 'slip box'.  It's the colloquial term used for managing and stroing notes. The concept spans back five hundred years or so to  Conrad Gessner, but it's Niklas Luhmann who raised the profile of the idea.
In simple terms, knowledge is added to cards.  Each card is contains a contained idea, but each card may reference others.  For instance a card about the stained glass used in Notre-Dame may reference a cards about medieval glass making, religious iconography in the 13th century, lead smelting, and so on.  Storing the information is important, but linking ideas and knowledge is where the system comes into its own.  Rather than writing an encyclopaedia of knowledge, you end up writing something much closer to a wiki.  Ideas are captured concisely, reviewed regularly, and linked widely.  [This](https://www.goodreads.com/book/show/34507927-how-to-take-smart-notes) book by Sönke Ahrens explains the process, and strategies in far greater (but wonderfully digestible) detail.

## What does an electronic zettelhkasten look like?

If we're looking at making a wiki; that is absolutely possible, perhaps even in Vi alone.  Using markdown files, it is possible to king files together simply with minimal effort.  Managing and searching files however might need more heavy lifting.  

+ How do we ensure files are individually named?
+ how do we capture 'freshness' of the card?
+ how do we link cards directly
+ how do we search through the ideas to identify new links?

so we have the following requirements

+ alias to make a new card
+ grepping for existing cards
+ different zettelkasten directories..?
+ availability


## The Solution

+ Bash to generate the initial file
+ \nz to create files within vi
+ search function within vi

+ code snippets
- links to dotfiles

## The future

+ works well, but linking is slightly clunky
+ grepping is a little cumbersome
