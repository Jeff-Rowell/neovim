return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"windwp/nvim-ts-autotag",
	},

	config = function()
		local lspconfig = require("lspconfig")

		require("conform").setup({})

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		require("fidget").setup({})
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
				"tailwindcss",
				"basedpyright",
				"htmx",
				"templ",
				"ruff",
				"pylsp",
				"rust_analyzer",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["htmx"] = function()
					lspconfig.htmx.setup({
						filetypes = { "html", "gohtml", "templ", "go" },
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								format = {
									enable = true,
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
								diagnostics = {
									workspaceDelay = 0,
									workspaceEvent = "OnSave",
								},
							},
						},
					})
				end,
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								diagnosticsMode = "workspace",
								expandWorkspaceToModule = true,
								analyses = {
									unusedparams = true,
									shadow = true,
								},
								staticcheck = true,
								diagnosticsDelay = "0s",
							},
						},
					})
				end,
				["basedpyright"] = function()
					lspconfig.basedpyright.setup({
						capabilities = capabilities,
						settings = {
							basedpyright = {
								analysis = {
									autoSearchPaths = true,
									diagnosticMode = "openFilesOnly",
									useLibraryCodeForTypes = true,
									typeCheckingMode = "basic",
									autoImportCompletions = true,
									extraPaths = { "/opt/interview" },
									diagnosticSeverityOverrides = {
										reportUnknownMemberType = "none",
									},
								},
							},
						},
					})
				end,
				["pylsp"] = function()
					lspconfig.pylsp.setup({
						capabilities = capabilities,
						settings = {
							pylsp = {
								plugins = {
									pycodestyle = { enabled = false },
									mccabe = { enabled = false },
									pyflakes = { enabled = false },
									pylint = { enabled = false },
									rope_autoimport = {
										enabled = true,
										memory = true,
									},
									jedi_completion = { enabled = true },
								},
							},
						},
					})
				end,
				["tailwindcss"] = function()
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
							"heex",
						},
					})
				end,
				["rust_analyzer"] = function()
					lspconfig.rust_analyzer.setup({
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								cargo = { allFeatures = true },
								check = { command = "clippy", features = "all" },
							},
						},
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			virtual_text = {
				prefix = "■",
				spacing = 4,
				format = function(diagnostic)
					return string.format("%s", diagnostic.message)
				end,
			},
		})
	end,
}
