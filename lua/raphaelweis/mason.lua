local function masonConfig()
	require('mason').setup({
		ensure_installed = {
			-- lsp
			'clangd',
			'gopls',
			'nil',

			-- debuggers
			'delve',
			'codelldb',
		}
	})
	require('mason-lspconfig').setup()
	require('mason-nvim-dap').setup({ handlers = {} })
end

return masonConfig
