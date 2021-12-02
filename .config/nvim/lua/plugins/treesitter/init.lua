
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
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<cr>',
      -- init_selection = 'gnn',
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
  },
}
