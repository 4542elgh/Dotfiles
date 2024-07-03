--================================================================================
--   __________  _________________ __________________________
--  /_  __/ __ \/ ____/ ____/ ___//  _/_  __/_  __/ ____/ __ \
--   / / / /_/ / __/ / __/  \__ \ / /  / /   / / / __/ / /_/ /
--  / / / _, _/ /___/ /___ ___/ // /  / /   / / / /___/ _, _/
-- /_/ /_/ |_/_____/_____//____/___/ /_/   /_/ /_____/_/ |_|
--================================================================================
----------------------------------------------------------------------------------
-- Require zig, dont use clang from Visual Studio, will error out at some point
----------------------------------------------------------------------------------
return {
	"windwp/nvim-ts-autotag",
	"nvim-treesitter/nvim-treesitter-context",
	"HiPhish/rainbow-delimiters.nvim",
	-- "xiyaowong/nvim-cursorword",
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup({
				hlgroup = "LocalHighlight",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							-- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			--        vim.o.foldtext = ""
			-- vim.o.fillchars = "fold: "

			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim", "vimdoc", "yaml", "python" },
				-- Async install
				-- sync_install = true,
				highlight = { enable = true },
				autotag = { enable = true },
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
				autopairs = {
					enable = true, -- check for autopairs (see nvim-autopairs)
				},
			})
		end,
	},
}
