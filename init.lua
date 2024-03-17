-- Options and Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.filetype_plugin = true
vim.g.filetype_indent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.colorcolumn = "80"
vim.opt.undofile = true
vim.opt.textwidth = 80
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
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-fugitive",
	"nvim-lua/plenary.nvim",
	{ "sainnhe/gruvbox-material", priority = 1000 },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				component_separators = { left = "|", right = "|" },
				section_separators = "",
			},
		},
	},
	{ "ThePrimeagen/harpoon", branch = "harpoon2" },
	{ "numToStr/Comment.nvim", opts = {} },
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		event = {
			"BufReadPre G:\\My Drive\\A\\**.md", -- Windows vault.
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			workspaces = { { name = "A", path = "G:\\My Drive\\A" } },
			completion = { nvim_cmp = true, min_chars = 2 },
			preferred_link_style = "wiki",
			open_app_foreground = false,
			picker = { name = "telescope.nvim" },
			attachments = {
				img_folder = "assets/imgs", -- This is the default
				img_text_func = function(client, path)
					path = client:vault_relative_path(path) or path
					return string.format("![%s](%s)", path.name, path)
				end,
			},
		},
	},
	{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
	{ "folke/neodev.nvim", opts = { lspconfig = false } },
	"rafamadriz/friendly-snippets",
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"stevearc/conform.nvim",
	"lervag/vimtex",
	"windwp/nvim-ts-autotag",
}
require("lazy").setup(plugins, {})

-- colorscheme setup
vim.g.gruvbox_material_foreground = "original"
vim.cmd("colorscheme gruvbox-material")

-- Fugitive and gitsigns configuration
vim.keymap.set("n", "<leader>;", "<CMD>Git<CR>", { desc = "Open Fugitive recap window" })
vim.keymap.set("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "Commit the staged changes" })
vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>")

-- Harpoon configuration
local harpoon = require("harpoon")

harpoon:setup({})

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
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang_format" },
		go = { "gofmt" },
		javascript = { "prettier" },
		tex = { "latexindent" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "jq" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
})

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
	modules = {},
	sync_install = false,
	ignore_install = {},
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
	additional_vim_regex_highlighting = { "markdown" },
	autotag = { enable = true },
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
		{ name = "buffer", option = { keyword_pattern = [[\k\+]] } },
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

-- For debug purposes (uncomment if needed)
-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					-- 	checkThirdParty = false,
					library = { vim.env.VIMRUNTIME, "${3rd}/luv/library", "${3rd}/busted/library" },
				},
			},
		},
	},
} -- set custom settings for some servers (otherwise go with the defaults).
require("mason").setup()
require("mason-tool-installer").setup({})
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
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

-- Vimtex configuration
vim.g.vimtex_view_method = "sioyek"

-- Autocmds
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
