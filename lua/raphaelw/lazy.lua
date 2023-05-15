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
		"akinsho/bufferline.nvim", -- bufferline with tabs
	},
	{
		"akinsho/toggleterm.nvim", -- pop-up terminal inside neovim
	},
	{
		"andrewferrier/wrapping.nvim", -- for better wrapping in natural text documents
	},
	{
		"catppuccin/nvim", -- colorscheme plugin
    priority = 1000,
	},
  {
    "christoomey/vim-tmux-navigator" -- vim tmux navigation with CTRL + nav
  },
	{
		"elkowar/yuck.vim", -- syntax highlighting for custom lisp like language - see EWW Widgets on github
	},
	{
		"ellisonleao/gruvbox.nvim", -- colorscheme plugin
    priority = 1000,
	},
	{
		"folke/neodev.nvim", -- completion and documentation for lua neovim config and API's
	},
	{
		"folke/tokyonight.nvim", -- colorscheme plugin
    priority = 1000,
	},
	{
		"folke/which-key.nvim", -- pop-up menu that shows possible keybinds after pressing a key
	},
	{
		"goolord/alpha-nvim", -- neovim welcome screen
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"iamcco/markdown-preview.nvim", -- to preview markdown documents
		build = "cd app && npm install",
	},
	{
		"lervag/vimtex", -- for LaTeX documents
	},
	{
		"lewis6991/gitsigns.nvim", -- git decoration on sidebar
	},
	{
		"lukas-reineke/indent-blankline.nvim", -- indent guides (like in vs code)
	},
	{
		"lunarvim/Onedarker.nvim", -- colorscheme plugin
    priority = 1000,
	},
	{
		"mfussenegger/nvim-dap", -- nvim DAP - debug adapter protocol
	},
	{
		"numToStr/Comment.nvim", -- automatically comment lines or blocks of code
	},
	{
		"nvim-lualine/lualine.nvim", -- status line
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim", -- file explorer
		branch = "v2.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
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
		"Pocco81/true-zen.nvim", -- toggle between modes for zen coding
	},
	{
		"rafamadriz/friendly-snippets", -- snippets collections for all filetypes
	},
	{
		"rcarriga/nvim-notify", -- notifications
	},
  {
	  "rose-pine/neovim"
  },
	{
		"sam4llis/nvim-tundra", -- colorscheme plugin
    priority = 1000,
	},
	{
		"Shatur/neovim-session-manager", -- manage sessions in vscode fashion
	},
  {
    "Tastyep/structlog.nvim", -- more structured login messages
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
    "waycrate/swhkd-vim", -- for syntax highlighting in swhkd hotkey daemon conf file
  },
	{
		"windwp/nvim-autopairs", -- automatically insert closing brackets, parenthesis, quotes, etc
	},
	{
		"ziontee113/icon-picker.nvim", -- icon and special character picker
	},

	-- deprecated plugins list (the configuration for those still exists, but they are not in use)
	-- "ahmedkhalf/project.nvim" | project management plugin
}

-- options table
local opts = {}

-- installation
require("lazy").setup(plugins, opts)
