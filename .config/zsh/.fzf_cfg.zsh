# Setup fzf
# ---------
if [[ ! "$PATH" == *${MY_FZF_PATH}/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${MY_FZF_PATH}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${MY_FZF_PATH}/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${MY_FZF_PATH}/shell/key-bindings.zsh"

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

# CTRL-T + CTRL-T - Paste the selected file path(s) from $HOME into the command line
#---------------------------------------------------------------------------------
sff() {
  local cmd="${FZF_FILE_COMMAND} $HOME"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | fzf-tmux -m "${FZF_FILE_PREVIEW[@]}" ${FZF_FILE_WINDOW[@]} "$@" | while read item; do
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
  local cmd="${FZF_FOLDER_COMMAND}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | fzf-tmux -m ${FZF_FOLDER_PREVIEW[@]} ${FZF_FOLDER_WINDOW[@]} "$@" | while read item; do
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
  local cmd="${FZF_FOLDER_COMMAND} $HOME"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | fzf-tmux -m ${FZF_FOLDER_PREVIEW[@]} ${FZF_FOLDER_WINDOW[@]} "$@" | while read item; do
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
  local cmd="${FZF_FOLDER_COMMAND} $HOME"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | fzf-tmux -m ${FZF_FOLDER_PREVIEW[@]} ${FZF_FOLDER_WINDOW[@]})"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="cd ${(q)dir}" #"
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
   file=$(fzf-tmux +m ${FZF_FILE_PREVIEW[@]} ${FZF_FILE_WINDOW[@]} -q "$1") && dir=$(dirname "$file") && cd "$dir"
   local ret=$?
}

# zle     -N    cdf
# bindkey '\ecf' cdf
bindkey -s '\ecf' 'cdf\n'

# Open files from current directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
FZF_FD_COMMAND=( "${FZF_FILE_COMMAND[@]}" " | fzf -m " "${FZF_FILE_PREVIEW[@]}" )
onv() {
  local files

  # files=(${(f)"${FZF_FD_COMMAND[@]}"})
  files=(${(f)"$(fdfind --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf -m --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse)"})
  # files=("$(fdfind --type f --color=never --hidden --follow | fzf -m ${FZF_FILE_WINDOW[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse)")

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

# Open files from $HOME directory recursively with vim(nvim)
#---------------------------------------------------------------------------------
anv() {
    filepath=$PWD
    cd
    local files

    files=(${(f)"$(fdfind --type f --color=never --hidden --follow --exclude .git --exclude node_modules | fzf -m ${FZF_FILE_WINDOW[@]} --preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-space:toggle-preview,f2:execute(xdg-open {} 2> /dev/null &)' --height=80% --layout=reverse)"})

    if [[ -n $files ]]
    then
      ${EDITOR:-vim} -- $files
      echo $(echo $files[@] | awk 'BEGIN{ORS=" "};{print $0}')
    fi
    cd $filepath
}

#---------------------------------------------------------------------------------
fzfnova(){
	#xterm -T fzf-nova -geometry 90x25+350+200 -fs 16 -e ~/.config/fzf_nova/fzf-nova
	alacritty -t fzf-nova --dimensions 90 20 --position 350 200 -e /path/to/script/fzf-nova
}

zle     -N    fzfnova
bindkey '\efr' fzfnova

# TMux sessoins create or select
#---------------------------------------------------------------------------------
fzts() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# bindkey -r '\C-g'
# bindkey -s '\C-g' 'fzts\n'

# End ---------------------------------------------------------------------------------------------
