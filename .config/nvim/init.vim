"##########################################
" GENERAL SETTINGS
"##########################################

"------------------------------------------
" Options
"------------------------------------------
source $HOME/.config/nvim/vimscript/general/settings.vim

"------------------------------------------
" Mappings
"------------------------------------------
lua require('mappings/general')
" source $HOME/.config/nvim/vimscript/mappings/general.vim

"------------------------------------------
" Themes/UI
"------------------------------------------
source $HOME/.config/nvim/vimscript/general/themes.vim

"------------------------------------------
"Custom AutoGroups, Commands & Functions
"------------------------------------------
source $HOME/.config/nvim/vimscript/general/myCmdsAndFns.vim
source $HOME/.config/nvim/vimscript/general/myAutos.vim

"##########################################
" PLUGINS SETTINGS
"##########################################

"------------------------------------------
" Install
"------------------------------------------

" Vim-Plug -----------------------------------
"source $HOME/.config/nvim/vimscript/plugins/pluginsList.vim

" Packer -----------------------------------
lua require('plugins/pluginsList')

"------------------------------------------
" Config
"------------------------------------------

" General ---------------------------------
lua require('plugins/general/fzf-lua')
" source $HOME/.config/nvim/vimscript/plugins/fzf.vim
lua require('plugins/general/nvim-cmp')
source $HOME/.config/nvim/vimscript/plugins/undotree.vim
lua require('plugins/general/nvim-autopairs')
lua require('plugins/general/kommentary')
" source $HOME/.config/nvim/vimscript/plugins/misc.vim
source $HOME/.config/nvim/vimscript/plugins/fastfold.vim
" lua require('plugins/general/nvim-tree')
" lua require('plugins/general/nv-vsnip')
lua require('plugins/general/fm-nvim')
lua require('plugins/general/misc')

" UI/Look -----------------------------------
lua require('plugins/general/feline')
"lua require('feline').setup()
" lua require('plugins/general/galaxyline/disrupted')
lua require('plugins/general/alpha')
" source $HOME/.config/nvim/vimscript/plugins/startify.vim
lua require('plugins/general/indent-blankline')
lua require('plugins/general/nvim-bufferline')
lua require('plugins/general/vim-matchup')
"source $HOME/.config/nvim/vimscript/plugins/fernTree.vim
"source $HOME/.config/nvim/vimscript/plugins/airline.vim
"source $HOME/.config/nvim/vimscript/keys/nerdTree.vim
"source $HOME/.config/nvim/vimscript/plugins/nvimTree.vim
"source $HOME/.config/nvim/vimscript/keys/CHADtree.vim

" LSP -----------------------------------
lua require('plugins/LSP/settings')
lua require('plugins/LSP/lsp-utils')
lua require('plugins/LSP/lsp_signature')
lua require('plugins/LSP/nvim-lightbulb')
"source $HOME/.config/nvim/vimscript/plugins/LSP/lsp-config.vim
"source $HOME/.config/nvim/vimscript/plugins/snippets.vim

" Treesitter -----------------------------
lua require('plugins/treesitter')

"------------------------------------------
" Mappings
"------------------------------------------
lua require('mappings/fzf-lua')
" lua require('mappings/nvimTree')
" lua require('mappings/misc')
" luafile $HOME/.config/nvim/mappings/nvimTree.lua
" luafile $HOME/.config/nvim/mappings/fzf-lua.lua
