-- installation for the lazy.nvim plugin manager (pulled straight from the documentation)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- plugins table
local plugins = {
  {
    "christoomey/vim-tmux-navigator" -- vim tmux navigation with CTRL + nav
  },
	{
		"iamcco/markdown-preview.nvim", -- to preview markdown documents
		build = "cd app && npm install",
	},
	{
		"lervag/vimtex", -- for LaTeX documents
	},
  {
    "navarasu/onedark.nvim", -- color scheme
    priority = 1000,
  },
	{
		"numToStr/Comment.nvim", -- automatically comment lines or blocks of code
	},
	{
		"nvim-telescope/telescope.nvim", -- fuzzy finder for neovim
		tag = "0.1.1",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter", -- better syntax highlighting (among other things)
		build = ":TSUpdate",
		dependencies = { "windwp/nvim-ts-autotag", "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	{
		"tpope/vim-fugitive", -- full git integration
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{
		"windwp/nvim-autopairs", -- automatically insert closing brackets, parenthesis, quotes, etc
	},
}

-- options table
local opts = {}

-- installation
require("lazy").setup(plugins, opts)
