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

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- keymaps
local kset = vim.keymap.set
local t = require('telescope.builtin')
local small_dropdown = require('telescope.themes').get_dropdown({ previewer = false })
local telescope_search = function() t.current_buffer_fuzzy_find(small_dropdown) end
local find_hidden_files = function() t.find_file({ hidden = true }) end

kset('n', '<leader>?', t.oldfiles)
kset('n', '<leader>/', telescope_search)
kset('n', '<leader>fc', t.commands)
kset('n', '<leader>fb', t.buffers)
kset('n', '<leader>fg', t.git_files)
kset('n', '<leader>ff', t.find_files)
kset('n', '<leader>fh', find_hidden_files)
kset('n', '<leader>sw', t.grep_string)
kset('n', '<leader>fs', t.live_grep)
kset('n', '<leader>fd', t.diagnostics)
