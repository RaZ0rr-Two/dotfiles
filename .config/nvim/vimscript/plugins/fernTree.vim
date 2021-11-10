let g:fern#disable_default_mappings   = 1
let g:fern#hide_cursor=1
let g:fern#mark_symbol=">"
"let g:fern#default_include =  
"let g:fern#disable_drawer_smart_quit  = 1
augroup FernView
  autocmd! *
  autocmd FileType fern call FernInit()
  autocmd FileType fern call s:smart_path()
augroup END

" noremap <silent> <Leader>ee :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
nnoremap <silent> <Leader>ee :<C-u>Fern -drawer -toggle -reveal=% <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <Leader>ed :<C-u>Fern -drawer -toggle <C-r>=<SID>smart_path()<CR><CR>

" Return a parent directory of the current buffer when the buffer is a file.
" Otherwise it returns a current working directory.
function! s:smart_path() abort
  if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
    return fnamemodify('.', ':p')
  endif
  return fnamemodify(expand('%'), ':p:h')
endfunction

function! s:map_enter_project_root(helper) abort
  " NOTE: require 'file' scheme
  let root = a:helper.get_root_node()
  let path = root._path
  let path = finddir('.git/..', path . ';')
  execute printf('Fern %s', fnameescape(path))
endfunction

augroup FernTypeGroup
  autocmd! * <buffer>
  autocmd BufEnter <buffer> silent execute "normal \<Plug>(fern-action-reload)"
augroup END


function! FernInit() abort
  
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
  
  nmap <buffer><expr>
      \ <Plug>(fern-my-open-expand-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open)",
      \   "\<Plug>(fern-action-expand:stay)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

  nmap <buffer> <Plug>(my-fern-open-and-stay) <Plug>(fern-action-open)<C-w><C-p>

  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> l <Plug>(fern-action-open-or-enter)
  nmap <buffer> <right> <Plug>(fern-action-open-or-enter)
  nmap <buffer> h <Plug>(fern-action-leave)
  nmap <buffer> <left> <Plug>(fern-action-leave)
  nmap <buffer> <Leader><CR> <Plug>(my-fern-open-and-stay)
  nmap <buffer> gb <Plug>(fern-action-open:system)
  nmap <buffer> t <Plug>(fern-action-mark:toggle)
  nmap <buffer> P <Plug>(fern-action-focus:parent)
  nmap <buffer> p <Plug>(fern-action-reveal)
  nmap <buffer> <leader>n <Plug>(fern-action-new-file)
  nmap <buffer> <leader>N <Plug>(fern-action-new-dir)
  nmap <buffer> <leader>G <Plug>(fern-action-grep)
  nmap <buffer> <leader>t <Plug>(fern-action-terminal)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> T <Plug>(fern-action-trash)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> C <Plug>(fern-action-copy)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> F <Plug>(fern-action-include)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload:all)
  nmap <buffer> za <Plug>(fern-action-hidden:toggle)
  nmap <buffer> < <Plug>(fern-action-leave)
  nmap <buffer> > <Plug>(fern-action-enter)
  "Open bookmarks with <C-^>
  nmap <buffer><expr><silent>
	      \ <C-^>
	      \ fern#smart#scheme(
	      \   ":\<C-u>Fern bookmark:///\<CR>",
	      \   {
	      \     'bookmark': "\<C-^>",
	      \   },
	      \ )
  " Find and enter project root with ^
  nnoremap <buffer><silent>
        \ <Plug>(fern-my-enter-project-root)
        \ :<C-u>call fern#helper#call(funcref('<SID>map_enter_project_root'))<CR>
  nmap <buffer><expr><silent>
        \ ^
        \ fern#smart#scheme(
        \   "^",
        \   {
        \     'file': "\<Plug>(fern-my-enter-project-root)",
        \   }
        \ )
  
endfunction

function! s:on_highlight() abort
	  " Use brighter highlight on root node
	  highlight link FernRootSymbol Title
	  highlight link FernRootText   Title
endfunction

augroup my-fern-highlight
  autocmd!
  autocmd User FernHighlight call s:on_highlight()
augroup END

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * ++nested Fern -drawer %:h | if argc() > 0 || exists("s:std_in") | wincmd l | endif

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * ++nested Fern -drawer %:h | if argc() > 0 || exists("s:std_in") | wincmd p | endif

"autocmd VimEnter *
"                \   if !argc()
"                \ |   Startify
"                \ |   ++nested Fern -drawer
"                \ |   wincmd w
"                \ | endif

let g:fern#renderer = "nerdfont"

"let g:fern#mark_symbol                       = '●'
"let g:fern#renderer#default#collapsed_symbol = '▷ '
"let g:fern#renderer#default#expanded_symbol  = '▼ '
"let g:fern#renderer#default#leading          = ' '
"let g:fern#renderer#default#leaf_symbol      = ' '
"let g:fern#renderer#default#root_symbol      = '~ '
