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
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/themes.vim

"------------------------------------------
" PLUGINS CONFIG
"------------------------------------------
" source $HOME/.config/nvim/plugins/fzf.vim
source $HOME/.config/nvim/plugins/startify.vim
source $HOME/.config/nvim/plugins/undotree.vim
source $HOME/.config/nvim/plugins/fastfold.vim
source $HOME/.config/nvim/plugins/misc.vim
"source $HOME/.config/nvim/plugins/fernTree.vim
"source $HOME/.config/nvim/plugins/airline.vim
"source $HOME/.config/nvim/plugins/LSP/lsp-config.vim
"source $HOME/.config/nvim/plugins/snippets.vim
"source $HOME/.config/nvim/keys/nerdTree.vim
"source $HOME/.config/nvim/plugins/nvimTree.vim
"source $HOME/.config/nvim/keys/CHADtree.vim

"------------------------------------------
"LUA PLUGINS CONFIG
"------------------------------------------
" lua require('plugins/galaxyline/disrupted')
lua require('plugins/fzf-lua')
lua require('LSP/settings')
lua require('plugins/nvim-cmp')
lua require('plugins/nvim-tree')
lua require('plugins/nvim-lightbulb')
lua require('plugins/lsp_signature')
lua require('plugins/lsp-utils')
" lua require('plugins/nv-vsnip')
lua require('plugins/indent-blankline')
lua require('plugins/nvim-bufferline')
lua require('plugins/nvim-autopairs')
lua require('plugins/kommentary')
lua require('plugins/feline')
lua require('plugins/misc')

"------------------------------------------
" MAPPINGS
"------------------------------------------
source $HOME/.config/nvim/mappings/general.vim
source $HOME/.config/nvim/mappings/misc.vim
lua require('mappings/nvimTree')
lua require('mappings/fzf-lua')
" lua require('mappings/misc')
" luafile $HOME/.config/nvim/mappings/nvimTree.lua
" luafile $HOME/.config/nvim/mappings/fzf-lua.lua

"------------------------------------------
"Custom Commands & Functions 
"------------------------------------------
source $HOME/.config/nvim/general/myCmdsAndFns.vim
