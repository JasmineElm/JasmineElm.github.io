cd ~/Github/JasmineElm.github.io/_posts
echo "type the title of your post, followed by [ENTER]:"
read title
filename=${title// /_}
date=`date +%Y-%m-%d`
time=`date +"%T"
echo "---
layout: post
title:  ""$title ""
date:   " $date $time "
categories: writing
---



-- James" >> $date-$filename.markdown
sleep 2
atom $date-$filename.markdown:8`
