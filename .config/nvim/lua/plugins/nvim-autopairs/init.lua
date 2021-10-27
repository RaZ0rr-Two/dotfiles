

local cfg = {
		disable_filetype = {"fzf-lua", "TelescopePrompt" , "vim" },
		-- ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "") -- default value
		-- enable_moveright = true -- default value
		-- enable_afterquote = true  -- default value (add bracket pairs after quote)
		-- enable_check_bracket_line = true  --- default value (check bracket in same line)
		-- check_ts = false --default value
}

require('nvim-autopairs').setup({

disable_filetype = {"fzf", "TelescopePrompt" , "vim" },
fast_wrap = {
		    map = '<M-e>',
		    chars = { '{', '[', '(', '"', "'" },
		    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
		    offset = 0, -- Offset from pattern match
		    end_key = '$',
		    keys = 'qwertyuiopzxcvbnmasdfghjkl',
		    check_comma = true,
		    hightlight = 'Search'
		},
})

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = true, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
})

-- require('nvim-autopairs').setup({
--   disable_filetype = { "TelescopePrompt" , "vim" },
-- })
