-- leader key definition
vim.g.mapleader = " " -- define space as leader key

-- general keymaps
vim.keymap.set("i", "jk", "<ESC>") -- use jk to exit insert mode
vim.keymap.set("n", "<leader>nh", "<cmd>noh<CR>") -- remove highlighting after search
vim.keymap.set("n", "<leader>quit", "<cmd>wqa!<CR>") -- quit neovim

-- buffer, window and tab management
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>") -- go to next buffer
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>") -- go to previous buffer
vim.keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>") -- delete current buffer

vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>") -- close current split window

vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>") -- move the cursor to the adjacent top window
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>") -- move the cursor to the adjacent bottom window
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>") -- move the cursor to the adjacent left window
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>") -- move the cursor to the adjacent right window

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") --  go to previous tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") -- close current tab

-- spell checking
vim.keymap.set("n", "<leader>ww", "<cmd>set spell!<CR>") -- toggle spell checking
