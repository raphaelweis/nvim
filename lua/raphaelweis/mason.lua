local function masonConfig()
	require('mason').setup()
	require('mason-lspconfig').setup()
	require('mason-nvim-dap').setup()
end

return {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'jay-babu/mason-nvim-dap.nvim',
	},
	config = masonConfig
}
