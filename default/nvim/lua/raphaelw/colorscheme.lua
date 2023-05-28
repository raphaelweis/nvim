local function setColorScheme()
  vim.o.background = "dark"
  vim.cmd([[colorscheme onedark]])
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = setColorScheme,
})
