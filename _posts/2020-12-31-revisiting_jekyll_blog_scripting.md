---
layout: post
title: Revisiting Jekyll Blog Scripting
date: 2020-12-31T19:44:07.000Z
categories: writing
synopsis: A lot has changed since I last thought about scripting blog posts...
last-modified-date: '2021-06-12T16:40:00+01:00'

---

It's nearly five years since I first started blogging using Jekyll.  Although I haven't exactly been prolific in that time, I have found that my [earlier]({{site.url}}code/2015/05/28/script-to-generate-posts.html) [attempts]({{site.url}}writing/2015/05/28/Script-to-start-Jekyll-Service.html)  at scripting are too brittle to be portable.  every time I try to use them somewhere new, I end up manually bodging a fix that rarely finds it's way back to the original script.

Rather than polish the current rat's nest of scripting and aliases, I wanted a single solution that can be dropped into any shell, so I can use it anywhere, whether it is Termux on my phone, WSL, an old Macintosh, or Linux.

Over the past five years, my tool choices have changed.  Rather than using Atom to write markdown I now write almost exclusively in [vim]({{site.url}}code/2020/05/29/keeping_a_journal_in_vim.html).  Similarly, my increasing comfort on the command line means I am better able to figure out a way of starting a Jekyll server _at the same time, and in the same shell_ as writing the blog post itself.

Running Jekyll alongside Vi could be done in a number of ways; `forking` a shell, making the vim process run in a sub-shell, a different session, or using the `! syntax` to run Jekyll _within_ vim itself.  Whilst any of these would achieve the broad aims of having two processes running simultaneously, I couldn't find a solution to trigger both with minimal effort.  In the end, the solution was quite simple; `tmux`.  A tmux session with both processes can be triggered from a single command.  By sourcing this command at the point the shell loads, I can easily start writing without trying to remember what sequence of events I need to trigger.

## The Script

this script is stored in ~/.shell_functions which is sourced in my `~/.bashrc`.  There's no reason that you couldn't have the script within your `~/.bashrc`; I only have it in a separate file to make it easier to maintain.

```bash
# New Blog post
## need to `export $BLOG_DIR` in ~/.bashrc

jekserve() {
  xdg-open http://127.0.0.1:4000/ &
  cd $BLOG_DIR../
  bundle exec jekyll serve
}

create_post() {
  cd $BLOG_DIR
  title="$*";  dte=`date +%Y-%m-%d`;  tme=`date +"%T"`
  safe_title=$(echo $title |sed 's/ /_/g'|  tr '[:upper:]' '[:lower:]')
  echo -e "---\nlayout: post\ntitle:  ""$title""\ndate:   " $dte $tme "\ncategories: writing\nsynopsis: "change me"\n---">> $dte-$safe_title.md
  vi $dte-$safe_title.md
}

nbp() {
  post_title=$*
  echo $post_title
  tmux new-session -d
  tmux split-window -v
  tmux resize-pane -D 10
  tmux send -t 0:0.1 "jekserve" C-m
  tmux send -t 0:0.0 "create_post $post_title" C-m
  tmux select-pane -U
  tmux -2 attach-session -d
}
```

Splitting the script into three functions should make it easier to maintain/debug.  To write a new blog post I simply now need to `nbp A Blog Post Title`, and start writing straight away.
