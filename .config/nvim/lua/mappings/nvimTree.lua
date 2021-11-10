vim.cmd([[
nnoremap <leader>tt :NvimTreeFindFileToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>
nnoremap <leader>tf :NvimTreeToggle<CR>
]])

-- Move deleted items to Trash folder (see trash-cli)
function NvimTreeTrash()
	local lib = require('nvim-tree.lib')
	local node = lib.get_node_at_cursor()
	local trash_cmd = "trash "

	local function get_user_input_char()
		local c = vim.fn.getchar()
		return vim.fn.nr2char(c)
	end

	print("Trash "..node.name.." ? y/n")

	if (get_user_input_char():match('^y') and node) then
		vim.fn.jobstart(trash_cmd .. node.absolute_path, {
			detach = true,
			on_exit = function (job_id, data, event) lib.refresh_tree() end,
		})
	end

	vim.api.nvim_command('normal :esc<CR>')
end

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- default mappings
local list = {
	{ key = {"<CR>", "o", "<2-LeftMouse>", "l"}, cb = tree_cb("edit") },
	{ key = {"<2-RightMouse>", "<C-]>", "h"},    cb = tree_cb("cd") },
	{ key = {"-"},                            cb = tree_cb("dir_up") },
	{ key = "<C-v>",                        cb = tree_cb("vsplit") },
	{ key = "<C-x>",                        cb = tree_cb("split") },
	{ key = "<C-t>",                        cb = tree_cb("tabnew") },
	{ key = "<",                            cb = tree_cb("prev_sibling") },
	{ key = ">",                            cb = tree_cb("next_sibling") },
	{ key = "P",                            cb = tree_cb("parent_node") },
	{ key = "<BS>",                         cb = tree_cb("close_node") },
	{ key = "<S-CR>",                       cb = tree_cb("close_node") },
	{ key = "<Tab>",                        cb = tree_cb("preview") },
	{ key = "K",                            cb = tree_cb("first_sibling") },
	{ key = "J",                            cb = tree_cb("last_sibling") },
	{ key = "I",                            cb = tree_cb("toggle_ignored") },
	{ key = "za",                           cb = tree_cb("toggle_dotfiles") },
	{ key = "R",                            cb = tree_cb("refresh") },
	{ key = "a",                            cb = tree_cb("create") },
	{ key = "d",                            cb = ":lua NvimTreeTrash()<CR>" },
	{ key = "D",                            cb = tree_cb("remove") },
	{ key = "cw",                           cb = tree_cb("rename") },
	{ key = "cW",                           cb = tree_cb("full_rename") },
	{ key = "x",                            cb = tree_cb("cut") },
	{ key = "yy",                            cb = tree_cb("copy") },
	{ key = "p",                            cb = tree_cb("paste") },
	{ key = "gy",                            cb = tree_cb("copy_name") },
	{ key = "Y",                            cb = tree_cb("copy_path") },
	{ key = "gY",                           cb = tree_cb("copy_absolute_path") },
	{ key = "[c",                           cb = tree_cb("prev_git_item") },
	{ key = "]c",                           cb = tree_cb("next_git_item") },
	{ key = "gb",                           cb = tree_cb("system_open") },
	{ key = "q",                            cb = tree_cb("close") },
	{ key = "g?",                           cb = tree_cb("toggle_help") },
}

require'nvim-tree'.setup {
	view = {
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = true,
			-- list of mappings to set on the tree manually
			list = list
		}
	}
}
