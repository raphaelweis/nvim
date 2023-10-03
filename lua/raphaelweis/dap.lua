local dap = require('dap')
local dapui = require('dapui')

dapui.setup({
	controls = {
		enabled = false,
	},
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.25,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
				{
					id = "watches",
					size = 0.25,
				},
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{
					id = "repl",
					size = 1,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local bg_color = '#403d52'
vim.api.nvim_set_hl(0, 'red', { fg = '#fd504f' })
vim.api.nvim_set_hl(0, 'green', { fg = '#99fb98', bg = bg_color })
vim.api.nvim_set_hl(0, 'bg', { bg = bg_color })


vim.fn.sign_define('DapBreakpoint', {
	text = '',
	texthl = 'red',
	linehl = 'DapBreakpoint',
	numhl = 'DapBreakpoint',
})
vim.fn.sign_define('DapBreakpointCondition',
	{
		text = '',
		texthl = 'red',
		linehl = 'DapBreakpoint',
		numhl = 'DapBreakpoint',
	})
vim.fn.sign_define('DapBreakpointRejected',
	{
		text = '',
		texthl = 'red',
		linehl = 'DapBreakpoint',
		numhl = 'DapBreakpoint',
	})
vim.fn.sign_define('DapStopped', {
	text = '',
	texthl = 'green',
	linehl = 'bg',
	numhl = 'green',
})

-- [[ Default client options ]]
-- Ignore unhandled exceptions in dart
dap.defaults.dart.exception_breakpoints = {}

-- [[ Custom plugins ]]
require('dap-go').setup()

-- Keybinds
local kset = vim.keymap.set
kset('n', '<leader>b', dap.toggle_breakpoint)
kset('n', '<F5>', dap.continue)
kset('n', '<F6>', dap.step_over)
kset('n', '<F7>', dap.step_into)
kset('n', '<F8>', dap.step_out)
kset('n', '<F1>', dapui.toggle)
