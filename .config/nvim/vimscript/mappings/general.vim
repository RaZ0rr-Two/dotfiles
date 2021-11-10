" Close buffer
nnoremap <Leader>bq			:bn<bar>bd#<CR>
" Close all buffer except current
nnoremap <Leader>bQ			:%bd<bar>e#<bar>bd#<cr>

" Diable higlight
nnoremap <buffer> <localleader>hl    :set hlsearch!<CR>

" Toggle line wrap
nnoremap <localleader>wt   :setlocal wrap!<cr>

" --Remap for dealing with word wrap
" vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
nnoremap    <expr><silent> k	v:count == 0 ? 'gk' : 'k'
nnoremap    <expr><silent> j	v:count == 0 ? 'gj' : 'j'

" Better nav for omnicomplete
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
nnoremap <M-UP>    :resize -2<CR>
nnoremap <M-DOWN>    :resize +2<CR>
nnoremap <M-LEFT>    :vertical resize -2<CR>
nnoremap <M-RIGHT>    :vertical resize +2<CR>

" I hate escape more than anything else
" inoremap jk <Esc>
" inoremap kj <Esc>

" Easy CAPS toggle
" inoremap <Leader><c-u> <ESC>viw~i
nnoremap <Leader><c-u> viw~<Esc>

"Search and replace
nnoremap <Leader>sr :%s/<C-r><C-w>//gc<Left><Left><Left>
vmap <Leader>ss y/<C-R>"<CR>
vmap <Leader>sr y:%s/<C-R>"//gc<Left><Left><Left>
xnoremap * :<c-u>let @/=@"<cr>gvy:let [@/,@"]=[@",@/]<cr>/\V<c-r>=substitute(escape(@/,'/\'),'\n','\\n','g')<cr><cr>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to save and quit
"nnoremap <C-S> :wq!<CR>
" Alternate way to quit
nnoremap <c-q> :q<CR>
" Use control-c instead of escape
" nnoremap <C-c> <Esc>
inoremap <C-C> <ESC>
" <TAB>: completion.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

"Move selected line / block of text in visual mode
" xnoremap K :move '<-2<CR>gv-gv
" xnoremap J :move '>+1<CR>gv-gv
xnoremap <a-j> :m '>+1<CR>gv=gv
xnoremap <a-k> :m '<-2<CR>gv=gv
nnoremap <a-j> :m .+1<CR>==
nnoremap <a-k> :m .-2<CR>==
inoremap <a-j> <Esc>:m .+1<CR>==gi
inoremap <a-k> <Esc>:m .-2<CR>==gi

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -----------------------------------------------------------------------------//
" Add Empty space above and below
" -----------------------------------------------------------------------------//
nnoremap <Leader>o	<cmd>put! =repeat(nr2char(10), v:count1)<cr>'[            
nnoremap <Leader>O	<cmd>put =repeat(nr2char(10), v:count1)<cr>           
" nnoremap <Leader>o	m`o<Esc>``            
" nnoremap <Leader>O	m`O<Esc>``           
" nnoremap <Leader>o	o<Esc>            
" nnoremap <Leader>O	O<Esc>           
