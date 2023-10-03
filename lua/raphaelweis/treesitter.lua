require('nvim-treesitter.configs').setup {
	auto_install = true,
	highlight = { enable = true },
	indent = {
		enable = true,
		-- The flutter-tools plugins and treesitter indent are in conflict
		-- so we disable it here, and let the plugin handle it.
		disable = { 'dart' },
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
		},
	},
}
