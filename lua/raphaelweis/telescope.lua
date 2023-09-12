local function telescopeConfig()
	require('telescope').setup {
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
		},
	}
	pcall(require('telescope').load_extension, 'fzf')
end

local function fuzBuffers()
	require('telescope.builtin').buffers()
end
local function fuzSearch()
	require('telescope.builtin')
		.current_buffer_fuzzy_find(require('telescope.themes')
			.get_dropdown({ previewer = false }))
end
local function fuzGitFiles()
	require('telescope.builtin').git_files()
end
local function fuzFiles()
	require('telescope.builtin').find_files()
end
local function fuzHiddenFiles()
	require('telescope.builtin').find_files({ hidden = true })
end
local function fuzGrepString()
	require('telescope.builtin').grep_string()
end
local function fuzLiveGrep()
	require('telescope.builtin').live_grep()
end
local function fuzDiagnostics()
	require('telescope.builtin').diagnostics()
end


return {
	-- See `:help telescope` and `:help telescope.setup()`
	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable('make') == 1
				end,
			},
		},
		keys = {
			{ '<leader>/',  fuzSearch,      mode = 'n' },
			{ '<leader>fb', fuzBuffers,     mode = 'n' },
			{ '<leader>ff', fuzFiles,       mode = 'n' },
			{ '<leader>fh', fuzHiddenFiles, mode = 'n' },
			{ '<leader>fg', fuzGitFiles,    mode = 'n' },
			{ '<leader>fw', fuzGrepString,  mode = 'n' },
			{ '<leader>fs', fuzLiveGrep,    mode = 'n' },
			{ '<leader>fd', fuzDiagnostics, mode = 'n' },
		},
		config = telescopeConfig,
	},
}
