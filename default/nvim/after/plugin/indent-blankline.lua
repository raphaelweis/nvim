local indent_blankline_setup, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_setup then
	return
end

indent_blankline.setup({
	show_current_context_start = true,
	filetype_exclude = { "markdown", "help" },
})
