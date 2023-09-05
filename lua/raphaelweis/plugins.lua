-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- Git related plugins
	'tpope/vim-fugitive',

	-- Seamless navigation between tmux and neovim
	'christoomey/vim-tmux-navigator',

	-- Autoclosing of brackets and others
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {},
	},

	-- LSP Configuration & Plugins
	{
		'neovim/nvim-lspconfig',
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},

	-- Adds git releated signs to the gutter, as well as utilities for managing changes
	{
		'lewis6991/gitsigns.nvim',
	},

	-- Colorscheme
	{
		'ellisonleao/gruvbox.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'gruvbox'
		end,
	},

	-- Show indent guides, even on blanklines
	{
		'lukas-reineke/indent-blankline.nvim',
		opts = {
			show_trailing_blankline_indent = false,
		},
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim',         opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},

	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
}, {})
