return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets" },

	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		local c = ls.choice_node
		local fmt = require("luasnip.extras.fmt").fmt

		require("luasnip.loaders.from_vscode").lazy_load()
		ls.filetype_extend("javascript", { "jsdoc" })

		-- Python snippets
		ls.add_snippets("python", {
			-- Basic function with docstring
			s(
				"def",
				fmt(
					[[
                def {}({}):
                    {}
            ]],
					{
						i(1, "function_name"),
						i(2, "args"),
						i(0, "pass"),
					}
				)
			),

			-- Async function
			s(
				"adef",
				fmt(
					[[
                async def {}({}):
                    {}
            ]],
					{
						i(1, "function_name"),
						i(2, "args"),
						i(0, "pass"),
					}
				)
			),

			-- Class with __init__
			s(
				"class",
				fmt(
					[[
                class {}:
                    def __init__(self{}):
                        {}
            ]],
					{
						i(1, "ClassName"),
						i(2, ", args"),
						i(0, "pass"),
					}
				)
			),
		})
		-- Rust snippets
		ls.add_snippets("rust", {
			-- Basic function
			s(
				"fn",
				fmt(
					[[
        fn {}({}) -> {} {{
            {}
        }}
        ]],
					{
						i(1, "function_name"),
						i(2, ""),
						i(3, "()"),
						i(0, "todo!()"),
					}
				)
			),

			-- Async function
			s(
				"afn",
				fmt(
					[[
        async fn {}({}) -> {} {{
            {}
        }}
        ]],
					{
						i(1, "function_name"),
						i(2, ""),
						i(3, "()"),
						i(0, "todo!()"),
					}
				)
			),

			-- Struct
			s(
				"st",
				fmt(
					[[
        struct {} {{
            {}
        }}
        ]],
					{
						i(1, "Name"),
						i(0, ""),
					}
				)
			),

			-- Enum
			s(
				"en",
				fmt(
					[[
        enum {} {{
            {}
        }}
        ]],
					{
						i(1, "Name"),
						i(0, ""),
					}
				)
			),

			-- impl block
			s(
				"impl",
				fmt(
					[[
        impl {} {{
            {}
        }}
        ]],
					{
						i(1, "Name"),
						i(0, ""),
					}
				)
			),

			-- impl trait
			s(
				"impltr",
				fmt(
					[[
        impl {} for {} {{
            {}
        }}
        ]],
					{
						i(1, "Trait"),
						i(2, "Type"),
						i(0, ""),
					}
				)
			),

			-- Result return type
			s(
				"res",
				fmt([[Result<{}, {}>]], {
					i(1, "Ok"),
					i(2, "Err"),
				})
			),

			-- match expression
			s(
				"mat",
				fmt(
					[[
        match {} {{
            {} => {},
            _ => {},
        }}
        ]],
					{
						i(1, "value"),
						i(2, "pattern"),
						i(3, "result"),
						i(0, "()"),
					}
				)
			),
		})

		-- expands the snippet
		vim.keymap.set({ "i" }, "<C-f>f", function()
			ls.expand()
		end, { silent = true })

		-- jumps to the next position within the snippet
		vim.keymap.set({ "i", "s" }, "<C-f>;", function()
			ls.jump(1)
		end, { silent = true })

		-- jumps to the previous position within the snippet
		vim.keymap.set({ "i", "s" }, "<C-f>,", function()
			ls.jump(-1)
		end, { silent = true })

		-- cycles through snippet options
		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
	end,
}
