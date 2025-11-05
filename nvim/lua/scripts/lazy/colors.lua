function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	-- set background
	vim.api.nvim_set_hl(0, "Normal", { bg = "#0d0d0d" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0d0d0d" })

	-- fix background for telescope
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#0d0d0d" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#0d0d0d" })

	-- make inactive split window slightly different
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a1a" })

	-- fix harpoon borders
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#0d0d0d" })

	-- fix lsp and cmp
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "#0d0d0d" })
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2a2a2a" })
	vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "#0d0d0d" })
	vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#0d0d0d" })
	vim.api.nvim_set_hl(0, "CmpBorder", { bg = "#0d0d0d" })

	-- fix background for vim diagnostics
	vim.api.nvim_set_hl(0, "diagnosticVirtualTextError", { bg = "#0d0d0d", fg = "#eb6f92" })
	vim.api.nvim_set_hl(0, "diagnosticVirtualTextWarn", { bg = "#0d0d0d", fg = "#f6c177" })
	vim.api.nvim_set_hl(0, "diagnosticVirtualTextInfo", { bg = "#0d0d0d", fg = "#9ccfd8" })
	vim.api.nvim_set_hl(0, "diagnosticVirtualTextHint", { bg = "#0d0d0d", fg = "#c4a7e7" })
end

return {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebards = "dark",
					floats = "dark",
				},
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon",
				dark_variant = "moon",
				dim_inactive_windows = false,
				extend_background_behind_borders = true,
				disable_background = true,
				enable = {
					terminal = true,
				},
				styles = {
					bold = true,
					italic = false,
				},
			})
			ColorMyPencils()
		end,
	},
}
