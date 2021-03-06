# Setup fzf
# ---------
#if [[ ! "$PATH" == *${MY_FZF_PATH}/bin* ]]; then
 # export PATH="${PATH:+${PATH}:}${MY_FZF_PATH}/bin"
#fi

# if [ -f ~/.fzf_test.bash ]; then
#     source ~/.fzf_test.bash
# fi

# Auto-completion
#---------------------------------------------------------------------------------
if [[ $- == *i* ]] 
then
	if [[ -d "/usr/share/fzf" ]] ; then
		source "/usr/share/fzf/completion.bash" 2> /dev/null
	elif [[ -d "${MY_FZF_PATH}/shell" ]] ; then
		source "${MY_FZF_PATH}/shell/completion.bash" 2> /dev/null
	fi
fi

# Key bindings
#---------------------------------------------------------------------------------
if [[ -d "/usr/share/fzf" ]] ; then
	source "/usr/share/fzf/key-bindings.bash" 2> /dev/null
elif [[ -d "${MY_FZF_PATH}/shell" ]] ; then
	source "${MY_FZF_PATH}/shell/key-bindings.bash"
fi

#---------------------------------------------------------------------------------
#Custom fzf settings (keybindings & functions)
#---------------------------------------------------------------------------------

FZF_FILE_COMMAND="fd . --type f --color=never --hidden --follow --exclude .git --exclude node_modules"
FZF_FOLDER_COMMAND="fd . --type d --color=never --hidden --follow --exclude .git --exclude node_modules"
FZF_RG_COMMAND='rg --hidden --follow --glob "!.git" --files'

FZF_FILE_PREVIEW=(--preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-z:ignore' --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)')
FZF_FILE_WINDOW=(--preview-window 'down,50%,+{2}+3/3,~3')

FZF_FOLDER_PREVIEW=(--preview 'tree -C {} | head -100' --bind 'ctrl-z:ignore' --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)')
FZF_FOLDER_WINDOW=(--preview-window 'down,50%,~1')

export FZF_DEFAULT_COMMAND=$FZF_RG_COMMAND
export FZF_DEFAULT_OPTS='--height=80% --layout=reverse --border'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

export FZF_CTRL_T_COMMAND=$FZF_FILE_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}' --bind=ctrl-z:ignore --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)' ${FZF_FILE_WINDOW[@]}"

export FZF_ALT_C_COMMAND=$FZF_FOLDER_COMMAND
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100' --bind=ctrl-z:ignore --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)' ${FZF_FOLDER_WINDOW[@]}"

# CTRL-T + CTRL-T - Paste the selected file path(s) into the command line
#---------------------------------------------------------------------------------
__sff__() {
  local cmd="${FZF_FILE_COMMAND} $HOME"
  eval "$cmd" | fzf-tmux -m "${FZF_FILE_PREVIEW[@]}" ${FZF_FILE_WINDOW[@]} "$@" | while read -r item; do
    printf '%q ' "$item"
  done
  echo
}

