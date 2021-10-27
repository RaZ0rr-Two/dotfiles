# Run command/application and choose paths/files with fzf.                      
# Always return control of the terminal to user (e.g. when opening GUIs).       
# The full command that was used will appear in your history just like any      
# other (N.B. to achieve this I write the shell's active history to             
# ~/.bash_history)                                                                
#                                                                               
# Usage:
# f cd [OPTION]... (hit enter, choose path)
# f cat [OPTION]... (hit enter, choose files)
# f vim [OPTION]... (hit enter, choose files)
# f vlc [OPTION]... (hit enter, choose files)

#ft() {
#    # Store the program
#    program="$1"
#
#    # Remove first argument off the list
#    shift
#
#    # Store option flags with separating spaces, or just set as single space
#    options="$@"
#    if [ -z "${options}" ]; then
#        options=" "
#    else
#        options=" $options "
#    fi
#
#    # Store the arguments from fzf
#    arguments=($(fzf --multi))
#
#    # If no arguments passed (e.g. if Esc pressed), return to terminal
#    if [ -z "${arguments}" ]; then
#        return 1
#    fi
#
#    # We want the command to show up in our bash history, so write the shell's
#    # active history to ~/.bash_history. Then we'll also add the command from
#    # fzf, then we'll load it all back into the shell's active history
#    history -w
#
#    # ADD A REPEATABLE COMMAND TO THE BASH HISTORY ############################
#    # Store the arguments in a temporary file for sanitising before being
#    # entered into bash history
#    : > $HOME/tmp/fzf_tmp
#    for file in "${arguments[@]}"; do
#        echo "$file" >> $HOME/tmp/fzf_tmp
#    done
#
#    # Put all input arguments on one line and sanitise the command by putting
#    # single quotes around each argument, also first put an extra single quote
#    # next to any pre-existing single quotes in the raw argument
#    sed -i "s/'/''/g; s/.*/'&'/g; s/\n//g" $HOME/tmp/fzf_tmp
#
#    # If the program is on the GUI list, add a '&' to the command history
#    if [[ "$program" =~ ^(nautilus|zathura|evince|vlc|eog|kolourpaint)$ ]]; then
#        sed -i '${s/$/ \&/}' $HOME/tmp/fzf_tmp
#    fi
#
#    # Grab the sanitised arguments
#    arguments="$(cat $HOME/tmp/fzf_tmp)"
#
#    # Add the command with the sanitised arguments to our .bash_history
#    echo $program$options$arguments >> ~/.bash_history
#
#    # Reload the ~/.bash_history into the shell's active history
#    history -r
#
#    # EXECUTE THE LAST COMMAND IN ~/.bash_history #############################
#    fc -s -1
#
#    # Clean up temporary variables
#    rm $HOME/tmp/fzf_tmp
#}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

fda() {
  local dir
  dir=$(fdfind --type d --color=never --hidden --exclude .git 2> /dev/null | fzf +m) && cd "$dir"
}
bind -x '"\ev":fda'

#fdp ()
#{
#        builtin typeset READLINE_LINE_NEW="$(
#                command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) \
#                        -prune \
#                        -o -type f -print \
#                        -o -type d -print \
#                        -o -type l -print 2>/dev/null \
#                | command sed 1d \
#                | command cut -b3- \
#                | env fzf -m
#        )"
#
#        if
#                [[ -n $READLINE_LINE_NEW ]]
#        then
#                builtin bind '"\ex": redraw-current-line'
#                builtin bind '"\ez": magic-space'
#                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
#                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
#        else
#                builtin bind '"\ex":'
#                builtin bind '"\ez":'
#        fi
#}
#
#builtin bind -x '"\C-x1": fdp'
#builtin bind '"\C-t": "\C-x1\ez\ex"'


#fdp()
#{
#        local filepath1=$PWD
#        cd ~
#        builtin typeset READLINE_LINE_NEW="$(
#                fdfind --type d --color=never --hidden \
#                | env fzf -m  --preview 'tree -C {} | head -100' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse
#        )"
#        cd "$filepath1"
#        if
#                [[ -n $READLINE_LINE_NEW ]]
#        then
#                builtin bind '"\er": redraw-current-line'
#                builtin bind '"\e^": magic-space'
#                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
#                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
#        else
#                builtin bind '"\er":'
#                builtin bind '"\e^":'
#        fi
#}
#
#builtin bind -x '"\C-x1": fdp'
#builtin bind '"\et": "\C-x1\e^\er"'
#builtin bind '"\et": "\C-x1"'
#
#ffp()
#{
#        local filepath2=$PWD
#        cd ~
#        builtin typeset READLINE_LINE_NEW="$(
#                fdfind --type f --color=never --hidden \
#                | env fzf -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse
#
#        )"
#        cd "$filepath2"
#        if
#                [[ -n $READLINE_LINE_NEW ]]
#        then
#                builtin bind '"\eq1": redraw-current-line'
#                builtin bind '"\eq2": magic-space'
#                READLINE_LINE=${READLINE_LINE_NEW}
#                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
#        else
#                builtin bind '"\eq1":'
#                builtin bind '"\eq2":'
#        fi
#}
#
#builtin bind -x '"\C-x2": ffp'
#builtin bind '"\C-f": "\C-x2\eq2\eq1"'

#bind -m emacs-standard -x '"\C-f": ffp'
#bind -m vi-command -x '"\C-f": ffp'
#bind -m vi-insert -x '"\C-f": ffp'


