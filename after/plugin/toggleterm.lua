-- toggleterm
local toggleterm_setup, toggleterm = pcall(require, "toggleterm")
if not toggleterm_setup then
	return
end

toggleterm.setup({
	direction = "float",
})

-- keymaps
vim.keymap.set({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<CR>") -- toggle terminal inside neovim (available in normal and terminal mode)
