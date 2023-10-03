require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"jsonls",
		"lua_ls",
		"clangd",
		"gopls",
	},
	automatic_installation = true,
})
require('mason-nvim-dap').setup({
	ensure_installed = {
		"delve",
		"cpptools",
	},
	handlers = {}
})
require('mason-tool-installer').setup({
	ensure_installed = {
		"prettier",
	},
})
