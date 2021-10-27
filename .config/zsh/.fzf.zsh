# Setup fzf
# ---------
if [[ ! "$PATH" == "${MY_FZF_PATH}/bin" ]]; then
  export PATH="${PATH:+${PATH}:}${MY_FZF_PATH}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${MY_FZF_PATH}/shell/completion.zsh" #2> /dev/null

# Key bindings
# ------------
source "${MY_FZF_PATH}/shell/key-bindings.zsh"

previewFzfFile=(--preview-window 'down,50%,+{2}+3/3,~3')
previewFzfFolder=(--preview-window 'down,50%,~1')

export FZF_CTRL_T_COMMAND='fdfind --type f --color=never --follow --hidden --exclude .git --exclude node_modules'
export FZF_CTRL_T_OPTS="-m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=90% ${previewFzfFile[@]}"

export FZF_ALT_C_COMMAND='fdfind --type d . --color=never --hidden --follow --exclude .git --exclude node_modules '
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=90% ${previewFzfFolder[@]}"

export FZF_DEFAULT_COMMAND='rg --hidden --follow --no-ignore-vcs --files' 
export FZF_DEFAULT_OPTS='--height=80% --layout=reverse -m'

#---------------------------------------------------------------------------------
#Custom fzf keybindings & functions
#---------------------------------------------------------------------------------

# CTRL-T + CTRL-T - Paste the selected file path(s) from $HOME into the command line
#---------------------------------------------------------------------------------
sff() {
  local cmd="${FZF_CTRL_F_COMMAND:-"fdfind . $HOME --type f --color=never --hidden --follow --exclude .git --exclude node_modules 2> /dev/null"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' ${previewFzfFile[@]} --height=80% --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --reverse --bind=ctrl-z:ignore "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

sffw() {
  LBUFFER="${LBUFFER}$(sff)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N   sffw
bindkey '^T^T' sffw

# alt-F - Paste the selected folder path(s) from into the command line
#---------------------------------------------------------------------------------
sdf() {
  local cmd="${CDA_COMMAND:-"fdfind --type d --color=never --hidden --follow --exclude .git --exclude node_modules 2> /dev/null"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | fzf-tmux -m --preview 'tree -C {} | head -100' ${previewFzfFolder[@]} --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --bind=ctrl-z:ignore "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

sdfw() {
  LBUFFER="${LBUFFER}$(sdf)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N   sdfw
bindkey '\ef' sdfw

# alt-F+alt-F - Paste the selected folder path(s) from $HOME into the command line
#---------------------------------------------------------------------------------
sdhf() {
  local cmd="${CDA_COMMAND:-"fdfind . $HOME --type d --color=never --hidden --follow --exclude .git --exclude node_modules 2> /dev/null"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | fzf-tmux -m --preview 'tree -C {} | head -100' ${previewFzfFolder[@]} --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --bind=ctrl-z:ignore "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

sdhfw() {
  LBUFFER="${LBUFFER}$(sdhf)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N   sdhfw
bindkey '\ef\ef' sdhfw

# (ALT-c)+(Alt-c) - cd into the selected directory from anywhere
#---------------------------------------------------------------------------------
cda() {
  local cmd="${CDF_COMMAND:-"fdfind . $HOME --type d --color=never --hidden --follow --exclude .git --exclude node_modules 2> /dev/null"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | fzf-tmux -m --preview 'tree -C {} | head -100' ${previewFzfFolder[@]} --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --bind=ctrl-z:ignore )"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="cd ${(q)dir}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}

zle     -N    cda
bindkey '\ec\ec' cda

# (ALT-c)+(f) cdf - cd into the directory of the selected file
#---------------------------------------------------------------------------------
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
   local ret=$?
}

# zle     -N    cdf
# bindkey '\ecf' cdf
bindkey -s '\ecf' 'cdf\n'

# Open files from current directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
onv() {
  local files

  files=(${(f)"$(fdfind --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse)"})
  # files=("$(fdfind --type f --color=never --hidden --follow | fzf -m ${previewFzfFile[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse)")

  if [[ -n $files ]]
  then
     ${EDITOR:-vim} -- $files
     echo $(echo $files[@] | awk 'BEGIN{ORS=" "};{print $0}')
  fi
}
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --hidden --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
# onv() {
#   local IFS=$'\n' out=("$(rg --hidden --follow --no-ignore-vcs --files 2> /dev/null | fzf-tmux --preview 'bat --color=always --line-range :100 {}' --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#   local key=$(head -1 <<< "$out")
#   local file=$(head -2 <<< "$out" | tail -1)
#   if [ -n "$file" ]; then
#     [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
#   fi
# }

# Open files from $HOME directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
anv() {
    filepath=$PWD
    cd
    local files

    files=(${(f)"$(fdfind --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf -m ${previewFzfFile[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse)"})

    if [[ -n $files ]]
    then
      ${EDITOR:-vim} -- $files
      echo $(echo $files[@] | awk 'BEGIN{ORS=" "};{print $0}')
    fi
    cd $filepath
}
# anv() {
#     filepath=$PWD
#     cd
#     IFS=$'\n' out=("$(rg --hidden --follow --no-ignore-vcs --files 2> /dev/null | fzf-tmux --preview 'bat --color=always --line-range :100 {}' --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#     key=$(head -1 <<< "$out")
#     file=$(head -2 <<< "$out" | tail -1)
#     if [ -n "$fileoutput" ]; then
# 	[ "$key" = ctrl-o ] && xdg-open "$fileoutput" || ${EDITOR:-vim} "$fileoutput"
#     fi
#     cd $filepath
# }
# anv() {
#     filepath=$PWD
#     cd
#     IFS=$'\n' out=("$(rg --hidden --follow --no-ignore-vcs --files 2> /dev/null | fzf-tmux --preview 'bat --color=always --line-range :100 {}' --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#     fileoutput=(${(f)"$(rg --hidden --follow --no-ignore-vcs --files 2> /dev/null | fzf-tmux -m --preview 'bat --color=always --line-range :100 {}' --query="$1" --exit-0 --expect=ctrl-o,ctrl-e | awk 'BEGIN {ORS=" "};{print $1}')"}) 
#     key=$(head -1 <<< "$out")
#     file=$(head -2 <<< "$out" | tail -1)
#     echo $fileoutput "fileoutput"
#     echo $out "out"
#     if [ -n "$fileoutput" ]; then
# 	[ "$key" = ctrl-o ] && xdg-open "$fileoutput" || ${EDITOR:-vim} -- "$fileoutput"
#     fi
#     cd $filepath
# }

# anv() {
#     nv $(rg --hidden --follow --no-ignore-vcs --files 2> /dev/null | fzf-tmux --preview 'bat --color=always --line-range :100 {}' --query="$1" --exit-0 --expect=ctrl-o,ctrl-e | awk 'BEGIN { ORS=" " }; { print $1 }')
#     # nv $out
# }

#---------------------------------------------------------------------------------
fzfnova(){
	#xterm -T fzf-nova -geometry 90x25+350+200 -fs 16 -e ~/.config/fzf_nova/fzf-nova
	alacritty -t fzf-nova --dimensions 90 20 --position 350 200 -e /path/to/script/fzf-nova
}

zle     -N    fzfnova
bindkey '\efr' fzfnova

#---------------------------------------------------------------------------------
testhw(){
	echo "Hello World"
}
bindkey -s '^h^w' 'testhw\n'
