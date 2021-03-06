---
layout: post
title: Micromontage in Sox
date: 2017-05-29T12:07:22.000Z
categories: sound
synopsis: Creating a micromontage using Sox
last-modified-date: '2021-06-12T16:39:34+01:00'

---

I've been re-reading Curtis Rodes' excellent [Microsound](https://mitpress.mit.edu/books/microsound) again recently. It's packed with all sorts of useful information, and is one of those books that I find myself coming back to time and time again.

In chapter 5, Roads discusses micromontage. Micromontage is a process of composing a sequence of sounds from one or more source files.  Whilst it may share some similarities with music concrete, it operates on a much finer scale.  In a micromontage, sounds are typically much shorter, often less than 100 milliseconds each. Despite working on a similar time-domain to granular synthesis, micromontage can afford a composer a much greater level of control over the choice and placement of sounds.  This control can come at a heavy cost. Manually slicing and mixing back hundreds or thousands of sounds is a process that requires both patience, and an ability to think at both the scale of the sound being placed, and the overall piece.

The below script attempts to create a dumb micro micromontage; it takes slices of an input sound file, and stitches them together into a single sound file.

The aesthetics of the resulting file can be somewhat uninspiring; the output file bears the hallmarks of the input file, due in main to the way in which the output file is constructed:

- The chosen duration range means that slices are (generally) perceptible as distinct sounds
- The method of stitching doesn't alter slices before stitching them together
- The method of stitching doesn't include the ability to stitch silence into the output file
- The montage has a single layer; slices sit next to one-another rather than on top of one-another
- The micromontage is made up of parts of a single file, rather than parts of multiple files

Nevertheless, the script is an interesting experiment in what can be done on the command-line using simple tools.

A sample of the output can be found [here](https://archive.org/details/MicroMontage)

```bash
#!/bin/zsh

# MICRO-MONTAGE #################
#	JL	17-05-17        #
#  Creates a montage of a given #
#    file see below for usage   #
#################################

 info='MICRO-MONTAGE\n-------------
Takes audio file, reorders slices of it to specified length
if not specified, outfile = "output.wav", length = 60 seconds

USAGE:
    $0 [infile] [outfile] [length(seconds)]'

if [ -z $1 ]; then
    echo $info
else
    infile=$1   #make the remaining code a little easier to read
    inLen=${$(((`soxi -D $infile`*1000)-1))%.*}
    if [ -z $2 ]
    then
        outfile=output.wav
    else
        outfile=$2
    fi

    if [ -z $3 ]
        then duration=60
    else
        case $3 in
        ''|*[!0-9]*) echo 'not an integer, using default value';
         duration=60 ;;
        *) duration=$3 ;;
        esac
    fi


    ##Variables!
    curSlice=0  #current slice, useful for
    curDur=0    #rolling duration of the output file
    temp=temp.wav


    while (( $(echo "$curDur < $duration" |bc -l) )); do
        currentfile=$curSlice.wav
        ##select a grain from the infile
        # range suggested by Roads.
        trima=`shuf -i 0-$inLen -n 1` ##arbitrary point in file
        # grain=`shuf -i 20-200 -n 1`
        grain=`shuf -i 0-$(($inLen/16)) -n 1`
        if (( (trima+grain) < inLen )) then;
          trimb=$((trima+grain))
        else
          trimb=$((trima-grain))
        fi

        ##WHICH IS LARGER TRIMA OR TRIMB?
        ##SMALLEST BECOMES START, LARGEST BECOMES FINISH
        if (( trima > trimb )); then
            grainEnd=`echo "scale=2;$trima/1000" |bc`
            grainStart=`echo "scale=2;$trimb/1000" |bc`
        else
            grainStart=`echo "scale=2;$trima/1000" |bc`
            grainEnd=`echo "scale=2;$trimb/1000" |bc`
        fi
        grainLen=$((grainEnd-grainStart))
        sox $infile $currentfile trim $grainStart $grainLen

        echo $curSlice $grainStart $grainLen
        if [ $curSlice = 0 ]; then
            cp $currentfile $outfile
        else
            sox $temp $currentfile $outfile
        fi

        cp $outfile $temp
        rm $currentfile
        ((curSlice=curSlice+1))
        curDur=`soxi -D $outfile`
    done
fi
rm $temp
```
