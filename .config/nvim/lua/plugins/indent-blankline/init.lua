
--vim.api.nvim_command('let g:indent_blankline_filetype_exclude = {"help", "startify","fernTree"}')
vim.g.indent_blankline_filetype_exclude = {[[help]],"startify", "fern", 'undotree','packer', 'markdown','NvimTree'}
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
-- vim.g.indent_blankline_char = '│'
vim.g.indent_blankline_char_list = {'│', '¦', '┆', '┊'}
-- vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    -- show_end_of_line = true,
    -- space_char_blankline = " ",
    show_trailing_blankline_indent = false,
}

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    -- vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='auto'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap('n', '<F9>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })
