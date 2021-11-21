"------------------------------------------
" PLUGINS INSTALL
"------------------------------------------
"source $HOME/.config/nvim/vim-plug/check.vim
"source $HOME/.config/nvim/vim-plug/plugins.vim

lua require('plugins/packer/check')
lua require('plugins/packer')

"------------------------------------------
" GENERAL SETTINGS
"------------------------------------------
source $HOME/.config/nvim/vimscript/general/settings.vim
source $HOME/.config/nvim/vimscript/general/themes.vim

"------------------------------------------
" VIMSCRIPT PLUGINS CONFIG
"------------------------------------------
source $HOME/.config/nvim/vimscript/plugins/undotree.vim
source $HOME/.config/nvim/vimscript/plugins/fastfold.vim
source $HOME/.config/nvim/vimscript/plugins/misc.vim
" source $HOME/.config/nvim/vimscript/plugins/fzf.vim
" source $HOME/.config/nvim/vimscript/plugins/startify.vim
"source $HOME/.config/nvim/vimscript/plugins/fernTree.vim
"source $HOME/.config/nvim/vimscript/plugins/airline.vim
"source $HOME/.config/nvim/vimscript/plugins/LSP/lsp-config.vim
"source $HOME/.config/nvim/vimscript/plugins/snippets.vim
"source $HOME/.config/nvim/vimscript/keys/nerdTree.vim
"source $HOME/.config/nvim/vimscript/plugins/nvimTree.vim
"source $HOME/.config/nvim/vimscript/keys/CHADtree.vim

"------------------------------------------
"LUA PLUGINS CONFIG
"------------------------------------------
lua require('plugins/fzf-lua')
lua require('LSP/settings')
lua require('plugins/nvim-cmp')
lua require('plugins/treesitter')
lua require('plugins/fm-nvim')
" lua require('plugins/nvim-tree')
lua require('plugins/nvim-lightbulb')
lua require('plugins/lsp_signature')
lua require('plugins/lsp-utils')
lua require('plugins/indent-blankline')
lua require('plugins/nvim-bufferline')
lua require('plugins/nvim-autopairs')
lua require('plugins/kommentary')
lua require('plugins/feline')
lua require('plugins/alpha')
lua require('plugins/misc')
" lua require('plugins/galaxyline/disrupted')
" lua require('plugins/nv-vsnip')

"------------------------------------------
" MAPPINGS
"------------------------------------------
lua require('mappings/general')
lua require('mappings/fzf-lua')
" lua require('mappings/nvimTree')
" source $HOME/.config/nvim/vimscript/mappings/general.vim
" lua require('mappings/misc')
" luafile $HOME/.config/nvim/mappings/nvimTree.lua
" luafile $HOME/.config/nvim/mappings/fzf-lua.lua

"------------------------------------------
"Custom AutoGroups, Commands & Functions
"------------------------------------------
source $HOME/.config/nvim/vimscript/general/myCmdsAndFns.vim
source $HOME/.config/nvim/vimscript/general/myAutos.vim
