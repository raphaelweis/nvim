local function neodevConfig()
	require('neodev').setup({
		library = {
			plugins = {
				'nvim-dap-ui'
			},
			types = true,
		},
	})
end

return neodevConfig
