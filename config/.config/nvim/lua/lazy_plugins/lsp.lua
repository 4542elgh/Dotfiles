--================================================================================
--     __   _____ ____
--    / /  / ___// __ \
--   / /   \__ \/ /_/ /
--  / /______/ / ____/
-- /_____/____/_/
--================================================================================
-- KEEP THE ORDER THIS WAY for LSP to work correctly, hopefully with lazy.nvim we dont need to keep order this way
return {
	"wilriker/gcode.vim",
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("lint").linters_by_ft = {
				lua = { "luacheck" },
				javascript = { "eslint" },
				sql = { "sqlfluff" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettier" },
					sql = { "sqlfmt" },
				},
				format = {
					async = true,
				},
				-- formatters = {
				-- 	sqlfmt = {
				-- 		args = { "$FILENAME" },
				-- 	},
				-- },
				log_level = vim.log.levels.DEBUG,

				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { lsp_format = "fallback" }
				end,
			})

			vim.api.nvim_create_user_command("ConformFormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("ConformFormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"rshkarin/mason-nvim-lint",
			"zapling/mason-conform.nvim",
			"neovim/nvim-lspconfig",
			"arkav/lualine-lsp-progress",
		},
		config = function()
			local lspZero = require("lsp-zero")
			local navic = require("nvim-navic")
			lspZero.preset("recommended")
			lspZero.setup()

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})

			-- !!! If you use Mason to install typescript-language-server
			-- !!! You will also need to use npm to install typescript-language-server
			-- !!! npm install typescript-language-server
			require("lspconfig").lua_ls.setup({
				on_attach = function(client, bufnr)
					navic.attach(client, bufnr)
				end,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
		config = function()
			require("cmp").setup({
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						symbol_map = { Codeium = "" },
					}),
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- Snippets
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			-- This is required to get LuaSnip to work
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
					-- Make tab behave differently based on cmp or snippet
					["<Tab>"] = cmp.mapping(function(fallback)
						-- Cycle cmp
						if cmp.visible() then
							cmp.select_next_item()
						-- Cycle luasnip placeholders
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "codeium" },
				}, {
					{ name = "buffer" },
				}),
				window = {
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					},
					completion = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						-- winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
					},
				},
			})
			require("luasnip.loaders.from_vscode").load({ paths = vim.fn.stdpath("config") .. "\\snippets" })
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("vimwiki", { "markdown" })
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		config = function()
			require("cmp").setup.cmdline(":", {
				sources = { { name = "cmdline" } },
			})
		end,
	},
}
