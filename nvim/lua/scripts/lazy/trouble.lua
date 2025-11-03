return {
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				use_diagnostic_signs = false,
			})

			vim.keymap.set("n", "<leader>tt", function()
				require("trouble").toggle("diagnostics")
			end)

			vim.keymap.set("n", "<leader>tn", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end)

			vim.keymap.set("n", "<leader>tp", function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end)
		end,
	},
}
