let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
"let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_theme='bubblegum'
"let g:airline#extensions#statusline#fnamemod = ':t'
let g:airline_section_c = '%t'
let g:airline_section_z = airline#section#create(['%3p%%', 'linenr', '/%L', ':%2v'])
