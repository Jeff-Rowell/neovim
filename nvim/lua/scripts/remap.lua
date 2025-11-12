vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- these allow moving the selected lines up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

-- allows joining multiple lines to the same line without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- centered scrolling to keep the cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- centered search keeping the next search result at the center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--  keeps the cursor position when reformatting long text/comments
vim.keymap.set("n", "=ap", "ma=ap'a")

-- this allows replacing text with what's in the register, without replacing what's in the register
vim.keymap.set("x", "<leader>p", '"_dP')

-- yanks to the system clipboard instead of a vim register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- deletes text without copying it to any register
vim.keymap.set({ "n", "v" }, "<leader>D", '"_d')

-- ignores accidental Q presses to avoid going into Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- next and previous hotkeys for quickfix/location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- searches for and replaces the current word for the whole file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- makes the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- golang error handling snippets
-- if err, return it
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- assert there is no error
vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')

-- if there is an error, log fatal
vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')

-- if there is an error, log it to custom logger with cursor properly placed
vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.Error("error", "error", err)<Esc>F.;i')

-- reloads and sources the current file
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- animations to show off
vim.keymap.set("n", "<leader>car", function()
	require("cellular-automaton").start_animation("make_it_rain")
end)

vim.keymap.set("n", "<leader>cag", function()
	require("cellular-automaton").start_animation("game_of_life")
end)

-- switch left and right between split windows
vim.api.nvim_set_keymap("n", "<leader>l", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<C-w>h", { noremap = true, silent = true })
