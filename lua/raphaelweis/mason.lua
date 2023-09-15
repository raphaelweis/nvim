local function masonConfig()
	require('mason').setup({
		ensure_installed = {
			-- lsp
			'clangd',
			'gopls',

			-- debuggers
			'delve',
			'codelldb',
		}
	})
	require('mason-nvim-dap').setup({ handlers = {} })
	require('mason-lspconfig').setup()
end

return {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'jay-babu/mason-nvim-dap.nvim',
	},
	config = masonConfig
}
