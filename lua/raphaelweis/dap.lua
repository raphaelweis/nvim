local function dapConfig()
	local kset = vim.keymap.set
	local dap = require('dap')
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
