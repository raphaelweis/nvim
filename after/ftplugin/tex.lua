vim.cmd([[set spell]])

-- vimtex keybindings
vim.api.nvim_set_keymap("n", "<leader>ll", ":VimtexCompile<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>lv", ":VimtexView<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>lt", ":VimtexToggle<CR>", { noremap = true })

-- format using par
vim.api.nvim_set_keymap("v", "<leader>fmt", ":!par -w80<CR>", { noremap = true })
