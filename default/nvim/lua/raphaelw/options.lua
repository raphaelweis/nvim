-- appearance
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers wrapping cursor line (10 lines)
vim.opt.termguicolors = true -- enable 24-bit RGB color for the UI
vim.opt.background = "dark" -- choose preferred option for the colorscheme (light/dark)
vim.opt.signcolumn = "auto" -- draws a column on the left to display things like breakpoints (auto = only when necessary)
vim.opt.showmode = false -- prevent neovim from displaying current mode since the status line already does it
vim.opt.hlsearch = false -- disable highlighting after search
vim.opt.guicursor = "" -- set cursor to default, which is the terminal's default

-- text editing
vim.opt.tabstop = 4 -- tabs = 2 spaces
vim.opt.shiftwidth = 4 -- indentation = 2 spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true -- copy indent from current line when going to a new line
vim.opt.wrap = true -- automatic line wrapping
vim.opt.iskeyword:append("-") -- include "-" as a word character, meaning string-string is a whole word.
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]]) -- prevent neovim from automatically commenting new lines

-- windows and buffers
vim.opt.splitright = true -- split vertical windows to the right
vim.opt.splitbelow = true -- split horizontal windows to the bottom

-- spell checking
vim.opt.spelllang = { "en", "fr" }
vim.opt.spellfile = os.getenv("VIMCONFDIR") .. "/spell/dictionary.add" -- custom dictionary

-- save all if SIGHUP signal gets sent
vim.opt.autowriteall = true
