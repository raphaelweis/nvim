local function dapConfig()
	local dap = require('dap')

	dap.defaults = {
		dart = {
			exception_breakpoints = {}, -- this disables the breakpoints on exceptions for the dart language
		},
	}

	-- Keybinds
	local kset = vim.keymap.set
	kset('n', '<leader>b', dap.toggle_breakpoint)
	kset('n', '<F5>', dap.continue)
	kset('n', '<F6>', dap.step_over)
	kset('n', '<F7>', dap.step_into)
	kset('n', '<F7>', dap.step_out)
	kset('n', '<F1>', dap.repl.toggle)
end
return {
	'mfussenegger/nvim-dap',
	dependencies = {
		{
			'leoluz/nvim-dap-go',
			opts = {},
		},
	},
	config = dapConfig
}
