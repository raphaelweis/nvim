return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'hrsh7th/nvim-cmp',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- [[ Configure nvim-cmp ]]
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
		require('luasnip.loaders.from_vscode').lazy_load()
		luasnip.config.setup {
		}

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert {
				['<Alt-j>'] = cmp.mapping.select_next_item(),
				['<Alt-k>'] = cmp.mapping.select_prev_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete {},
				['<CR>'] = cmp.mapping.confirm {
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
		})

		-- Language servers configuration
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			vim.keymap.set("n", "gR", "<CMD>Telescope lsp_references<CR>", opts)

			opts.desc = "Format current file"
			vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)

			opts.desc = "Go to declaration"
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

			opts.desc = "Show LSP definitions"
			vim.keymap.set("n", "gD", "<CMD>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			vim.keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			vim.keymap.set("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			vim.keymap.set("n", "<leader>D", "<CMD>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		end

		-- Configure language servers
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})


		-- Configure format on save
		-- Create an augroup that is used for managing our formatting autocmds.
		--      We need one augroup per client to make sure that multiple clients
		--      can attach to the same buffer without interfering with each other.
		local _augroups = {}
		local get_augroup = function(client)
			if not _augroups[client.id] then
				local group_name = 'lsp-format-' .. client.name
				local id = vim.api.nvim_create_augroup(group_name, { clear = true })
				_augroups[client.id] = id
			end

			return _augroups[client.id]
		end

		-- Whenever an LSP attaches to a buffer, we will run this function.
		-- See `:help LspAttach` for more information about this autocmd event.
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
			-- This is where we attach the autoformatting for reasonable clients
			callback = function(args)
				local client_id = args.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				local bufnr = args.buf
				-- Only attach to clients that support document formatting
				if not client.server_capabilities.documentFormattingProvider then
					return
				end
				-- Tsserver usually works poorly.
				if client.name == 'tsserver' then
					return
				end
				-- Create an autocmd that will run *before* we save the buffer.
				--  Run the formatting command for the LSP that has just attached.
				vim.api.nvim_create_autocmd('BufWritePre', {
					group = get_augroup(client),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format {
							async = false,
							filter = function(c)
								return c.id == client.id
							end,
						}
					end,
				})
			end,
		})
	end,
}
