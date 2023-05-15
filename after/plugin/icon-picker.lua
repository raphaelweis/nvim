local icon_picker_setup, icon_picker = pcall(require, "icon-picker")
if not icon_picker_setup then
	return
end

icon_picker.setup({
	disable_legacy_commands = true,
})

vim.keymap.set("n", "<leader>ii", "<cmd>IconPickerNormal nerd_font<CR>")
