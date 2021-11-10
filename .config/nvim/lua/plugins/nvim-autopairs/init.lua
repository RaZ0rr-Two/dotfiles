
-- local cfg = {
-- 		disable_filetype = {"fzf-lua", "TelescopePrompt" , "vim" },
		-- ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "") -- default value
		-- enable_moveright = true -- default value
		-- enable_afterquote = true  -- default value (add bracket pairs after quote)
		-- enable_check_bracket_line = true  --- default value (check bracket in same line)
		-- check_ts = false --default value
-- }

require('nvim-autopairs').setup({
	disable_filetype = {"fzf","TelescopePrompt","vim","NvimTree" },
	ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
	-- fast_wrap = {},
	fast_wrap = {
		map = '<M-e>',
		chars = { '{', '[', '(', '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
		offset = 0, -- Offset from pattern match
		end_key = '$',
		keys = 'qwertyuiopzxcvbnmasdfghjkl',
		check_comma = true,
		hightlight = 'Search',
		highlight_grey='Comment'
	},
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } } ) )
-- require('nvim-autopairs').setup({
--   disable_filetype = { "TelescopePrompt" , "vim" },
-- })
