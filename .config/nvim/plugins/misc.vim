
"##################################################
"Autocommands
"##################################################

autocmd FileType apache setlocal commentstring=#\ %s
autocmd FileType xdefaults setlocal commentstring=!\ %s
autocmd BufEnter vifmrc setlocal commentstring=\"\ %s

autocmd Syntax tmux,py,bash,zsh,sh,r,h,hh,hpp,cc,c,cpp,vim,nvim,lua,xml,html,xhtml,perl normal zR

au BufRead,BufNewFile *.rasi		setfiletype css

augroup tmuxfiletypedetect
    au! BufRead,BufNewFile *.tmux		set filetype=tmux | set syntax=sh
    " au! BufRead,BufNewFile *.tmux		set syntax=sh
augroup END

"Remap escape to leave terminal mode
augroup Terminal
    autocmd!
    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au TermOpen * set nonu
augroup end

"##########################################################################################################
" vim illuminate --------------------------------------------------------------------------------------------------------------
"###################################################################################################################

" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
" augroup END

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
    autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
augroup END

