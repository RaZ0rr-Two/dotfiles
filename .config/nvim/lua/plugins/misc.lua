------------------------------------------------------------------

vim.api.nvim_set_keymap('n','<leader>kl', ':s/chakkachakkachakka/chakka/e<CR>',{noremap = true, silent = true})
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
vim.api.nvim_set_keymap('n', '<leader>il', [[:exe 'IlluminationToggle!' | echo "Illuminate toggled"<cr>]], {noremap = true})

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
require'colorizer'.setup()

--##########################################################################################################
-- Fastfold create text-object ----------------------------------------------------------------------------------------------------
--###################################################################################################################
vim.api.nvim_set_keymap('n','zuz', '<Plug>(FastFoldUpdate)', {})
vim.g.fastfold_savehook = 1
vim.g.fastfold_fold_command_suffixes = {'x','X','a','A','o','O','c','C','r','R','m','M','i','n','N'}
vim.g.fastfold_fold_movement_commands = {']z', '[z', 'zj', 'zk'}
-- vim.api.nvim_set_keymap('x','iz',':<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('x','az',':<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>', {noremap = true, silent = true})
-- xnoremap iz :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>
-- xnoremap az :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>
