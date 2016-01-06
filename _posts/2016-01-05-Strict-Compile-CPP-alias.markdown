---
layout: post
title:  Strict Compile CPP alias
date:    2016-01-05
categories: code
synopsis: "a short script to compile cpp using strict rules and open the resulting executable"
---

I've been slowly working through Accelerated C++ over the past couple of weeks.  It's very good; there's loads of information densely packed into its 250-odd pages.  One thing that has frustrated me about working through the examples is having to retype the same things over-and over again to get the examples to successfully compile.

I appear not to be a lone in this, there are a couple of cpp compile shell scripts out there that do just that. This isn't radically different, though it will give the executable a name matching the source file, and will attempt to open the source file once the compilation is complete.

At present, the script only accepts a single argument of the file (including the full filepath).  This appears to be fine for my progress through the book so far, though I may end up revisiting this later on as I get onto the more complex exercises.

{% highlight bash %}
filepath="${1%/*}"
filename="${1##*/}"
output="${filename%.*}"
cd $filepath
g++ -ansi -pedantic-errors -Wall $filename -o $output
./$output
{% endhighlight %}

To use the above as an alias, save as a shell script, chmod it, and add an alias referencing it in your .zshrc.  My alias looks like:

{% highlight ash %}
alias compile='zsh ~/Documents/scripts/strictcompile.sh'
{% endhighlight %}
