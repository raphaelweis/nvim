local function dapConfig()
	local dap = require('dap')
	local dapui = require('dapui')

	dapui.setup({
		controls = {
			enabled = false,
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

	dap.defaults = {
		dart = {
			-- this disables the breakpoints on exceptions for the dart language
			exception_breakpoints = {},
		},
		-- if I remove this then the debugging with nvim-dap-go won't work
		go = {},
	}

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

	require('dap-go').setup()

	-- Keybinds
	local kset = vim.keymap.set
	kset('n', '<leader>b', dap.toggle_breakpoint)
	kset('n', '<F5>', dap.continue)
	kset('n', '<F6>', dap.step_over)
	kset('n', '<F7>', dap.step_into)
	kset('n', '<F7>', dap.step_out)
	kset('n', '<F1>', dapui.toggle)
end

return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'leoluz/nvim-dap-go',
	},
	config = dapConfig,
}
