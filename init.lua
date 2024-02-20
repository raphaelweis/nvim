-- Options and Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.filetype_plugin = true
vim.g.filetype_indent = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.colorcolumn = "80"
vim.opt.undofile = true
vim.opt.clipboard:append("unnamedplus")

-- Disable search highlight when pressing escape
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>")

-- Deal with word wrap better
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center screen after moving in half pages
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Lazy Bootstrap
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

-- Lazy configuration
local plugins = {
	"tpope/vim-surround",
	"tpope/vim-fugitive",
	"nvim-lua/plenary.nvim",
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {} },
	{ "numToStr/Comment.nvim", opts = {}, lazy = false },
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "mhartington/formatter.nvim", opts = {} },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "NvimTreeToggle" },
		keys = { { "<leader>e", "<CMD>NvimTreeToggle<CR>" } },
		opts = {},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<CMD><C-U>TmuxNavigateLeft<CR>" },
			{ "<c-j>", "<CMD><C-U>TmuxNavigateDown<CR>" },
			{ "<c-k>", "<CMD><C-U>TmuxNavigateUp<CR>" },
			{ "<c-l>", "<CMD><C-U>TmuxNavigateRight<CR>" },
			{ "<c-\\>", "<CMD><C-U>TmuxNavigatePrevious<CR>" },
		},
	},
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"neovim/nvim-lspconfig",
	"lervag/vimtex",
}
require("lazy").setup(plugins, {})

-- Formatter configuration
require("formatter").setup({
	filetype = {
		c = { require("formatter.filetypes.c").clangformat },
		lua = { require("formatter.filetypes.lua").stylua },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"bash",
		"javascript",
		"vim",
		"markdown",
		"markdown_inline",
	},
	auto_install = true,
	highlight = { enable = true, disable = { "latex" } },
})

-- Cmp configuration
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<TAB>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- LSP configuration
vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.marksman.setup({})
lspconfig.texlab.setup({})
lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
				},
			})
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
})

-- Telescope configuration
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fs", builtin.live_grep)
vim.keymap.set("n", "<leader>fc", builtin.commands)

-- MarkdownPreview Configuration
vim.g.mkdp_page_title = "${name}"
vim.keymap.set("n", "<leader>mp", "<CMD>MarkdownPreview<CR>")

-- Vimtex Configuration
vim.g.vimtex_view_method = "zathura"

-- Cmds
vim.cmd("colorscheme gruvbox")

-- Autocmds
vim.api.nvim_create_augroup("__formatter__", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", { group = "__formatter__", command = ":FormatWrite" })

-- helper function for indentation based on filetype
local function setIndentation(filetype, indent_size)
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			vim.bo.shiftwidth = indent_size
			vim.bo.tabstop = indent_size
		end,
		pattern = filetype,
	})
end
setIndentation("html", 2)
setIndentation("yml", 2)
