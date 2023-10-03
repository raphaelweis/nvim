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
		config = function() require('raphaelweis.gruvbox') end,
	},
	{
		'troydm/zoomwintab.vim',
		config = function() require('raphaelweis.zoomwintab') end,
	},
	{ 'nvim-lua/plenary.nvim' },
	{ 'tpope/vim-fugitive' },
	{ 'christoomey/vim-tmux-navigator' },
	{
		'nvim-tree/nvim-tree.lua',
		config = function() require('raphaelweis.tree') end,
	},
	{
		'windwp/nvim-autopairs',
		config = function() require('raphaelweis.autopairs') end,
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function() require('raphaelweis.gitsigns') end,
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		config = function() require('raphaelweis.indent_blankline') end,
	},
	{
		'folke/neodev.nvim',
		config = function() require('raphaelweis.neodev') end,
	},
	{
		'numToStr/Comment.nvim',
		config = function() require('raphaelweis.comment') end,
	},
	{
		'ThePrimeagen/harpoon',
		config = function() require('raphaelweis.harpoon') end,
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
		config = function() require('raphaelweis.telescope') end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = function() require('raphaelweis.treesitter') end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'rafamadriz/friendly-snippets',
		},
		config = function() require('raphaelweis.cmp') end,
	},
	{
		'williamboman/mason.nvim',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'jay-babu/mason-nvim-dap.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
		},
		config = function() require('raphaelweis.mason') end,
	},
	{
		'mhartington/formatter.nvim',
		config = function() require('raphaelweis.formatter') end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'akinsho/flutter-tools.nvim',
		},
		config = function() require('raphaelweis.lsp') end,
	},
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'leoluz/nvim-dap-go',
		},
		config = function() require('raphaelweis.dap') end,
	},
}, {})
