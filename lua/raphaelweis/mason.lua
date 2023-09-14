local function masonConfig()
	require('mason').setup()
	require('mason-lspconfig').setup({
		handlers = {}
	})
	require('mason-nvim-dap').setup({
		handlers = {},
	})
end

return {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'jay-babu/mason-nvim-dap.nvim',
	},
	config = masonConfig
}
