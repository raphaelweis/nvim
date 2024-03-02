-- Options and Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.filetype_plugin = true
vim.g.filetype_indent = true

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

vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>", { desc = "Dismiss search highlight" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Go up 1 screen line" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Go down 1 screen line" })
vim.keymap.set("c", "<C-k>", "<C-p>", { desc = "Go up in the vim completion list" })
vim.keymap.set("c", "<C-j>", "<C-n>", { desc = "Go down in the vim completion list" })

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

-- Plugin list
local plugins = {
	"tpope/vim-surround",
	"tpope/vim-fugitive",
	"nvim-lua/plenary.nvim",
	{ "ThePrimeagen/harpoon", branch = "harpoon2" },
	{ "numToStr/Comment.nvim", opts = {} },
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "mhartington/formatter.nvim", opts = {} },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
	"rafamadriz/friendly-snippets",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"neovim/nvim-lspconfig",
	"lervag/vimtex",
}
require("lazy").setup(plugins, {})

-- Fugitive and gitsigns configuration
vim.keymap.set("n", "<leader>;", "<CMD>Git<CR>", { desc = "Open Fugitive recap window" })
vim.keymap.set("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "Commit the staged changes" })
vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>")

-- Harpoon configuration
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():append()
end, { desc = "Add a file to the harpoon list " })
vim.keymap.set("n", "<leader>y", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle harpoon quick menu" })

vim.keymap.set("n", "<leader>u", function()
	harpoon:list():select(1)
end, { desc = "Go to harpoon file (1)" })
vim.keymap.set("n", "<leader>i", function()
	harpoon:list():select(2)
end, { desc = "Go to harpoon file (2)" })
vim.keymap.set("n", "<leader>o", function()
	harpoon:list():select(3)
end, { desc = "Go to harpoon file (3)" })
vim.keymap.set("n", "<leader>p", function()
	harpoon:list():select(4)
end, { desc = "Go to harpoon file (4)" })

-- Snippets configuration
require("luasnip.loaders.from_vscode").lazy_load()

-- Formatter configuration
require("formatter").setup({
	filetype = {
		c = { require("formatter.filetypes.c").clangformat },
		lua = { require("formatter.filetypes.lua").stylua },
		markdown = { require("formatter.filetypes.markdown").prettier },
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
vim.keymap.set("n", "<leader>F", vim.diagnostic.open_float, { desc = "Open the diagnostic in a floating window" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "GOTO previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "GOTO next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Add the diagnostic list to the location list" })
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "GOTO declaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "GOTO definition" })
		vim.keymap.set(
			"n",
			"K",
			vim.lsp.buf.hover,
			{ buffer = ev.buf, desc = "Open documentation in a floating window" }
		)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "GOTO implementation" })
		vim.keymap.set(
			"n",
			"<leader>k",
			vim.lsp.buf.signature_help,
			{ buffer = ev.buf, desc = "Display signature information about the symbol under the cursor" }
		)
		vim.keymap.set(
			"n",
			"<leader>wa",
			vim.lsp.buf.add_workspace_folder,
			{ buffer = ev.buf, desc = "Add the folder at path to the workspace folders" }
		)
		vim.keymap.set(
			"n",
			"<leader>wr",
			vim.lsp.buf.remove_workspace_folder,
			{ buffer = ev.buf, desc = "Remove the folder at path to the workspace folders" }
		)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = ev.buf, desc = "List current workspace folders" })
		vim.keymap.set(
			"n",
			"<leader>D",
			vim.lsp.buf.type_definition,
			{ buffer = ev.buf, desc = "GOTO type definition" }
		)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
		vim.keymap.set(
			{ "n", "v" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			{ buffer = ev.buf, desc = "Display available code actions " }
		)
		vim.keymap.set(
			"n",
			"gr",
			vim.lsp.buf.references,
			{ buffer = ev.buf, desc = "List all references in the quickfix window" }
		)
	end,
})

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.marksman.setup({})
lspconfig.texlab.setup({})
lspconfig.bashls.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.jsonls.setup({})
lspconfig.tsserver.setup({})
vim.lsp.set_log_level("debug")
require("vim.lsp.log").set_format_func(vim.inspect)
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME, "${3rd}/luv/library", "${3rd}/busted/library" },
			},
		},
	},
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
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find project files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find current opened buffers" })
vim.keymap.set("n", "<leader>fm", builtin.keymaps, { desc = "Find all active keymaps" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Search for a string" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Search vim commands" })

-- MarkdownPreview Configuration
vim.g.mkdp_page_title = "${name}"
vim.keymap.set("n", "<leader>mp", "<CMD>MarkdownPreview<CR>", { desc = "Open a preview of the current markdown file" })

-- Vimtex Configuration
vim.g.vimtex_view_method = "zathura"

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
setIndentation("markdown", 2)
