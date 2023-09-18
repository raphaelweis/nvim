local function gitsignsConfig()
	require('gitsigns').setup({
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
	})
end

return gitsignsConfig
