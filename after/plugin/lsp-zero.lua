local lsp_setup, lsp = pcall(require, "lsp-zero")
if not lsp_setup then
  return
end

local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
  return
end

local friendly_snippets_setup, friendly_snippets = pcall(require, "luasnip.loaders.from_vscode")
if not friendly_snippets_setup then
  return
end

lsp = lsp.preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false,
  })
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = true })
  vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = true })
  vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { buffer = true })
end)

lsp.ensure_installed({
  "bashls",
  "clangd",
  "csharp_ls",
  "cmake",
  "cssls",
  "diagnosticls",
  "gopls",
  "gradle_ls",
  "html",
  "jsonls",
  "jdtls",
  "tsserver",
  "ltex",
  "lua_ls",
  "marksman",
  "phpactor",
  "pyright",
  "rust_analyzer",
  "sqlls",
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
friendly_snippets.lazy_load()

lsp.setup()

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = {
    ["<TAB>"] = cmp.mapping.select_next_item(),         -- next suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(),         -- next suggestion (for consistency)
    ["<C-k>"] = cmp.mapping.select_prev_item(),         -- previous suggestion
    ["<C-Space>"] = cmp.mapping.complete(),             -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(),                    -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.)
  }
})
