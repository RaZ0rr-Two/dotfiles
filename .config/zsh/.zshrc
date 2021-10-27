# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
#setopt appendhistory beep nomatch notify
setopt appendhistory
unsetopt autocd extendedglob
bindkey -e
zle_highlight+=(paste:none)
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.config/zsh/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall

declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.config/zinit"
ZINIT[BIN_DIR]="$HOME/.config/zinit/bin"
#ZINIT[ZCOMPDUMP_PATH]="$HOME/.config/zinit"

### Added by Zinit's installer
if [[ ! -f $HOME/.config/zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zinit" && command chmod g-rwX "$HOME/.config/zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zinit/bin/zinit.zsh"
#autoload -Uz _zinit
#(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

[ -f $ZDOTDIR/.zsh_aliases ] && source $ZDOTDIR/.zsh_aliases

[ -f $ZDOTDIR/.zsh_sources ] && source $ZDOTDIR/.zsh_sources

[ -f $ZDOTDIR/.zsh_functions ] && source $ZDOTDIR/.zsh_functions

# [ -f $ZDOTDIR/.zsh_extra ] && source $ZDOTDIR/.zsh_extra


zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

eval "$(starship init zsh)"
