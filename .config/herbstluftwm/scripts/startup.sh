#!/usr/bin/env bash

# Auto screen-locker
# xset s 600
xset s 300 600
betterlockscreen -u "$HOME/.local/share/lock.png" &
xss-lock -n dim-screen.sh -- betterlockscreen -l --blur 0.0 &
# xss-lock -n xscreensaver-command -activate -- betterlockscreen -l --blur 0.0 &

# feh --bg-fill $HOME/Pictures/Walls/Minimal/521028.png
feh --bg-fill $HOME/.local/share/wall.png

~/.conky/Mine/branch/ConkybooterBranch &

picom --experimental-backends &

# For getting root password dialog prompts when running application that require root priveleges
# /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/lxqt-policykit-agent &

~/.config/polybar/hlwmbar.sh &

sxhkd &
blueman-applet &
nm-applet &
