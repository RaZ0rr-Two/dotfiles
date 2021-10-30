
-- lsp-kind alternative
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local function get_kind(kind_item)
	local prsnt, lspkind = pcall(require, "lspkind")
	if not prsnt then
		return kind_icons
	else
		return lspkind.presets.default[kind_item]
	end
end

-- Helper Functions
-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--     return false
--   end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Setup nvim-cmp.
local cmp = require'cmp'
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
			expand = function(args)
					-- For `vsnip` user.
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

					-- For `luasnip` user.
					require('luasnip').lsp_expand(args.body)

					-- For `ultisnips` user.
					-- vim.fn["UltiSnips#Anon"](args.body)
			end,
    },
    formatting = {
			format = function(entry, vim_item)
					vim_item.kind = string.format("%s %s", get_kind(vim_item.kind), vim_item.kind)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Luasnp]",
						buffer = "[Buf]",
						nvim_lua = "[Lua]",
						path = "[Pth]",
						calc = "[Clc]",
						emoji = "[Emj]",
					})[entry.source.name]

					return vim_item
			end,
    },
    mapping = {
			-- ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			-- ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			-- ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			-- ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
			-- ['<CR>'] = cmp.mapping.confirm({
			-- 		behavior = cmp.ConfirmBehavior.Replace,
			-- 		select = true,
			-- }),
			['<CR>'] = cmp.mapping({
				i = cmp.mapping.confirm({ select = true }),
				c = cmp.mapping.confirm({ select = false }),
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
    },
    sources = {
	-- this also affects the order in the completion menu
			{ name = "nvim_lsp" },
			-- For vsnip user.
			-- { name = 'vsnip' },
			-- For luasnip user.
			{ name = 'luasnip' },
			-- For ultisnips user.
			-- { name = 'ultisnips' },
			-- { name = "calc" },
			{ name = "path" },
			{ name = "buffer" },
			-- { name = "nvim_lua" },
			-- { name = "emoji" },
    }
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
