function! GetAllMap()
		:redir >> ~/.config/nvim/myVimMaps.txt
		:silent map
		:silent map!
		:redir END
endfunction

function! GetRTP()
		:redir >> ~/.config/nvim/myVimRTP&packpath.txt
		:silent echo &rtp
		:silent echo "#####################################"
		:silent echo "-----------packpath------------------"
		:silent echo "#####################################"
		:silent echo $packpath
		:redir END
endfunction

function MyFloatTermCheck()
     :FloatermKill Vifm
		 :FloatermToggle Vifm
     :execute 'FloatermNew --name=Vifm vifmrun' fnameescape(getcwd())
endfunction

"################################################################
"Substitue command
"################################################################

function! Substitute(type, ...)
	let cur = getpos("''")
	call cursor(cur[1], cur[2])
	let cword = expand('<cword>')
	execute "'[,']s/" . cword . "/" . input(cword . '/')
	call cursor(cur[1], cur[2])
endfunction
nmap <silent> <leader>sb m':set opfunc=Substitute<CR>g@
" Usage:
"   <key>ipfoo<CR>         Substitute every occurrence of the word under
"                          the cursor with 'foo' n the current paragraph
"   <key>Gfoo<CR>          Same, from here to the end of the buffer
"   <key>?bar<CR>foo<CR>   Same, from previous occurrence of 'bar'
"                          to current line

"################################################################
"Quickfix alternative to :g/foo/#
"################################################################

set errorformat^=%f:%l:%c\ %m
command! -bang -nargs=1 MyGlobal lgetexpr filter(map(getline(1,'$'), { key, val -> expand("%") . ":" . (key + 1) . ":1 " . (len(val) > 0 ? val : '  ') }), { idx, val -> expand('<bang>') == '!' ? val !~ '^.\{-}:1 \zs.*' . <q-args> . '.*' : val =~ '^.\{-}:1 \zs.*' . <q-args> . '.*' })

"################################################################
"Redirect the output of a Vim or external command into a 
"scratch buffer
"################################################################

function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

"With execute command ------------------------------------------

" Redirect the output of a Vim or external command into a scratch buffer
function! Eredir(cmd) abort
    let output = execute(a:cmd)
    tabnew
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(output, "\n"))
endfunction
command! -nargs=1 ERedir silent call Eredir(<f-args>)

"################################################################
"Instant grep + quickfix
"################################################################

set grepprg=rg\ --vimgrep

function! GGrep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar GGrep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LLGrep lgetexpr Grep(<f-args>)

function! CustomExpand(val)
    " if starts with *, don't expand it
    if a:val =~ '^\*'
        return a:val
    else
        return expand(a:val)
    endif
endfunction

" call grepprg in a system shell instead of internal shell
function! ImprovedGrep(...)
    " expandcmd() is only supported in regular vim or nvim-0.5
    if has('nvim-0.5') || !has('nvim')
        return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
    else
        let l:args = copy(a:000)
        let CExp = function("CustomExpand")
        return system(join([&grepprg] + [join(map(l:args, 'CExp(v:val)'), ' ')], ' '))
    endif
endfunction

cnoreabbrev <expr> mygrep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'GGrep'  : 'grep'
cnoreabbrev <expr> mylgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LLGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

"function GetAllMap2()
"		:redir > ~/maps/vim.output | silent map | redir END
"endfunction

"function GetAllMap3()
"		:redir @"
"		:map
"		:redir END
"		:enew|put
"endfunction
