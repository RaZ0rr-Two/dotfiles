vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]])
-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"lua",
		"python",
		"rust",
		"html",
		"css",
		"toml",
		-- for `nvim-treesitter/playground`
		"query",
	},
	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- init_selection = 'gnn',
			init_selection = '<cr>',
			node_incremental = '<tab>',
			scope_incremental = 'grc',
			node_decremental = '<s-tab>',
		},
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
				["agc"] = "@comment.outer",
				["igc"] = "@comment.inner",

				-- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
				},
        -- Leader mappings, dups for whichkey
        ["ab"] = "@block.outer"      ,
        ["ib"] = "@block.inner"      ,
        ["af"] = "@function.outer"   ,
        ["if"] = "@function.inner"   ,
        ["<leader>ac"] = "@call.outer"       ,
        ["<leader>ic"] = "@call.inner"       ,
        ["ao"] = "@conditional.outer",
        ["io"] = "@conditional.inner",
        ["al"] = "@loop.outer"       ,
        ["il"] = "@loop.inner"       ,
        ["ap"] = "@parameter.outer"  ,
        ["ip"] = "@parameter.inner"  ,
        ["is"] = "@scopename.inner"  ,
        ["as"] = "@statement.outer"  ,

      },
    },
		swap = {
      enable = true,
      swap_next = {
        ["<leader>tss"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>tsS"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
		lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>tsd"] = "@function.outer",
        ["<leader>tsD"] = "@class.outer",
      },
    },
  },
}