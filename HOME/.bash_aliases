#!/bin/bash

# some more ls aliases
alias ll='ls -lh'
alias la='ls -al'
alias l='ls -CF'

#source bash
alias srcB='source ~/.bashrc'

#Tmux session (tmuxp)
alias tmxl='tmuxp load localB'
#----------------------------------------------------
# HEP ! No need as already sourced in .bash_aliases with ActivateEIC
#----------------------------------------------------
# alias Herwig='docker run -i --rm -u `id -u $USER`:`id -g` -v $PWD:$PWD -w $PWD graemenail/herwig-eic Herwig'
# alias rivet-mkanalysis='docker run -i  --rm  -u `id -u $USER`:`id -g` \-v $PWD:$PWD -w $PWD electronioncollider/pythia-eic-tutorial \rivet-mkanalysis'
# alias rivet-build='docker run -i  --rm  -u `id -u $USER`:`id -g` \-v $PWD:$PWD -w $PWD electronioncollider/pythia-eic-tutorial \rivet-build'
# alias rivet-mkhtml='docker run -i  --rm  -u `id -u $USER`:`id -g` \-v $PWD:$PWD -w $PWD electronioncollider/pythia-eic-tutorial \rivet-mkhtml'
# alias rivet-cmphistos='docker run -i  --rm  -u `id -u $USER`:`id -g` \-v $PWD:$PWD -w $PWD electronioncollider/pythia-eic-tutorial \rivet-cmphistos'
# alias rivet-merge='docker run -i  --rm  -u `id -u $USER`:`id -g` \-v $PWD:$PWD -w $PWD electronioncollider/pythia-eic-tutorial \rivet-merge'
# alias make-plots='docker run -i  --rm  -u `id -u $USER`:`id -g` \-v $PWD:$PWD -w $PWD electronioncollider/pythia-eic-tutorial \make-plots'
# alias rivet='docker run -i  --rm  -u `id -u $USER`:`id -g` \-v $PWD:$PWD -w $PWD electronioncollider/pythia-eic-tutorial rivet'

#vifm
alias vf=vifmrun

#pkg search with fzf
alias pkg=pkgsearch

#nnn - file manager
alias ncp="cat ${NNN_SEL:-${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection} | tr '\0' '\n'"

#----------------------------------------------------
#NeoVim
#----------------------------------------------------
alias wgnvn='wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P $HOME/Softwares/Installed/Terminal/nvim/nightly && rm $HOME/Softwares/Installed/Terminal/nvim/nightly/nvim.appimage && chmod +x $HOME/Softwares/Installed/Terminal/nvim/nightly/nvim.appimage.1 && mv $HOME/Softwares/Installed/Terminal/nvim/nightly/nvim.appimage.1 $HOME/Softwares/Installed/Terminal/nvim/nightly/nvim.appimage'

alias nv=nvim
#alias nv="$HOME/Softwares/nvim/nvim.appimage"
# alias nv="$HOME/Softwares/Installed/Terminal/nvim/nightly/nvim.appimage"

alias lbw="$HOME/Softwares/Installed/LibreWolf/LibreWolf-88.0-1.x86_64.AppImage"

#----------------------------------------------------
#Dotfile management
#----------------------------------------------------
# alias dgit='git --git-dir=$HOME/gFolder/RaZ0rr/dotfiles/ --work-tree=$HOME'
# alias wgit='git --git-dir=$HOME/gFolder/SciPhy/HEP/.git/ --work-tree=$HOME'
