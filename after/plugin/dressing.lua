local dressing_setup, dressing = pcall(require, "dressing")
if not dressing_setup then
	return
end

dressing.setup({
	select = {
		enable = true,
		backend = { "telescope" },
		telescope = require("telescope.themes").get_cursor({}),
	},
})
