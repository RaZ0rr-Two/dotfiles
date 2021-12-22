
" set leader key
" nnoremap <Space> <Nop>
" nnoremap <silent> <Space>	    <Nop>
let g:mapleader = ","
let g:maplocalleader=" "

syntax enable                           " Enables syntax highlighing
filetype indent plugin on
set breakindent
set termguicolors
set ignorecase
set smartcase
set nohlsearch
set inccommand=nosplit
set nowrap                              " Display long lines as just one line
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set shortmess+=c
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set shiftwidth=2                        " number of auto-indent spaces
set tabstop=2
" set softtabstop=2                       " Insert 2 spaces for a tab
set scrolloff=4                         " Keep 4 lines below cursor before scrolling the screen vertically
set sidescrolloff=4                     " Keep 4 lines below cursor before scrolling the screen horizontally
set smartindent                         " Makes indenting smart
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set showmatch                      			" Highlight matching brace
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
" set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard+=unnamedplus              " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set laststatus=2

set foldmethod=syntax
set foldlevelstart=99
" set foldlevel=99

set pastetoggle=<leader>p
" let currentMode = mode()
set sessionoptions+=globals,blank,buffers,curdir,help,tabpages,winsize
set viewoptions=cursor,folds,slash,unix
" let mkvpath = expand('~/.config/nvim/.mkViewDir')
" let &viewdir=mkvpath
set viewdir=$HOME/.config/nvim/.mkViewDir
"set undofile				" Set in undotree.vim

" auto source when writing to init.vim 
" alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC nested source $MYVIMRC | echom "Reloaded init.vim"
au! BufWritePost **/settings.vim nested source $MYVIMRC | echom "Reloaded init.vim"

" You can't stop me
" cmap w!! w !sudo tee %