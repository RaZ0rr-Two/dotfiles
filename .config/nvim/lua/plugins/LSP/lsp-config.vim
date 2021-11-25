" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader><C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-d>p <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-d>n <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nmap <leader>hh			:echo "Hello World"<CR>

" auto-format
autocmd BufWritePre *.cpp lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.h lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.hpp lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.objc lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.objcpp lua vim.lsp.buf.formatting_sync(nil, 100)

autocmd BufWritePre *.bash lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.sh lua vim.lsp.buf.formatting_sync(nil, 100)

"autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
