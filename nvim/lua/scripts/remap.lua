vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap("n", "<leader>l", "<C-w>l", { noremap = true, silent = true }) 
vim.api.nvim_set_keymap("n", "<leader>h", "<C-w>h", { noremap = true, silent = true }) 
