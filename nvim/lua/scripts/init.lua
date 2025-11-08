require("scripts.set")
require("scripts.remap")
require("scripts.lazy_init")

local augroup = vim.api.nvim_create_augroup
local scriptsGroup = augroup("scripts", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- remove trailing whitespace before saving file
autocmd({ "BufWritePre" }, {
	group = scriptsGroup,
	pattern = "*",
	callback = function(args)
		vim.cmd([[%s/\s\+$//e]])
		require("conform").format({ bufnr = args.buf })
	end,
})

--autocmd("BufEnter", {
--	group = scriptsGroup,
--	callback = function()
--		if vim.bo.filetype == "python" then
--			pcall(vim.cmd.colorscheme, "rose-pine-moon")
--		else
--			pcall(vim.cmd.colorscheme, "tokyonight-night")
--		end
--	end,
--})

autocmd("LspAttach", {
	group = scriptsGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			-- vim.lsp.buf.definition()
			require("telescope.builtin").lsp_definitions()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<leader>dn", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "<leader>dp", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrm_winsize = 25
