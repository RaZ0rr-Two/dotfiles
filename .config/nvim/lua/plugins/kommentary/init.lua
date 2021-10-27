
-- require('kommentary.config').use_extended_mappings()

vim.api.nvim_set_keymap("n", "<leader>cic", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_motion_increase", {})
vim.api.nvim_set_keymap("v", "<leader>ci", "<Plug>kommentary_visual_increase", {})
vim.api.nvim_set_keymap("n", "<leader>cdc", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_motion_decrease", {})
vim.api.nvim_set_keymap("v", "<leader>cd", "<Plug>kommentary_visual_decrease", {})

-- vim.g.kommentary_create_default_mappings = false
-- vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
-- vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
-- vim.api.nvim_set_keymap("v", "<leader>c", "<Plug>kommentary_visual_default", {})

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
		-- use_consistent_indentation = true -- default value
})

require('kommentary.config').configure_language("c++", {
    single_line_comment_string = "//",
    multi_line_comment_strings = {"/*", "*/"},
})
