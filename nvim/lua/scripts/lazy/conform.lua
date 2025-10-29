return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()

			local tools = {
				"stylua",
				"goimports",
				"prettier",
				"autopep8",
				"isort",
			}

			local registry = require("mason-registry")

			-- Ensure registry is ready
			registry.refresh(function()
				for _, tool in ipairs(tools) do
					local ok, p = pcall(registry.get_package, tool)
					if ok and not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 1000,
					lsp_format = "never",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					python = { "isort", "autopep8" },
					terraform = { "terraform_fmt" },
					ansible = { "ansible-lint" },
				},
				formatters = {
					terraform_fmt = {
						command = "terraform",
						args = { "fmt", "-" },
						stdin = true,
					},
					["ansible-lint"] = {
						args = { "--fix", "-" },
						stdin = true,
					},
				},
			})

			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ bufnr = 0 })
			end)
		end,
	},
}
