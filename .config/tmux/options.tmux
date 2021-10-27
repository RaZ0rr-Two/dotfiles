
##########################
#  Options
###########################

#Plugins directory
set-environment -g TMUX_PLUGIN_MANAGER_PATH '$HOME/.config/tmux/plugins'

# use 256 xterm for pretty colors. This enables same colors from iTerm2 within tmux.
# This is recommended in neovim :healthcheck
set -g default-terminal "tmux-256color"
# set -ga terminal-overrides ",xterm-256color:Tc"

# No bells at all
set -g bell-action none

set -q -g status-utf8 on                  # expect UTF-8 (tmux < 2.2)
setw -q -g utf8 on

# use vim key bindings
#setw -g mode-keys vi

# disable mouse
set -g mouse on
unbind -n MouseDrag1Pane
unbind -Tcopy-mode MouseDrag1Pane

# Enable mouse control (clickable windows, panes, resizable panes)
# set -g mouse-select-window on
# set -g mouse-select-pane on
# set -g mouse-resize-pane on
# setw -g mode-mouse off
# set -g mouse-select-pane off
# set -g mouse-resize-pane off
# set -g mouse-select-window off

# Set the base index for windows to 1 instead of 0
set -g base-index 1

# Set the base index for panes to 1 instead of 0
set -g pane-base-index 1

#Don't rename windows automatically
set-option -g allow-rename off

# re-number windows when one is closed
set -g renumber-windows on

# Keys to toggle monitoring activity in a window and the synchronize-panes option
bind m set monitor-activity
bind y set synchronize-panes\; display 'synchronize-panes #{?synchronize-panes,on,off}'

# highlight window when it has new activity
setw -g monitor-activity on
# set -g visual-activity on

###############################################################
###### Set in tmux-sensible plugin
###############################################################

# address vim mode switching delay (http://superuser.com/a/252717/65504)
# set -s escape-time 0

# increase scrollback buffer size
# set -g history-limit 50000

# tmux messages are displayed for 4 seconds
# set -g display-time 4000

# refresh 'status-left' and 'status-right' more often
# set -g status-interval 5

# set only on OS X where it's required
# set -g default-command "reattach-to-user-namespace -l $SHELL"

# upgrade $TERM
# set -g default-terminal "screen-256color"

# emacs key bindings in tmux command prompt (prefix + :) are better than
# vi keys, even for vim users
# set -g status-keys emacs

# focus events enabled for terminals that support them
# set -g focus-events on

# super useful when using "grouped sessions" and multi-monitor setup
# setw -g aggressive-resize on

