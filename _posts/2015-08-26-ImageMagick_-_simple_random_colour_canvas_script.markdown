---
layout: post
title:  ImageMagick - simple random colour canvas script
date:    2015-08-26
categories: code
---

Creates a 10x10 px canvas of noise, chooses a random pixel from it, creates a 500x500 px canvas of that colour.  The use of random on an essentially random image (noise). is probably overkill, though I suspect neither algorithm is truly "random" so the additional code won't hurt



    px=`jot -r 1 1 10`
    py=`jot -r 1 1 10`
    convert -size 10x10 xc: +noise Random seed.png
    convert seed.png -fx 'p{'$px','$py'}' -scale 5000% colorChoice.png
    rm seed.png


-- James