__sffw__() {
  local selected="$(__sff__)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
bind -x '"\C-t\C-t":"__sffw__"'
# bind -x '"__FileSeach__": fzf-file-widget'
# bind '"\C-t":"__FileSeach__"'
# bind -x '"__HomeFileSearch__":"__sffw__"'
# bind '"\C-t\C-t":"__HomeFileSearch__"'

# alt-F - Paste the selected folder path(s) into the command line
#---------------------------------------------------------------------------------
__sdf__() {
	local cmd="${FZF_FOLDER_COMMAND}"
  eval "$cmd" |
  fzf-tmux -m "${FZF_FOLDER_PREVIEW[@]}" ${FZF_FOLDER_WINDOW[@]} "$@" | while read -r item; do 
		printf '%q ' "$item"
  done
	echo
}

__sdfw__() {
  local selected="$(__sdf__)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
bind -m emacs-standard -x '"\ef": "__sdfw__"'
# bind -m emacs-standard -x '"__FolderSearch__": __sdfw__'
# bind -m emacs-standard '"\ef": "__FolderSearch__"'

# alt-F+alt-F - Paste the selected folder path(s) from $HOME into the command line
#---------------------------------------------------------------------------------
__sdhf__() {
	local cmd="${FZF_FOLDER_COMMAND} $HOME"
  eval "$cmd" |
  fzf-tmux -m "${FZF_FOLDER_PREVIEW[@]}" ${FZF_FOLDER_WINDOW[@]} "$@" | while read -r item; do 
		printf '%q ' "$item"
  done
	echo
}

__sdhfw__() {
  local selected="$(__sdhf__)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

bind -m emacs-standard -x '"\ef\ef": __sdhfw__'
# bind -m vi-command -x '"\ef\ef": __sdhfw__'
# bind -m vi-insert -x '"\ef\ef": __sdhfw__'

# (ALT-c)+(Alt-c) - cd into the selected directory from anywhere
#---------------------------------------------------------------------------------
__cda__() {
  local cmd dir
  cmd="${FZF_FOLDER_COMMAND} $HOME"
	dir=$(eval "($cmd)" | fzf-tmux -m "${FZF_FOLDER_PREVIEW[@]}" ${FZF_FOLDER_WINDOW[@]}) && printf 'cd -- %q' "$dir"
}
# Bind cda() to Alt a
bind -m emacs-standard '"\ec\ec": " \C-b\C-k \C-u`__cda__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
# bind -m vi-command '"\ec\ec": "\C-z\ec\ec\C-z"'
# bind -m vi-insert '"\ec\ec": "\C-z\ec\ec\C-z"'
#bind -x '"\ev":cda'


# cdf - cd into the directory of the selected file
#---------------------------------------------------------------------------------
__cdf__() {
   local file
   local dir
	 local cmd
	 # cmd="${some_command:-"command fd . $HOME --type f --color=never --follow --hidden 2> /dev/null "}"
	 # file=$(eval "($cmd)" | fzf-tmux +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
	 file=$(fzf-tmux +m -q ${FZF_FILE_WINDOW[@]} "$1") && dir=$(dirname "$file") && cd "$dir"
}
# bind -m emacs-standard -x '"\eg": cdf'
# bind -m vi-command -x '"\eg": cdf'
# bind -m vi-insert -x '"\eg": cdf'
bind '"\ecf": "__cdf__\n"'

# Open files from current directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
onv() {
  IFS=$'\n' files=($(fd --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf-tmux --query="$1" --multi ${FZF_FILE_WINDOW[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview'))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Open files from $HOME directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
anv() {
  IFS=$'\n' files=($(fd . $HOME --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf-tmux --query="$1" --multi ${FZF_FILE_WINDOW[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview'))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

#ROFI replacement
#---------------------------------------------------------------------------------
 bind '"\efr":"xterm -T fzf-nova -geometry 90x25+350+200 -fs 16 -e ~/.config/fzf_nova/fzf-nova\n"'

# Use fpfr to generate the list for directory completion using fdfind
#---------------------------------------------------------------------------------
fpfr() {
  fd --hidden --type f --follow --exclude ".git" --exclude node_modules . "$1"
}

# Use dpfr to generate the list for directory completion using fdfind
#---------------------------------------------------------------------------------
dpfr() {
  fd --type d --hidden --follow --exclude ".git" --exclude node_modules . "$1"
}

# Interactive search.
# Usage: `irgf` or `irgf <folder>`.
if [ -f ~/RgIntrFzf ]; then
    chmod +x ~/RgIntrFzf
    alias irgf='~/RgIntrFzf'
fi

# Interactive search.
# Usage: `irgf` or `irgf <folder>`.
if [ -f ~/NvRgIntrFzf ]; then
    chmod +x ~/NvRgIntrFzf
    alias nvfg='~/NvRgIntrFzf'
fi

# TMux sessoins create or select
#---------------------------------------------------------------------------------
fzts() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# End ---------------------------------------------------------------------------------------------
