
" Automatically update sessions in two cases:
"     - Before leaving Vim
"     - Before loading a new session via :SLoad
let g:startify_session_persistence = 1
let g:startify_files_number = 5 " The number of files to list.
let g:startify_session_number = 5 "Same but for sessions
let g:startify_session_sort = 1
let g:startify_session_dir = '~/.config/nvim/.session' "Where to keep Startify sessions
let g:startify_change_to_dir = 0 "Disable with autochdir
let g:startify_fortune_use_unicode = 1 "set if 'encoding' is "utf-8". Otherwise use ASCII
let g:startify_padding_left = 3
let g:startify_enable_special = 1 "Show <empty buffer> and <quit>.
let g:startify_disable_at_vimenter = 0
let g:startify_relative_path = 1
let g:startify_use_env = 1

" Startify LOGO
" let g:startify_custom_header = 'startify#pad(startify#fortune#cowsay())'
" let g:startify_custom_header = []
" let g:startify_custom_header = [
"     \ '                                 ________  __ __        ',
"     \ '            __                  /\_____  \/\ \\ \       ',
"     \ '    __  __ /\_\    ___ ___      \/___//''/''\ \ \\ \    ',
"     \ '   /\ \/\ \\/\ \ /'' __` __`\        /'' /''  \ \ \\ \_ ',
"     \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \      /'' /''__  \ \__ ,__\',
"     \ '    \ \___/  \ \_\ \_\ \_\ \_\    /\_/ /\_\  \/_/\_\_/  ',
"     \ '     \/__/    \/_/\/_/\/_/\/_/    \//  \/_/     \/_/    ',
"     \ ]
" let g:ascii = [
"           \ '        __',
"           \ '.--.--.|__|.--------.',
"           \ '|  |  ||  ||        |',
"           \ ' \___/ |__||__|__|__|',
"           \ ''
"           \]
" let g:startify_custom_header = g:ascii + startify#fortune#boxed()
" let g:startify_custom_header =
"           \ 'startify#pad(g:ascii + startify#fortune#quote())'
" let g:startify_custom_header =
"           \ 'startify#center(g:ascii + startify#fortune#boxed())'

"We can specify what shows up in our menu like this:
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

"BOOKMARKS

let g:startify_bookmarks = [
            \ { 'c': '~/.config/' },
            \ { 'h': '~/Softwares/Installed/MC_Workshop/' },
            \ { 'd': '/home/ACM-Lab/Softwares/Installed/MC_Workshop/BU/Docs/Akhil/Project/' },
            \ { 'p': '/home/ACM-Lab/Softwares/Installed/Pythia/pythia8303/examples/Test/'},
            \ { 'm': '/home/ACM-Lab/Music/Mine/'},
            \ { 'v': '~/Videos'},
            \ ]

let g:startify_fortune_use_unicode = 1

nmap <Leader>st	    :Startify<CR>
nnoremap <Leader>sq :call SaveandExitSession<CR>
"nnoremap <Leader>sq	:exe 'SSave session_'.strftime("%a.%d.%b-%H:%M")<CR>

function! SaveandExitSession()
  :exe 'SSave session_'.strftime("%a.%d.%b-%H:%M")
  :q!
endfunction

"Auto-save a session with Git branch name
function! GetUniqueSessionName()
  let path = fnamemodify(getcwd(), ':~:t')
  let identfier = strftime('%a%d%b-%H%M')
  return substitute(path . identifier, '/', '-', 'g')
endfunction

" autocmd VimEnter *
" 	    \   if !argc()
" 	    \ |   Startify
" 	    \ | echo 'wait'
" 	    \ |exe "Fern -drawer -toggle <C-r>=<SID>smart_path()<CR><CR>"
" 	    " \ |   wincmd w
" 	    \ | endif
"autocmd VimLeavePre * silent execute " SSave! strftime('%a%d%b-%H%M') "

"let stsname = put"system('date +%F')<CR>" 



