local function servers()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- Language servers configuration
	-- import lspconfig plugin
	local lspconfig = require("lspconfig")
	local on_attach = function(_, bufnr)
		local opts = { buffer = bufnr }
		vim.keymap.set("n", "gR", "<CMD>Telescope lsp_references<CR>", opts)
		vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", "<CMD>Telescope lsp_definitions<CR>", opts)
		vim.keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)
		vim.keymap.set("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "gpd", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "gnd", vim.diagnostic.goto_next, opts)
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
end

local function formatOnSave()
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
end

local function lspConfig()
	servers()
	formatOnSave()
end

return {
	'neovim/nvim-lspconfig',
	config = lspConfig
}
