vim.api.nvim_set_keymap('n', '<leader>ff',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fa',":FzfLua files cwd=~<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fnv',":FzfLua files cwd=~/.config/nvim<CR>",{ noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fa',"<cmd>lua require('fzf-lua').files({ cwd = '~'})<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fbb',"<cmd>lua require('fzf-lua').buffers()<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fbl',"<cmd>lua require('fzf-lua').blines()<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fl',"<cmd>lua require('fzf-lua').lines()<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh',"<cmd>lua require('fzf-lua').help_tags()<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fm',"<cmd>lua require('fzf-lua').man_pages()<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fH',"<cmd>lua require('fzf-lua').command_history()<CR>",{ noremap = true, silent = true })