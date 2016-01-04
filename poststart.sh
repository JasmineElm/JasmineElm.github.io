cd /home/james/Documents/git/JasmineElm.github.io
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
