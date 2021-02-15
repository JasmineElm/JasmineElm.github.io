---
layout: post
title:  Terminal Shortcuts
date:    2021-02-15 14:52:05 
categories: code
synopsis: CTRL and wut? </br> There's plenty of shortcuts that can make using the prompt even faster
---

I'm slowly making my way through the [Linux Upskill Challenge](https://linuxupskillchallenge.com/), and coming across some basic stuff I've completely missed before.

On a professional basis, I'm using keyboard shortcuts _all_ the time.  Whether it's snapping (`super`+`arrow key`), minimising open windows (`super` + `d`), or any of the myriad `ctrl` + `...` combos that are second nature to most users.  When it comes to the commandline however, I only knew one: `ctrl`+`c`. Whilst this has done me fine for the past ten years, there's far more to prompt shortcuts.  Although some of the below may have limited use-cases I have a new favourite way of clearing the prompt (`ctrl`+`l`).

| Combo            | Effect                                                                               |
| :--------------- | :----------------------------------------------------------------------------------- |
| `ctrl` + `l`     | clear screen (equivalent to the `clear` command)                                     |
| `ctrl` + `z`     | send job to background (equivalent to appending a `&` to a command )                 |
| `ctrl` + `d`     | Log out of the current session (equivalent to `exit` command)                        |
| `ctrl` + `a`     | Move the cursor to the beginning of the line (equivalent to pressing the `home` key) |
| `ctrl` + `u`     | delete backwards to the beginning of line                                            |
| `ctrl` + `k`     | delete forwards to the end of line                                                   |
| `ctrl` + `w`     | delete previous word (like `db` in `vi`)                                             |
| `ctrl` + `left`  | move back one word                                                                   |
| `ctrl` + `right` | move forwards one word                                                               |
| `ctrl` + `y`     | pastes the buffered output of `ctrl` + [`u`\|`k`\|`w`]                               |
| `ctrl` + `p`     | cycle through previous commands (similar to pressing the `up` arrow)                 |
| `ctrl` + `n`     | cycle through next commands (similar to pressing the `down` arrow)                   |
| `ctrl` + `r`     | reverse search history (like `history | grep <search term> | sort -r`)               |
| `ctrl` + `r`     | forward search history (like `history | grep <search term>`)                         |
| `ctrl` + `s`     | suspend output updating screen                                                       |
| `ctrl` + `q`     | resume output updating screen                                                        |
| `ctrl` +`x`,`e`  | open $EDITOR                                                                         |
