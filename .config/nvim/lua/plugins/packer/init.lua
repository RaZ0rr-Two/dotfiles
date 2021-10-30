
-- ########################################################
-- 	    All the used plugins 
-- ########################################################

-- local use = require('packer').use
require('packer').startup({

	function(use)
		use 'wbthomason/packer.nvim' -- Package manager

		-- fzf
		-- use '~/.fzf'
		-- use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
		-- use {'junegunn/fzf.vim'}
		use { 'ibhagwan/fzf-lua',
			requires = {'vijaymarupudi/nvim-fzf',
			'kyazdani42/nvim-web-devicons' } -- optional for icons
		}
		-- Auto-pair completion
		use 'windwp/nvim-autopairs' 

		use 'norcalli/nvim-colorizer.lua'

		-- Comment and Uncomment lines
		use 'b3nj5m1n/kommentary'

		-- Better Syntax Support
		-- use 'sheerun/vim-polyglot'

		-- Tab/buffers display and customize
		use 'akinsho/nvim-bufferline.lua'

		-- Statusline
		--    use {
		-- 'glepnir/galaxyline.nvim',
		-- branch = 'main',
		--    }

		-- Add indentation guides even on blank lines
		use 'lukas-reineke/indent-blankline.nvim'

		-- Undo history
		use 'mbbill/undotree'

		-- Add git related info in the signs columns and popups
		use {
			'lewis6991/gitsigns.nvim', 
			requires = { 'nvim-lua/plenary.nvim' },
			config = function() 
				require('gitsigns').setup() 
			end
		}
		use {
			'famiu/feline.nvim',
			requires = 'kyazdani42/nvim-web-devicons',
			-- Enable for default status bar
			-- config = function() 
			--     require('feline').setup()
			-- end
		}
		-- File Browser
		use {
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			-- config = function() require'nvim-tree'.setup {} end
		}
		-- Fern tree viewer
		-- use 'lambdalisue/fern.vim'
		-- use 'lambdalisue/nerdfont.vim'
		-- use 'lambdalisue/fern-renderer-nerdfont.vim'

		-- Startify
		use 'mhinz/vim-startify'

		----------------------------------------------
		-- LSP 
		----------------------------------------------
		-- Folding and extensions
		use 'Konfekt/FastFold'
		use 'zhimsel/vim-stay'

		-- Collection of configurations for built-in LSP client
		use 'neovim/nvim-lspconfig'

		-- Autocompletion plugin
		use {
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-cmdline',
				'hrsh7th/cmp-nvim-lsp',
				'saadparwaiz1/cmp_luasnip',
				'hrsh7th/cmp-buffer',
				-- 'hrsh7th/cmp-emoji',
				-- 'hrsh7th/cmp-calc',
				'hrsh7th/cmp-path',
				"hrsh7th/cmp-nvim-lua"
			}
		}

		-- Snippets plugin
		use{
			"L3MON4D3/LuaSnip",
			requires = { "rafamadriz/friendly-snippets" },
		}

		-- Lsp better functioning. 
		use  {
			'RishabhRD/nvim-lsputils',
			requires = {'RishabhRD/popfix'}
		}

		-- Show lightbulb for diagnostics
		use 'kosayoda/nvim-lightbulb'

		-- Signature help plug
		use 'ray-x/lsp_signature.nvim'

		-- Higlight occurances of word under cursor
		use 'RRethy/vim-illuminate'

		----------------------------------------------
		-- THEMES
		----------------------------------------------

		-- Colorscheme set
		use 'RRethy/nvim-base16'
		use 'folke/lsp-colors.nvim'
		-- Onedark
		-- use 'joshdick/onedark.vim' 

		-- Gruvbox
		-- use 'morhetz/gruvbox'
		if packer_bootstrap then
			require('packer').sync()
		end

	end,

	config = {
		profile = {
			enable = true,
			threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
		}
	}

})
