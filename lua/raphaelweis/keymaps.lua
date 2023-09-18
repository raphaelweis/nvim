-----------------------------
-- Keymaps
-----------------------------
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Go back to normal mode' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keymaps for tabs and window management
vim.keymap.set("n", "<leader>sv", "<C-w>v")         -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s")         -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=")         -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<CMD>close<CR>") -- close current split window
