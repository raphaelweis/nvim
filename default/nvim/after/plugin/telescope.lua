-- telescope
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

telescope.setup({
	defaults = {
		-- winblend = 100,
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		initial_mode = "insert",
		sorting_strategy = "ascending",
		path_display = { truncate = 3 },
		layout_config = {
			prompt_position = "top",
		},
	},
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({})
    }
  }
})

telescope.load_extension("fzf") -- load fzf extension
telescope.load_extension("ui-select") -- load ui-select extension

-- keymaps
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>") -- fuzzy finder
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope find_files hidden=true<CR>") -- fuzzy finder with hidden files
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>") -- open projects
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>") -- view open buffers
vim.keymap.set("n", "<leader>fs", "<cmd>SessionManager load_session<CR>") -- open session
