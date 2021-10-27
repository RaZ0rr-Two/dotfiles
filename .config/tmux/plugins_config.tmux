###########################
# Plugins Config
###########################

set -g @logging-path '$HOME/.config/tmux/logs'
set -g @resurrect-dir '$HOME/.config/tmux/resurrect'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-processes '"nv->nv +SLoad"'
###########################
# Prefix highlight plugin
###########################

set -g @prefix_highlight_fg '#ff0000' # default is 'colour231'
set -g @prefix_highlight_bg 'black'  # default is 'colour04'

set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=colour11,bg=black,bold' # default is 'fg=default,bg=yellow'
set -g @prefix_highlight_show_sync_mode 'on'
set -g @prefix_highlight_sync_mode_attr 'fg=#0000ff,bg=black' # default is 'fg=default,bg=yellow'

set -g @prefix_highlight_prefix_prompt 'Prefix'
set -g @prefix_highlight_copy_prompt 'Copy'
set -g @prefix_highlight_sync_prompt 'Sync'

# set -g @prefix_highlight_output_prefix '< '
# set -g @prefix_highlight_output_suffix ' >'

# set -g @prefix_highlight_empty_prompt '        '          # default is '' (empty char)
set -g @prefix_highlight_empty_attr 'fg=colour10,bg=colour235' # default is 'fg=default,bg=default'

set -g @prefix_highlight_empty_has_affixes 'on' # default is 'off'
set -g @prefix_highlight_empty_prompt 'Tmux'
# set -g @prefix_highlight_output_prefix '< '
# set -g @prefix_highlight_output_suffix ' >'
