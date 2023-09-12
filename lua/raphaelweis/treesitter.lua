return {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup {
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				'c',
				'cpp',
				'go',
				'lua',
				'python',
				'rust',
				'tsx',
				'typescript',
				'vimdoc',
				'vim',
				'dart',
				'dockerfile',
				'yaml',
				'toml',
			},
			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<c-space>',
					node_incremental = '<c-space>',
					scope_incremental = '<c-s>',
					node_decremental = '<M-space>',
				},
			},
		}
	end
}
