
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

--vim.api.nvim_command('let g:indent_blankline_filetype_exclude = {"help", "startify","fernTree"}')
vim.g.indent_blankline_filetype_exclude = {[[help]],"startify", "fern", 'undotree','packer', 'markdown','NvimTree','alpha'}
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
-- vim.g.indent_blankline_char = '│'
vim.g.indent_blankline_char_list = {'│', '¦', '┆', '┊'}
-- vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_char_highlight = 'LineNr'
-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_trailing_blankline_indent = false,
		buftype_exclude = {"terminal"},
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
    -- show_current_context = true,
    -- show_current_context_start = true,
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

vim.api.nvim_set_keymap('n', '<leader>il', '<cmd>IndentBlanklineToggle! | echo "Indent line toggled"<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><F9>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })
