-- nvim-treesitter
local treesitter_configs_setup, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_configs_setup then
	return
end

treesitter_configs.setup({
	ensure_installed = {
		"c",
		"lua",
		"java",
		"php",
		"vim",
		"html",
		"css",
		"javascript",
		"json",
		"markdown",
		"markdown_inline",
		"hocon",
	}, -- ensure these treesitter parsers are installed
	highlight = {
		enable = true,
		disable = { "latex" },
	}, -- enable better syntax highlighting
	indent = { enable = true }, -- enable indentation for the '=' operator (experimental)
	autotag = { enable = true }, -- automatic closing for html tags
	context_commentstring = { -- choose the right comments depending on the language - useful when working with languages embedded into each other
		enable = true,
	},
})

local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true }) -- recognize *.conf files for hocon parser
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{ group = hocon_group, pattern = "*/resources/*.conf", command = "set ft=hocon" }
)
