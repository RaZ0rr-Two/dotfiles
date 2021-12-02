"--------------------------------------------------------
"    FastFold ( Konfekt/FastFold )
"--------------------------------------------------------
nmap zuz :FastFoldUpdate!<cr><esc>

xnoremap iz :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>
xnoremap az :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>

"##########################################################################################################
" vim illuminate --------------------------------------------------------------------------------------------------------------
"###################################################################################################################

" Don't highlight word under cursor (default: 1)
let g:Illuminate_highlightUnderCursor = 0

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
    autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
augroup END

