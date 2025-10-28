return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
        local ls = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
        ls.filetype_extend("javascript", { "jsdoc" })
        -- expands the snippet
        vim.keymap.set({"i"}, "<C-f>f", function() ls.expand() end, {silent = true})

        -- jumps to the next position within the snippet
        vim.keymap.set({"i", "s"}, "<C-f>;", function() ls.jump(1) end, {silent = true})

        -- jumps to the previous position within the snippet
        vim.keymap.set({"i", "s"}, "<C-f>,", function() ls.jump(-1) end, {silent = true})

        -- cycles through snippet options (i.e., logging options)
        vim.keymap.set({"i", "s"}, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})
    end,
}
