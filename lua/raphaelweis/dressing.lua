require("dressing").setup({
	select = {
		backend = { "builtin", "telescope", "fzf_lua", "fzf", "nui" },
		builtin = {
			relative = "cursor",
			mappings = {
				["q"] = "Close",
				["<Esc>"] = "Close",
				["<C-c>"] = "Close",
			},
		},
	},
})
