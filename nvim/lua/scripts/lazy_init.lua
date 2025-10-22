local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "scripts.lazy",
    change_detection = { notify = false }
})
