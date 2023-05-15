local session_manager_setup, session_manager = pcall(require, "session_manager")
if not session_manager_setup then
	return
end

session_manager.setup({
	autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
})

-- keymaps
vim.keymap.set("n", "<C-S>", "<cmd>SessionManager save_current_session<CR>") -- save current session
