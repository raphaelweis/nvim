local true_zen_setup, true_zen = pcall(require, "true-zen")
if not true_zen_setup then
	return
end

true_zen.setup({
	modes = {
		ataraxis = {
			minimum_writing_area = {
				width = 90,
			},
			quit_untoggles = false,
		},
	},
})

-- keymaps
vim.keymap.set("n", "<leader>za", "<cmd>TZAtaraxis<CR>") -- toggle ataraxis zen mode
