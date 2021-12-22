--##########################################################################################################
-- vim floaterm --------------------------------------------------------------------------------------------------------------
--###################################################################################################################
vim.g.floaterm_opener = 'edit'
vim.g.floaterm_autoclose = 1
vim.api.nvim_set_keymap('n','<leader>tt', [[:execute 'FloatermNew --name=Vifm --disposable vifmrun' fnameescape(getcwd())<CR>]], {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n','<leader>tt', [[:execute 'FloatermToggle Vifm'<CR>]], {noremap = true, silent = false})
vim.api.nvim_set_keymap('t','<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle Vifm'<CR>]], {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n','<leader>tf', [[:execute 'FloatermNew --name=Vifm vifmrun' fnameescape(getcwd())<CR>]], {noremap = true, silent = false})
-- vim.api.nvim_set_keymap('n','<leader>tt', [[:execute 'FloatermToggle Vifm'<CR>]], {noremap = true, silent = false})
-- vim.api.nvim_set_keymap('t','<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle Vifm'<CR>]], {noremap = true, silent = false})
-- vim.cmd[[autocmd User FloatermOpen nnoremap tt :FloatermToggle<CR>]]
-- vim.api.nvim_set_keymap('t','<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle vifm'<CR>]], {noremap = true, silent = true})

-- vim.api.nvim_set_keymap('n','<leader>tr', ':FloatermToggle<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('t','<leader>tr', [[<C-\><C-n>:FloatermToggle<CR>]], {noremap = true, silent = true})

--##########################################################################################################
-- fm-nvim --------------------------------------------------------------------------------------------------------------
--###################################################################################################################
-- vim.api.nvim_set_keymap('n','<leader>tr', ':Vifm<CR>', {noremap = true})

-- Move selected line / block of text in visual mode
-- vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})
-- vim-move plugin                                                 
-- vim.api.nvim_command('let g:move_key_modifier = "C"')

--##########################################################################################################
-- vim illuminate --------------------------------------------------------------------------------------------------------------
--###################################################################################################################
-- :echo synIDattr(synID(line("."), col("."), 1), "name")
-- Time in milliseconds (default 0)
-- vim.g.Illuminate_delay = 0
-- let g:Illuminate_delay = 0
vim.g.Illuminate_ftblacklist = {'nerdtree', 'fern', 'fzf','nvimtree'}
vim.g.Illuminate_highlightUnderCursor = 0
vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>ll', [[:exe 'IlluminationToggle!' | echo "Illuminate toggled"<cr>]], {noremap = true})
-- Don't highlight word under cursor (default: 1)
vim.g.Illuminate_highlightUnderCursor = 1
vim.cmd[[
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END
]]
-- require('nvim_comment').setup(
-- {
--   -- lINTERS PREFER COMMENT AND LINE TO HAVE A SPACE IN BETWEEN MARKERS
--   MARKER_PADDING = TRUE,
--   -- SHOULD COMMENT OUT EMPTY OR WHITESPACE ONLY LINES
--   COMMENT_EMPTY = FALSE,
--   -- sHOULD KEY MAPPINGS BE CREATED
--   CREATE_MAPPINGS = TRUE,
--   -- nORMAL MODE MAPPING LEFT HAND SIDE
--   LINE_MAPPING = "GCC",
--   -- vISUAL/oPERATOR MAPPING LEFT HAND SIDE
--   OPERATOR_MAPPING = "GC"
-- }
-- )

--##########################################################################################################
-- nvim web devicons--------------------------------------------------------------------------------------------------------------
--###################################################################################################################
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 -- default = true;
}

--##########################################################################################################
-- Colorizer setup-----------------------------------------------------------------------------------------------------------------
--###################################################################################################################
local colorizer_cfg = {
	RGB      = true;         -- #RGB hex codes
	RRGGBB   = true;         -- #RRGGBB hex codes
	names    = true;         -- "Name" codes like Blue
	RRGGBBAA = true;        -- #RRGGBBAA hex codes
	-- rgb_fn   = false;        -- CSS rgb() and rgba() functions
	-- hsl_fn   = false;        -- CSS hsl() and hsla() functions
	-- css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	-- css_fn   = false,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode     = 'background'; -- Set the display mode.
}
require'colorizer'.setup( 
	{
		'*' ;
	},
	{colorizer_cfg}
)

vim.api.nvim_set_keymap('n','<leader>clr', '<cmd>ColorizerToggle | echo "Colorizer toggled"<cr>', {noremap = true, silent = true})

--##########################################################################################################
-- Fastfold create text-object ----------------------------------------------------------------------------------------------------
-- (Set in vimscript/plugins/fastfold.vim)
--###################################################################################################################
-- vim.api.nvim_set_keymap('n','zuz', '<Plug>(FastFoldUpdate)', {})
-- vim.g.fastfold_savehook = 1
-- vim.g.fastfold_fold_command_suffixes = {'x','X','a','A','o','O','c','C','r','R','m','M','i','n','N'}
-- vim.g.fastfold_fold_movement_commands = {']z', '[z', 'zj', 'zk'}
-- vim.api.nvim_set_keymap('x','iz',':<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('x','az',':<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>', {noremap = true, silent = true})
-- xnoremap iz :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>
-- xnoremap az :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>
