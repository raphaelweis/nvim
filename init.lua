require('raphaelweis.options')
require('raphaelweis.keymaps')

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
	{
		'ellisonleao/gruvbox.nvim',
		priority = 1000,
		config = require('raphaelweis.gruvbox'),
	},
	{ 'nvim-lua/plenary.nvim' },
	{ 'tpope/vim-fugitive' },
	{ 'christoomey/vim-tmux-navigator' },
	{
		'windwp/nvim-autopairs',
		config = require('raphaelweis.autopairs'),
	},
	{
		'lewis6991/gitsigns.nvim',
		config = require('raphaelweis.gitsigns'),
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		config = require('raphaelweis.indent_blankline')
	},
	{
		'folke/neodev.nvim',
		config = require('raphaelweis.neodev'),
	},
	{
		'numToStr/Comment.nvim',
		config = require('raphaelweis.comment'),
	},
	{
		'ThePrimeagen/harpoon',
		config = require('raphaelweis.harpoon'),
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function() return vim.fn.executable 'make' == 1 end,
			},
		},
		config = require('raphaelweis.telescope'),
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = require('raphaelweis.treesitter')
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'rafamadriz/friendly-snippets',
		},
		config = require('raphaelweis.cmp')
	},
	{
		'williamboman/mason.nvim',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'jay-babu/mason-nvim-dap.nvim',
		},
		config = require('raphaelweis.mason'),
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'akinsho/flutter-tools.nvim',
		},
		config = require('raphaelweis.lsp'),
	},
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'leoluz/nvim-dap-go',
		},
		config = require('raphaelweis.dap'),
	},
}, {})
