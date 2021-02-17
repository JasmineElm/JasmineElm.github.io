---
layout: post
title:  vim Configuration
date:    2020-06-09
categories: code
synopsis: vim configuration can be a difficult thing to get right. I explain my design choices and share config.
---

## My vim Configuration

The more I use vim, the more handy tricks I pick up.  I'm currently using vim to write a 10,000 word assignment; something I would have struggled to consider months ago, but with a reasonably minimal configuration combined with some handy configuration tweaks, my experience of writing for longer periods in a terminal prompt isn't too shabby.

My path to learning vim has been a relatively slow one.  There were a few _aha_ moments, but for the most part, progress was a result of concerted effort to build both knowledge and muscle memory. If you on a similar journey to learn vim, these are the things that I found most useful

+ _learn_ the basics of movement.
+ learn how buffers work (buffers seriously improve your copy/paste game)
+ don't blindly paste other people's `.vimrc` into your own, but
+ do experiment

Of course, vim isn't for everyone.  It wasn't for me until I found myself __having__ to use it for work.  Choosing a modal editor when you have access to shiny tools like VSCode can be a difficult ask especially when you don't [grok](https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim) vim. I'm hardly an expert, but I've got to a point where I can productively work without having to consciously thinking about it. An unexpected benefit to vim is that I find myself working more quickly with a higher level of concentration than when using VSCode, or _shudder_ Word.  There's no secret to this, it's purely a result of a minimally decorated terminal having a far smaller cognitive overhead; by default, there is no visual cruft, decorated menus, or even fancy `powerline` prompts.  I only see what I am _actively working on_.  Extending this idea, I have configured my `.vimrc` along the following principles:

+ simple: Don't add plug-ins, or reams of `viml`, use standard configuration where possible
+ minimal: Only configure elements that provide active benefit
+ flexible: be open-minded enough to realise my  configuration will evolve 

Below are three pieces of my configuration that i think demonstrate these principles:

## Spell highlight toggle

The majority of my vim use is in writing markdown. Using `spell` is key for picking up typos, and simple grammatical errors.  It's not as advanced as the tools in Word, but on the other hand, I don't have to deal with the overheads or cost of Word.  Out of the box `spell` is fairly decent, but having the visual problems shouting out at me whilst I'm trying to get ideas out is a distraction that I find slows down my writing.  I could configure my colours to be less startling, but that doesn't solve the problem, and arguably makes spotting bad spellings more difficult.  What I really want is spell check that is _off_ by default, but can be quickly toggled when needed 

## `statusline` style information in the ruler

By default, vim shows a minimally decorated `ruler` that contains the bare minimum of information.  You can add a more informative `statusline` that shows, I believe more _useful_ information, but this is at the expense of screen real estate.  On my laptop, the combined status and ruler take up the better part of 10% of the entire space.  Instead, I take a minimal subset of information, and place that in my statusbar:

![an image of my ruler]({{site.url}}/images/ruler.png)

The ruler contains word count(`650` in this example), whether the files is modified (`[+]`), and the `line number`:`column`.  This is perfect for my needs, anything more would be a waste.

## Toggle Explorer

Usually, I work on a single file, and don't need to think about jumping between directories; I'm writing essays, not complex code-bases.  When I am writing longer, more complex documents, I do prefer to split sections out into separate files.  For instance, I'm working on a 10,000 word essay that is split thematically into six files. This approach lets me focus on one thing at once.  Whilst vim handles this magnificently, a couple of lines of configuration means I can use `:find` or `:edit` to open different files with minimal (tab completing) fuss, having a dedicated file browser that I can toggle is a brilliant tweak for me; I can remind myself of the document structure, and open new files with a few keystrokes (`<C-E>` to open the browser, `j`, `k` for selecting the right one, and `enter` to open it)

## What's Missing

I alluded to my configuration being a living thing; as my usage evolves, it should be matched by the configuration.  There are a few things I want to investigate further, particularly around getting a better workflow between `pandoc` and vim. Things such as pandoc are top of the list; [Vim-Pandoc](https://github.com/vim-pandoc/vim-pandoc) is something I want to integrate, together with some sort of workflow around rendering documents automatically.

My full configuration can be found [here](https://github.com/JasmineElm/vim)
