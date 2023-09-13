-----------------------------
-- Options
-----------------------------
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Configure tabstop and shiftwidth
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Set colored column at 80 characters
vim.opt.colorcolumn = '80'

-- Enable relative line numbers
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-----------------------------
-- Keymaps
-----------------------------
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Go back to normal mode' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keymaps for tabs and window management
vim.keymap.set("n", "<leader>sv", "<C-w>v")         -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s")         -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=")         -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<CMD>close<CR>") -- close current split window

-----------------------------
-- Plugins
-----------------------------
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
	'nvim-lua/plenary.nvim', -- utility functions required by some plugins

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

	-- Adds git releated signs to the gutter, as well as utilities for managing changes
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	-- Colorscheme
	{
		'ellisonleao/gruvbox.nvim',
		priority = 1000,
		config = function()
			require('gruvbox').setup({
				transparent_mode = true,
				italic = {
					strings = false,
					comments = true,
					operators = false,
					folds = true,
				},
			})
			vim.cmd.colorscheme('gruvbox')
		end,
	},

	-- Show indent guides, even on blanklines
	{
		'lukas-reineke/indent-blankline.nvim',
		opts = { show_trailing_blankline_indent = false }
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {} },

	require("raphaelweis.harpoon"),
	require("raphaelweis.telescope"),
	require("raphaelweis.treesitter"),
	require("raphaelweis.lsp"),
}, {})
