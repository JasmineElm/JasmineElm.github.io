---
layout: post
title:  Bash Script to generate a post header
date:    2015-05-27 23:13:22
categories: code
synopsis: "bash script to generate a Markdown file suitable for Jekyll"
---

I'm a great fan of simple scripts.  At their best, a good script can take the hassle out of repetitively navigating through a file structure, creating a new file, and opening it in your preferred editor.

Github pages using Jekyll (what this site is built on) is a prime candidate for a script; to create a new post, one simply needs to add a new file with a standard header into a default folder.  The filename should have the date followed by the post title without white space.  as an example, this post, for example, has the following filename:

{% highlight html %}
    2015-05-27-Bash-Script-to-Generate-a-Post-Header.markdown
{% endhighlight %}

The format of the header is something like this:

{% highlight html %}
layout: *layout_type*
title:  *a suitable title*
Date: *YYYY-MM-DD HH:MM:SS*
categories: *declare categories here*
{% endhighlight %}


Pretty simple huh?  Using a couple of built in shell commands, you can build a script that will create the header, name the file correctly, and open the resulting file in your chosen text editor.

The following script does just that. You'll need to alter a couple of lines to match your requirements. If nothing else, you should enter your specific directory path into the first line.  

{% highlight bash %}
echo "type the title of your post, followed by [ENTER]:"
read title
date=`date +%Y-%m-%d`
time=`date +"%T"`
echo "---
layout: post
title:  ""$title ""
date:   " $date $time "
categories: writing
synopsis: "A sentence of text"
---">> $date-$title.markdown
sleep 2
atom $date-$title.markdown
{% endhighlight %}

This isn't perfect, but may provide a starting point if you're looking to do something similar.



Tomorrow, I'll look at making a script to start Jekyll so you can view the post in real time as you are editing it.

[edited to make suitable for Linux]
--
James
