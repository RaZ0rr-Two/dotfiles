#!/usr/bin/env bash

feh --bg-fill $HOME/Pictures/Walls/Minimal/521028.png

~/.conky/Mine/ConkybooterHLWM &

# For getting root password dialog prompts when running application that require root priveleges
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

sxhkd &
blueman-applet &
NetworkManager &

