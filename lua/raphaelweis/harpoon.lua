local kset = vim.keymap.set
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

kset('n', '<leader>a', mark.add_file)
kset('n', '<leader>u', ui.toggle_quick_menu)
kset('n', '<leader>h', function() ui.nav_file(1) end)
kset('n', '<leader>j', function() ui.nav_file(2) end)
kset('n', '<leader>k', function() ui.nav_file(3) end)
kset('n', '<leader>l', function() ui.nav_file(4) end)
