#!/usr/bin/env bash

# feh --bg-fill $HOME/Pictures/Walls/Minimal/521028.png
feh --bg-fill $HOME/Pictures/Walls/736398-anime-wallpaper-hd.jpg

~/.conky/Mine/ConkybooterHLWM &

# For getting root password dialog prompts when running application that require root priveleges
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

~/.config/polybar/hlwmbar.sh &

sxhkd &
blueman-applet &
nm-applet &

