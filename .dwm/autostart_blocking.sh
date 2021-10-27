
feh --bg-fill $HOME/Pictures/Walls/Minimal/521028.png

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit
# Launch Polybar, using default config location ~/.config/polybar/config
# polybar main 2>&1 | tee -a /tmp/polybar.log & disown
~/.config/polybar/dwmbar.sh
~/.conky/Mine/Conkybooter
echo "Polybar launched..."
