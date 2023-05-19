local function setColorScheme()
  vim.o.background = "light"
  vim.cmd([[colorscheme gruvbox]])
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = setColorScheme,
})
