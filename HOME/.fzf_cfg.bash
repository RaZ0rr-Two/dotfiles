# Setup fzf
# ---------
if [[ ! "$PATH" == *${MY_FZF_PATH}/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${MY_FZF_PATH}/bin"
fi

if [ -f ~/.fzf_test.bash ]; then
    source ~/.fzf_test.bash
fi

# Auto-completion
#---------------------------------------------------------------------------------
[[ $- == *i* ]] && source "${MY_FZF_PATH}/shell/completion.bash" 2> /dev/null

# Key bindings
#---------------------------------------------------------------------------------
source "${MY_FZF_PATH}/shell/key-bindings.bash"

FZF_FILE_COMMAND="fdfind . --type f --color=never --hidden --follow --exclude .git --exclude node_modules"
FZF_FOLDER_COMMAND="fdfind . --type d --color=never --hidden --follow --exclude .git --exclude node_modules"
FZF_RG_COMMAND='rg --hidden --follow --no-ignore-vcs --files'

FZF_FILE_PREVIEW=(--preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-z:ignore' --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)')
FZF_FILE_WINDOW=(--preview-window 'down,50%,+{2}+3/3,~3')

FZF_FOLDER_PREVIEW=(--preview 'tree -C {} | head -100' --bind 'ctrl-z:ignore' --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)')
FZF_FOLDER_WINDOW=(--preview-window 'down,50%,~1')

export FZF_DEFAULT_COMMAND=$FZF_RG_COMMAND
export FZF_DEFAULT_OPTS='--height=80% --layout=reverse --border --info=inline'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

export FZF_CTRL_T_COMMAND=$FZF_FILE_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}' --bind=ctrl-z:ignore --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)' ${FZF_FILE_WINDOW[@]}"

export FZF_ALT_C_COMMAND=$FZF_FOLDER_COMMAND
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100' --bind=ctrl-z:ignore --bind 'ctrl-space:toggle-preview,ctrl-o:execute(xdg-open {} 2> /dev/null &)' ${FZF_FOLDER_WINDOW[@]}"

#---------------------------------------------------------------------------------
#Custom fzf keybindings & functions
#---------------------------------------------------------------------------------

# CTRL-T + CTRL-T - Paste the selected file path(s) into the command line
#---------------------------------------------------------------------------------
sff() {
  $FZF_FILE_COMMAND $HOME |
  fzf-tmux -m "${FZF_FILE_PREVIEW[@]}" ${FZF_FILE_WINDOW[@]} "$@" | while read -r item; do 
		printf '%q ' "$item"
  done
	echo
}

sffw() {
  local selected="$(sff)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
# bind -m emacs-standard -x '"FileSearch": fzf-file-widget'
# bind -m emacs-standard '"\C-t": "FileSearch"'
bind -m emacs-standard -x '"HomeFileSearch": sffw'
bind -m emacs-standard '"\C-t\C-t": "HomeFileSearch"'
# bind -m emacs-standard '"\C-t\C-t": "sffw\n"'
# bind -m vi-command -x '"\C-tt": sffw'
# bind -m vi-insert -x '"\C-tt": sffw'

# alt-F - Paste the selected folder path(s) into the command line
#---------------------------------------------------------------------------------
sdf() {
  $FZF_FOLDER_COMMAND |
  fzf-tmux -m "${FZF_FOLDER_PREVIEW[@]}" ${FZF_FOLDER_WINDOW[@]} "$@" | while read -r item; do 
		printf '%q ' "$item"
  done
	echo
}

sdfw() {
  local selected="$(sdf)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
bind -m emacs-standard -x '"FolderSearch": sdfw'
bind -m emacs-standard '"\ef": "FolderSearch"'
# bind '"\ef": "sdfw\n"'
# bind '"\ef":"\C-b\C-k \C-u`sdfw`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
# bind -m vi-command -x '"\ef": sdfw'
# bind -m vi-insert -x '"\ef": sdfw'

# alt-F+alt-F - Paste the selected folder path(s) from $HOME into the command line
#---------------------------------------------------------------------------------
sdhf() {
  $FZF_FOLDER_COMMAND $HOME |
  fzf-tmux -m "${FZF_FOLDER_PREVIEW[@]}" ${FZF_FOLDER_WINDOW[@]} "$@" | while read -r item; do 
		printf '%q ' "$item"
  done
	echo
}

sdhfw() {
  local selected="$(sdhf)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

bind -m emacs-standard -x '"\ef\ef": sdhfw'
bind -m vi-command -x '"\ef\ef": sdhfw'
bind -m vi-insert -x '"\ef\ef": sdhfw'

# (ALT-c)+(Alt-c) - cd into the selected directory from anywhere
#---------------------------------------------------------------------------------
cda() {
  local cmd dir
  cmd="${FZF_FOLDER_COMMAND} $HOME"
	dir=$(eval "($cmd)" | fzf-tmux -m "${FZF_FOLDER_PREVIEW[@]}" ${FZF_FOLDER_WINDOW[@]} && printf 'cd %q' "$dir")
}
# Bind cda() to Alt a
bind -m emacs-standard '"\ec\ec": " \C-b\C-k \C-u`cda`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind -m vi-command '"\ec\ec": "\C-z\ec\ec\C-z"'
bind -m vi-insert '"\ec\ec": "\C-z\ec\ec\C-z"'
#bind -x '"\ev":cda'

# cdf - cd into the directory of the selected file
#---------------------------------------------------------------------------------
cdf() {
   local file
   local dir
	 local cmd
	 # cmd="${some_command:-"command fdfind . $HOME --type f --color=never --follow --hidden 2> /dev/null "}"
	 # file=$(eval "($cmd)" | fzf-tmux +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
	 file=$(fzf-tmux +m -q ${FZF_FILE_WINDOW[@]} "$1") && dir=$(dirname "$file") && cd "$dir"
}
# bind -m emacs-standard -x '"\eg": cdf'
# bind -m vi-command -x '"\eg": cdf'
# bind -m vi-insert -x '"\eg": cdf'
bind '"\ecf": "cdf\n"'

# Open files from current directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
onv() {
  IFS=$'\n' files=($(fdfind --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf-tmux --query="$1" --multi ${FZF_FILE_WINDOW[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Open files from $HOME directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
anv() {
  IFS=$'\n' files=($(fdfind . $HOME --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf-tmux --query="$1" --multi ${FZF_FILE_WINDOW[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

#ROFI replacement
#---------------------------------------------------------------------------------
 bind '"\efr":"xterm -T fzf-nova -geometry 90x25+350+200 -fs 16 -e ~/.config/fzf_nova/fzf-nova\n"'

# Use fpfr to generate the list for directory completion using fdfind
#---------------------------------------------------------------------------------
fpfr() {
  fdfind --hidden --type f --follow --exclude ".git" --exclude node_modules . "$1"
}

# Use dpfr to generate the list for directory completion using fdfind
#---------------------------------------------------------------------------------
dpfr() {
  fdfind --type d --hidden --follow --exclude ".git" --exclude node_modules . "$1"
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
