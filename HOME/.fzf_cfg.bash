# Setup fzf
# ---------
if [[ ! "$PATH" == *${MY_FZF_PATH}/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${MY_FZF_PATH}/bin"
fi

if [ -f ~/.fzf_test.bash ]; then
    source ~/.fzf_test.bash
fi

# Auto-completion

# ---------------
[[ $- == *i* ]] && source "${MY_FZF_PATH}/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "${MY_FZF_PATH}/shell/key-bindings.bash"

previewFzfFile=(--preview-window 'down,50%,+{2}+3/3,~3')
previewFzfFolder=(--preview-window 'down,50%,~1')

export FZF_CTRL_T_COMMAND='fdfind --type f --color=never --follow --hidden --exclude .git --exclude node_modules'
export FZF_CTRL_T_OPTS="-m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=90% ${previewFzfFile[@]}"

export FZF_ALT_C_COMMAND='fdfind --type d . --color=never --hidden --follow --exclude .git --exclude node_modules '
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=90% ${previewFzfFolder[@]}"

export FZF_DEFAULT_COMMAND='rg --hidden --follow --no-ignore-vcs --files' 
export FZF_DEFAULT_OPTS='-m --height=80% --layout=reverse'

#---------------------------------------------------------------------------------
#Custom fzf keybindings & functions
#---------------------------------------------------------------------------------

# CTRL-T + CTRL-T - Paste the selected file path(s) into the command line
#---------------------------------------------------------------------------------
sff() {
  fdfind . $HOME --type f --color=never --hidden --follow --exclude .git --exclude node_modules |
  fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' ${previewFzfFile[@]} --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse "$@" | while read -r item; do 
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
  fdfind --type d --color=never --hidden --follow --exclude .git --exclude node_modules |
  fzf-tmux -m --preview 'tree -C {} | head -200' ${previewFzfFolder[@]} --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse "$@" | while read -r item; do 
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
  fdfind . $HOME --type d --color=never --hidden --follow --exclude .git --exclude node_modules |
  fzf-tmux -m --preview 'tree -C {} | head -200' ${previewFzfFolder[@]} --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse "$@" | while read -r item; do 
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

# #Print selection(s) of folders to terminal on pressing Alt-f
# shdf() {
#   fdfind . $HOME --type d --color=never --hidden --follow --exclude .git |
#   fzf-tmux -m --preview 'tree -C {} | head -100' --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse "$@" | while read -r item; do 
# 		printf '%q ' "$item"
#   done
# 	echo
# }

# shdfw() {
#   local selected="$(sdf)"
#   READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
#   READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
# }

# bind -m emacs-standard -x '"\efh": shdfw'
# bind -m vi-command -x '"\efh": shdfw'
# bind -m vi-insert -x '"\efh": shdfw'

# Fzf-apt
# Usage: fzf-apt [apt flags / options] E.g.:
#     fzf-apt install
#     fzf-apt remove
# if [ -f ~/fzf-apt ]; then
#     chmod +x ~/fzf-apt
#     alias fapt='~/fzf-apt'
# fi

# (ALT-c)+(Alt-c) - cd into the selected directory from anywhere
#---------------------------------------------------------------------------------
cda() {
  local cmd dir
  cmd="${some_command:-"command fdfind . $HOME --type d --color=never --follow --hidden --exclude .git --exclude node_modules 2> /dev/null "}"
	dir=$(eval "($cmd)" | fzf-tmux --preview 'tree -C {} | head -200' ${previewFzfFolder[@]} --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse ) && printf 'cd %q' "$dir"
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
	 file=$(fzf-tmux +m -q ${previewFzfFile[@]} "$1") && dir=$(dirname "$file") && cd "$dir"
}
# bind -m emacs-standard -x '"\eg": cdf'
# bind -m vi-command -x '"\eg": cdf'
# bind -m vi-insert -x '"\eg": cdf'
bind '"\ecf": "cdf\n"'

# Open files from current directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
onv() {
  IFS=$'\n' files=($(fdfind --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf-tmux --query="$1" --multi ${previewFzfFile[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# onv() {
#   local files
#   if [[ -n $files ]]
#   then
#      nv -- $files
#      echo $(echo $files[@] | awk 'BEGIN{ORS=" "};{print $0}')
#   fi
# }
# onv() {
#   IFS=$'\n' out=("$( fdfind . --type f --follow --color=never --hidden | fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#   key=$(head -1 <<< "$out")
#   file=$(head -2 <<< "$out" | tail -1)
#   if [ -n "$file" ]; then
#     [ "$key" = ctrl-o ] && open "$file" || nv "$file"
#   fi
# }

# Open files from $HOME directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
anv() {
  IFS=$'\n' files=($(fdfind . $HOME --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf-tmux --query="$1" --multi ${previewFzfFile[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'f2:execute(xdg-open {} 2> /dev/null &),ctrl-space:toggle-preview' --height=80% --layout=reverse))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# anv() {
#     filepath=$PWD
#     cd
#     local files

#     files=(${(f)"$(fdfind --type f --color=never --hidden --follow | fzf -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse)"})

#     if [[ -n $files ]]
#     then
# 	nv -- $files
# 	echo $(echo $files[@] | awk 'BEGIN{ORS=" "};{print $0}')
#     fi
#     cd $filepath
# }
# anv() {
#   #local filepath
#   #filepath=$PWD
#   #cd ~
#   IFS=$'\n' out=("$( fdfind . $HOME --type f --follow --color=never --hidden | fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#   key=$(head -1 <<< "$out")
#   file=$(head -2 <<< "$out" | tail -1)
#   if [ -n "$file" ]; then
#     [ "$key" = ctrl-o ] && open "$file" || nv "$file"
#   fi
#   #cd "$filepath"
# }

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

#ALTERNATE VERSIONS
#Print selection(s) of folders to terminal on pressing Alt-f
#sdff() {
#  fdfind --type d --color=never --hidden --follow --exclude .git . $HOME |
#  fzf-tmux -m --preview 'tree -C {} | head -100' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse | 
#	sed 's/.* -> //'
#}
#
#if [[ $- =~ i ]]; then
#  bind '"\er": redraw-current-line'
#  bind '"\ef": "$(sdff)\e\C-e\er"'
#  #bind '"\C-g\C-f": "$(sff)\e\C-e\er"'
#fi
#
##Print selection(s) of files to terminal on pressing Ctrl-f
#sfff() {
#  fdfind --type f --color=never --hidden --follow --exclude .git . $HOME |
#  fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse | 
#	sed 's/.* -> //'
#}
#
#if [[ $- =~ i ]]; then
#  bind '"\er": redraw-current-line'
#  bind '"\C-f": "$(sfff)\e\C-e\er"'
#  #bind '"\C-g\C-f": "$(sff)\e\C-e\er"'
#fi

#anv() {
#  #local filepath
#  #filepath=$PWD
#  #cd ~
#  IFS=$'\n' out=("$( fdfind . $HOME --type f --color=never --hidden | fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#  key=$(head -1 <<< "$out")
#  file=$(head -2 <<< "$out" | tail -1)
#  if [ -n "$file" ]; then
#    [ "$key" = ctrl-o ] && open "$file" || nv "$file"
#  fi
#  #cd "$filepath"
#}
#
#onv() {
#  IFS=$'\n' out=("$( fdfind . --type f --color=never --hidden | fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#  key=$(head -1 <<< "$out")
#  file=$(head -2 <<< "$out" | tail -1)
#  if [ -n "$file" ]; then
#    [ "$key" = ctrl-o ] && open "$file" || nv "$file"
#  fi
#}

#fdp() {
#  local cmd dir
#  cmd="${FZF_ALT_C_COMMAND:-"command find -L . /home/ACM-Lab \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
#    -o -type d -print 2> /dev/null | cut -b3-"}"
#	dir=$(eval "$cmd" | fzf --preview 'tree -C {} | head -100' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse ) && printf 'cd %q' "$dir"
#}

# ALT-C - cd into the selected directory
#bind -m emacs-standard '"\eg": " \C-b\C-k \C-u`fdp`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
#bind -m vi-command '"\eg": "\C-z\eg\C-z"'
#bind -m vi-insert '"\eg": "\C-z\eg\C-z"'

#fpd()
#{
#    #local filepath1=$PWD
#    #cd ~
#    local qmd="${Some_cmnd:-"fdfind . $HOME --type d --color=never --hidden --follow --exclude .git "}"
#    eval "$qmd" | fzf -m  --preview 'tree -C {} | head -100' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse | while read -r item; do
#    printf '%q ' "$item"
#    #cd "$filepath1"
#  done
#  echo
#
#}
#
#fpdw() {
#  local selected="$(fpd)"
#  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
#  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
#}
#
#if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
#  # CTRL-d - Paste the selected file path into the command line
#  bind -m emacs-standard '"\ef": " \C-b\C-k \C-u`fpd`\e\C-e\er\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-f"'
#  bind -m vi-command '"\ef": "\C-z\ef\C-z"'
#  bind -m vi-insert '"\ef": "\C-z\ef\C-z"'
#else
#  # CTRL-d - Paste the selected file path into the command line
#  bind -m emacs-standard -x '"\ef": fpdw'
#  bind -m vi-command -x '"\ef": fpdw'
#  bind -m vi-insert -x '"\ef": fpdw'
#fi

#fpf()
#{
#    #local filepath2=$PWD
#    #cd ~
#    local qmd="${Some_cmnd:-"fdfind . $HOME --type f --color=never --hidden --follow --exclude .git "}"
#    eval "$qmd" | fzf -m  --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview' --height=80% --layout=reverse | while read -r item; do
#    printf '%q ' "$item"
#    #cd "$filepath2"
#  done
#  echo
#
#}

#fpfw() {
#  local selected="$(fpf)"
#  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
#  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
#}
#
#if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
#  # CTRL-f - Paste the selected file path into the command line
#  bind -m emacs-standard '"\C-f": " \C-b\C-k \C-u`fpf`\e\C-e\er\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-f"'
#  bind -m vi-command '"\C-f": "\C-z\C-f\C-z"'
#  bind -m vi-insert '"\C-f": "\C-z\C-f\C-z"'
#else
#  # CTRL-f - Paste the selected file path into the command line
#  bind -m emacs-standard -x '"\C-f": fpfw'
#  bind -m vi-command -x '"\C-f": fpfw'
#  bind -m vi-insert -x '"\C-f": fpfw'
#fi

# End ---------------------------------------------------------------------------------------------
