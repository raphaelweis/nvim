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

-- [[ helper function for indentation based on filetype ]]
local function setIndentation(filetype, shiftwidth, softtabstop, tabstop, expandtab)
	vim.api.nvim_create_autocmd('FileType', {
		callback = function()
			vim.bo.shiftwidth = shiftwidth
			vim.bo.softtabstop = softtabstop
			vim.bo.tabstop = tabstop
			vim.bo.expandtab = expandtab
		end,
		pattern = filetype,
	})
end

-- Set 2 spaces for these filetypes
setIndentation('dart', 2, 2, 2, 1)
setIndentation('c', 2, 2, 2, 1)
setIndentation('nix', 2, 2, 2, 1)
setIndentation('html', 2, 2, 2, 1)
