"########################################################
"		Bootstrap
"########################################################

source $HOME/.config/nvim/vimscript/plugins/vim-plug/check.vim

" " auto-install vim-plug
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
"   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   "autocmd VimEnter * PlugInstall --sync
"   autocmd VimEnter * PlugInstall | source $MYVIMRC
"   autocmd VimEnter * PlugClean! | PlugUpdate --sync | close
" endif

"########################################################
"		All the used plugins 
"########################################################
"
" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')
" call plug#begin('~/.config/nvim/autoload/plugged')

	Plug 'norcalli/nvim-colorizer.lua'
	
	"Auto-pair completion
	Plug 'windwp/nvim-autopairs' 
	
	"Moves selections of line up/down/left/right
	"Plug 'matze/vim-move'
	
	"Comment and Uncomment lines
	Plug 'b3nj5m1n/kommentary'
	"Plug 'terrortylor/nvim-comment'
	
	"Better Syntax Support
	"Plug 'sheerun/vim-polyglot'

	"Devicons for nvim
	Plug 'kyazdani42/nvim-web-devicons'
	
	"Tab/buffers display and customize
	Plug 'akinsho/nvim-bufferline.lua'
	
	"Statusline
	Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

	" Undo history
	Plug 'mbbill/undotree'

	"Indent guidelines? Lines connecting sentences with same indentaion
	Plug 'lukas-reineke/indent-blankline.nvim' , {'branch': 'lua'}
	
	" File Explorer
	" Plug 'scrooloose/NERDTree'

	" Auto pairs for '(' '[' '{'
	"Plug 'jiangmiao/auto-pairs'

	" Fern tree viewer
	Plug 'lambdalisue/fern.vim'
	Plug 'lambdalisue/nerdfont.vim'
	Plug 'lambdalisue/fern-renderer-nerdfont.vim'
	
	" Status/tabline
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	
	" fzf/ fuzzy finder.
	Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
	Plug 'junegunn/fzf.vim'
	
	"Startify
	Plug 'mhinz/vim-startify'
	
	" CHADtree
	" Plug 'ms-jpq/chadtree', {'branch': 'legacy', 'do': 'python3 -m chadtree deps'}
	
	" nvim.tree requires
	" Plug 'kyazdani42/nvim-tree.lua'	

" LSP ----------------------------------------------
		
	"Folding and extensions
	Plug 'Konfekt/FastFold'
	Plug 'zhimsel/vim-stay'
	
	"Lsp-config plugin and autocompletion
	Plug 'neovim/nvim-lspconfig'
	
	Plug 'hrsh7th/nvim-compe' "Autocompletion
	Plug 'hrsh7th/vim-vsnip'  " nvim vsnip snippet plugin and integration
	"Plug 'hrsh7th/vim-vsnip-integ' --Not required when nv-compe used for completion
	
	"Lsp better functioning. 
	Plug 'RishabhRD/popfix'
	Plug 'RishabhRD/nvim-lsputils'
	
	"Show lightbulb for diagnostics
	Plug 'kosayoda/nvim-lightbulb'
	
	"Signature help plug
	Plug 'ray-x/lsp_signature.nvim'
	
	"Higlight occurances of word under cursor
	Plug 'RRethy/vim-illuminate'
	
	"Snippets
	"Plug 'norcalli/snippets.nvim'

" THEMES ----------------------------------------------
		
	"Colorscheme set
	Plug 'RRethy/nvim-base16'
	
	"Onedark
	Plug 'joshdick/onedark.vim' 
	
	"Gruvbox
	Plug 'morhetz/gruvbox' 
		
call plug#end()


