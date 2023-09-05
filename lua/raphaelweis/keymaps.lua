vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Go back to normal mode' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keymaps for tabs and window management
vim.keymap.set("n", "<leader>sv", "<C-w>v")                                -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s")                                -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=")                                -- make split windows equal width & height
vim.keymap.set("n", "<leader>sm", "<CMD>lua require('maximize').toggle()<CR>") -- maximize current window
vim.keymap.set("n", "<leader>sx", "<CMD>close<CR>")                        -- close current split window

vim.keymap.set("n", "<leader>to", "<CMD>tabnew<CR>")                       -- open new tab
vim.keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>")                     -- close current tab
vim.keymap.set("n", "<leader>tn", "<CMD>tabn<CR>")                         --  go to next tab
vim.keymap.set("n", "<leader>tp", "<CMD>tabp<CR>")                         --  go to previous tab

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
