---
layout: post
title:  My conkyrc
date:    2016-01-06
categories: code
synopsis: "My current conky profile"
---

I recently installed <a href="http://bbs.archbang.org/">ArchBang</a> on my Thinkpad.  It's great; fast and light on a relatively old laptop.  I loved <a href="http://projects.tynsoe.org/en/geektool/">Geektool</a>  on OSX, so it was good to find out about <a href="https://github.com/brndnmtthws/conky/releases/tag/v1.10.1">conky</a>.  I find conky much more obvious to set up and use than geektool, thanks in no small part to the various tutorials dotted around various Linux forums. Without further ado, here's my conkyrc.  It's messy in that it includes a couple of scripts within the file itself rather than the cleaner approach of saving the scripts separately and referencing them from the conkyrc file.

{% highlight bash %}
alignment tr
double_buffer yes
gap_x 7
gap_y 7
uppercase no
override_utf8_locale yes
update_interval 1.0
draw_shades no
background
text_buffer_size 556
own_window_type normal
own_window_transparent no
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager
own_window_argb_visual yes
own_window_argb_value 0
minimum_size 280 754
maximum_width 280
cpu_avg_samples 2
net_avg_samples 1
use_xft yes
xftalpha 1.0
xftfont SourceCodePro-Semibold :size=12:style=bold

draw_graph_borders no

#
##########################################################################
############################  Colours ####################################
##########################################################################
#

default_color 839496 #color0
color3        123456
color2        ffeedd #red
color1        dc322f #red
color0        859900 #green




TEXT
#
##########################################################################
############################### CPU ######################################
##########################################################################
#
${font style=bold:size=16}${color3}CPU $hr${color }${font }
${alignr 2}${color2}${cpubar cpu0 20,120}${color}
${font style=bold:size=8}${voffset -26}${color}$running_processes/$processes processes${font}
${color2}${voffset -24}${alignr 5}$cpu%${color}
#${voffset 2}${color1}Load Avg (${color3}Min${color1}):${alignr 2}${color3}1: ${color}${loadavg 1}   ${color3}5: ${color}${loadavg 2}   ${color3}15: ${color}${loadavg 3}
${voffset 3}${color2}${top name 1}${alignr}${top cpu 1}%${color }
${top name 2}${alignr}${top cpu 2}%
${top name 3}${alignr}${top cpu 3}%
#${top name 4}${alignr}${top cpu 4}%
#${top name 5}${alignr}${top cpu 5}%
#
##########################################################################
############################### RAM ######################################
##########################################################################
#

${font style=bold:size=14}${color3}RAM $hr${color }${font }
${alignr 2}${membar 20,120}${color}
${color2}${voffset -23}${alignr}$memperc%${color}\
${voffset -20}${font style=bold:size=6}${voffset 2}${color}
Buffered: ${buffers}
Cached: ${cached}
${font}
${color2}${top_mem name 1}${alignr}${top_mem mem 1}%${color }
${top_mem name 2}${alignr}${top_mem mem 2}%
${top_mem name 3}${alignr}${top_mem mem 3}%
#${top_mem name 4}${alignr}${top_mem mem 4}%
#${top_mem name 5}${alignr}${top_mem mem 5}%

#
##########################################################################
########################### NETWORK ######################################
##########################################################################
#
${font style=bold:size=14}${color3}Network $hr${color }${font }
${voffset 5}${execi 60 iwconfig wlp3s0 |grep ESSID: | cut -d ' ' -f8 | awk -F'"' '{print $2}'} ${alignr 2}${wireless_link_bar 20, 120 wlp3s0}${color}
${color 000000} ${alignr 20}${voffset -24} Signal:${color}\
${color2}${alignr 5}${wireless_link_qual_perc wlp3s0}%${color}
${font style=bold:size=8}${voffset 7} ${color0}Down:${color}${font }${downspeed wlp3s0} ${font }${color0} $alignr${downspeedgraph wlp3s0 20, 120 000000 859900 -t -l }
${font style=bold:size=8}${voffset 3} ${color1}Up:${color}${font}${upspeed wlp3s0} ${color1} $alignr${upspeedgraph wlp3s0 20, 120 000000 dc322f -t -l}${color}
IP (Lan): $alignr${addr wlp3s0}
#IP (Public): $alignr${execi 600 curl ifconfig.me}
Total Down $alignr${totaldown wlp3s0}
Total Up   $alignr${totalup wlp3s0}

#
##########################################################################
########################## DISKS #########################################
##########################################################################
#
${font style=bold:size=14}${color3}Disks $hr${color }${font }
${color}ARCH${alignc}${color}${alignr}${color}${voffset 8}${fs_bar 20,120}${color}
${color2}${voffset -24}${alignr 5}$fs_free${color}
#
##########################################################################
########################## Battery #######################################
##########################################################################
#
${font style=bold:size=14}${color3}Battery$hr${color }${font }
${font style=bold:size=8}${battery_time} ${font }${voffset -2}${alignr}${battery_bar 20,120}
${alignr}${voffset -24}${battery_percent}%
${voffset -10}${font style=bold:size=8}remaining${font}

#
#
##########################################################################
############################# OTHER ######################################
##########################################################################
#
${font style=bold:size=14}${color3}Other $hr${color }${font }
${alignr}${execi 10800 pacman -Qu | wc -l}${font} updates available
uptime: ${alignr} ${uptime}
##########################################################################
############################## Other #####################################
##########################################################################
Volume:${alignc}${color1}${execi 1 if
[ `amixer get Master | grep Mono: | cut -d[ -f4 | egrep -o "[a-z]+"` == "off" ]; then
echo "mute"
fi
}${color}${alignr} ${execi 1 amixer get Master | grep Mono: | cut -d[ -f2 | egrep -o "[0-9]+"}%
CPU temp: ${alignr}${acpitemp}
${font style=bold:size=14}${color3}$hr${color }${font }
##########################################################################
########################## Date/Time #####################################
##########################################################################
${color2}${font style=bold:size=12}${execi 600
dayno=`date "+%_d"`
dayname=`date "+%A"`
month=`date "+%B"`
daynosuffix="th"
case $dayno in
  1 | 21 | 31)
  daynosuffix="st"
  ;;
  2 | 22)
  daynosuffix="nd"
  ;;
  3 | 23)
  daynosuffix="rd"
esac

echo $dayname $dayno$daynosuffix $month} ${alignr}${execi 1 date +"%H:%M"}
${font }

{% endhighlight %}

It's still very much a work in progress; I'd like to make some of the colour-use conditional (so the battery monitor will become red once the level falls below a certain value and so on), but for now, it is more than serviceable for my needs.

-- James
