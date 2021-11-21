local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'

dashboard.section.header.val = {
	 [[                               __                ]],
	 [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	 [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	 [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	 [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	 [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

dashboard.section.buttons.val = {
	dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
	dashboard.button( "f", "  > Find file", ":FzfLua files<CR>"),
	dashboard.button( "r", "  > Recent"   , ":FzfLua oldfiles<CR>"),
	dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :FzfLua files cwd=~/.config/nvim<CR>"),
	-- dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
}

-- local function footer()
--   local total_plugins = #vim.tbl_keys(packer_plugins)
--   local datetime = os.date("%d-%m-%Y  %H:%M:%S")
--   return total_plugins .. " plugins  " .. datetime
-- end
local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
