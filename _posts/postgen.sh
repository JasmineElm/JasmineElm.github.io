cd ~/Github/JasmineElm.github.io/_posts
echo "type the title of your post, followed by [ENTER]:"
read title
date=`date +%Y-%m-%d`
time=`date +"%T"
echo "---
layout: post
title:  ""$title ""
date:   " $date $time "
categories: writing
---" >> $date-$title.markdown
sleep 2
open $date-$title.markdown`
