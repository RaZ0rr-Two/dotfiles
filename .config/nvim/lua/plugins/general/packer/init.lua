-- ########################################################
-- Bootstrap ( CHeck if "packer.nvim" exists or not ) 
-- ########################################################

lua require('plugins/packer/check')

-- ########################################################
-- All the used plugins 
-- ########################################################

-- local use = require('packer').use
require('packer').startup({

	function(use)
		use 'wbthomason/packer.nvim' -- Package manager

		----------------------------------------------
		-- THEMES
		----------------------------------------------

		-- Colorscheme set ---------------------------
		use 'RRethy/nvim-base16'
		use 'folke/lsp-colors.nvim'

		-- Onedark -----------------------------------
		use 'navarasu/onedark.nvim'
		-- use 'joshdick/onedark.vim' 

		-- Gruvbox ------------------------------------
		-- use 'morhetz/gruvbox'

		-- --------------------------------------------
		-- General 
		-- --------------------------------------------

		-- fzf ----------------------------------------
		-- use '~/.fzf'
		-- use = { 'junegunn/fzf', run = './install --bin', }
		-- use {'junegunn/fzf.vim'}
		use { 'ibhagwan/fzf-lua',
			requires = {
			'vijaymarupudi/nvim-fzf',
			'kyazdani42/nvim-web-devicons'
			} -- optional for icons
		}
		
		-- Startup time measure -----------------------
		use 'dstein64/vim-startuptime'

		-- Undo history -------------------------------
		use 'mbbill/undotree'

		-- File Browser -------------------------------
		use 'voldikss/vim-floaterm'
		use 'is0n/fm-nvim'
		-- use {
		-- 	'kyazdani42/nvim-tree.lua',
		-- 	requires = 'kyazdani42/nvim-web-devicons',
			-- config = function() require'nvim-tree'.setup {} end
		-- }

		-- use {
		-- 	'vifm/vifm.vim',
		-- 	requires = 'is0n/fm-nvim'
		-- }
		-- Fern tree viewer
		-- use 'lambdalisue/fern.vim'
		-- use 'lambdalisue/nerdfont.vim'
		-- use 'lambdalisue/fern-renderer-nerdfont.vim'

		-- Autocompletion plugin -----------------------
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

		-- Snippets plugin -------------------------------
		use{
			"L3MON4D3/LuaSnip",
			requires = { "rafamadriz/friendly-snippets" },
		}

		-- Auto-pair completion --------------------------
		use 'windwp/nvim-autopairs' 

		-- Comment and Uncomment lines -------------------
		use 'b3nj5m1n/kommentary'

		-- Better Syntax Support
		-- use 'sheerun/vim-polyglot'

		-- -----------------------------------------------
		-- UI/Look
		-- -----------------------------------------------

		-- Tab/buffers display and customize -------------
		use { 
			'akinsho/nvim-bufferline.lua', 
			requires = 'kyazdani42/nvim-web-devicons',
			-- config = function() 
				-- require("bufferline").setup{} 
			-- end
		}

		-- Show colours around hex code ------------------
		use 'norcalli/nvim-colorizer.lua'

		-- Statusline ------------------------------------
		use {
			'famiu/feline.nvim',
			requires = 'kyazdani42/nvim-web-devicons',
			-- Enable for default status bar
			-- config = function() 
			--     require('feline').setup()
			-- end
		}
		-- use {
		-- 	'glepnir/galaxyline.nvim',
		-- 	branch = 'main',
		-- }

		-- Add indentation guides even on blank lines -----
		use 'lukas-reineke/indent-blankline.nvim'

		-- Add git related info in the signs columns and popups
		use {
			'lewis6991/gitsigns.nvim', 
			requires = { 'nvim-lua/plenary.nvim' },
			config = function() 
				require('gitsigns').setup() 
			end
		}

		-- StartScreen -----------------------------------
		use {
				'goolord/alpha-nvim',
				-- config = function ()
				-- 		require'alpha'.setup(require'alpha.themes.dashboard'.opts)
				-- end
		}
		-- Startify
		-- use 'mhinz/vim-startify'

		--------------------------------------------------
		-- LSP 
		--------------------------------------------------

		-- Collection of configurations for built-in LSP client
		use 'neovim/nvim-lspconfig'

		use({ "jose-elias-alvarez/null-ls.nvim",
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
    })

		-- Lsp better functioning. -----------------------
		use  {
			'RishabhRD/nvim-lsputils',
			requires = {'RishabhRD/popfix'}
		}

		-- Show lightbulb for diagnostics ----------------
		use 'kosayoda/nvim-lightbulb'

		-- Signature help plug ---------------------------
		use 'ray-x/lsp_signature.nvim'

		-- Higlight occurances of word under cursor ------
		use 'RRethy/vim-illuminate'

		--------------------------------------------------
		-- Treesitter
		--------------------------------------------------

		-- Highlight, edit, and navigate code using a fast incremental parsing library
		use 'nvim-treesitter/nvim-treesitter'

		-- Additional textobjects for treesitter ---------
		use 'nvim-treesitter/nvim-treesitter-textobjects'

		-- Folding faster --------------------------------
		use 'Konfekt/FastFold'
		-- use 'zhimsel/vim-stay'

	end,

	config = {
		profile = {
			enable = true,
			threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
		display = {
			open_fn = require('packer.util').float,
			-- open_fn = function()
			-- 	return require('packer.util').float({ border = 'single' })
			-- end
		}
	}

})
