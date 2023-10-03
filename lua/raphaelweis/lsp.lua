local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Language servers configuration
-- import lspconfig plugin
local lspconfig = require('lspconfig')
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	local t = require('telescope.builtin')
	vim.keymap.set('n', 'gr', t.lsp_references, opts)
	vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gD', t.lsp_definitions, opts)
	vim.keymap.set('n', 'gi', t.lsp_implementations, opts)
	vim.keymap.set('n', 'gt', t.lsp_type_definitions, opts)
	vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', 'gpd', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', 'gnd', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

-- Configure language servers
lspconfig['lua_ls'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize 'vim' global
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.stdpath('config') .. '/lua'] = true,
				},
			},
		},
	},
})
lspconfig['gopls'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig['clangd'].setup({
	cmd = {
		'clangd',
		'--fallback-style=Google',
	},
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig['nil_ls'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		['nil'] = {
			formatting = {
				command = { 'nixpkgs-fmt' },
			},
			nix = {
				flake = {
					autoArchive = true,
				},
			},
		},
	},
})
lspconfig['tsserver'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig['html'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig['cssls'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig['jsonls'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- This plugin will automatically configure dartls as well
require('flutter-tools').setup({
	widget_guides = {
		enabled = true,
	},
	lsp = {
		capabilities = capabilities,
		on_attach = on_attach
	},
	debugger = {
		enabled = true,
		run_via_dap = true,
	},
	dev_log = {
		enabled = false -- we disable this because we can see the logs in dapui
	}
})
