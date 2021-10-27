
--##########################################################################################################
-- LSP Keybindings and completion---------------------------------------------------------------------------
--###################################################################################################################

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    require 'illuminate'.on_attach(client)
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--##########################################################################################################
-- General lang server setup -----------------------------------------
--###################################################################################################################

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { 'cmake','vimls'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { 
	--root_dir = vim.loop.cwd;
	capabilities = capabilities;
	on_attach = on_attach;
	flags = {
	    debounce_text_changes = 150,
	}
    }
end

nvim_lsp.bashls.setup { 
    --root_dir = vim.loop.cwd;
    filetypes = { "sh", "bash", "zsh" },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
	debounce_text_changes = 150,
    }
}
--##########################################################################################################
-- C++ config------------------------------------------
--###################################################################################################################

-- require('LSP/ccpp')
-- local cclscachepath = vim.fn.getenv("HOME").."/tmp/ccls-cache"
nvim_lsp.clangd.setup {
    cmd = { 
	"clangd",  
	"--background-index",
    },
    -- root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".ccls"),
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
	debounce_text_changes = 150,
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    -- on_init = function to handle changing offsetEncoding
    -- root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git") or dirname
}

-- require('LSP/ccpp')
-- local cclscachepath = vim.fn.getenv("HOME").."/tmp/ccls-cache"
-- nvim_lsp.ccls.setup {
--     init_options = {
-- 	  --compilationDatabaseDirectory = "/home/ACM-Lab/Softwares/Installed/ccls/Debug" ;
-- 				index = {
-- 					threads = 0;
-- 				},
-- 				clang = {
-- 					excludeArgs = { "-frounding-math"} ;
-- 					resourceDir = "/usr/lib/llvm-7/lib/clang/7.0.1/include" ;
-- 				},
-- 				cache = {
-- 					directory = cclscachepath 
-- 				},
--     },
--     cmd = { 
-- 			'ccls',  
-- 			'--log-file=/tmp/ccls.log',
-- 			'-v=1'
--     },
--     -- root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".ccls"),
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     }
--   --filetypes = { "c", "cpp", "objc", "objcpp" } ;
-- 	--capabilities = capabilities ;
-- 	--root_dir = vim.loop.cwd ;
-- 	--root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls") or '/home/ACM-Lab/.Test' ;
-- 	--root_dir = {'echo', 'getcwd()'} ;
--   -- "--log-file=/tmp/ccls.log -v=1"
-- }

-- Example custom server
-- local sumneko_root_path = vim.fn.getenv 'HOME' .. '/.local/bin/sumneko_lua' -- Change to your sumneko root installation
-- local sumneko_binary = sumneko_root_path .. '/bin/linux/lua-language-server'

-- -- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

-- require('lspconfig').sumneko_lua.setup {
--   cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = { 'vim' },
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file('', true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
