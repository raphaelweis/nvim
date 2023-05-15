-- Enable Vimtex
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
	options = {
		"-pdf",
		"-interaction=nonstopmode",
		"-synctex=1",
		"-file-line-error",
		"-shell-escape",
	},
}
vim.g.vimtex_syntax_conceal_disable = 1

-- Set options
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "vimtex#fold#expr()"
vim.opt.foldtext = "vimtex#fold#text()"
vim.opt.conceallevel = 2
vim.opt.concealcursor = "niv"
vim.opt.completeopt = "menuone,noinsert,noselect"
