return {
	{ "windwp/nvim-autopairs", config = true },
	{ "kylechui/nvim-surround", config = true },
	{ "mg979/vim-visual-multi" },
	{
		"bbjornstad/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	},
	-- {
	--     'wfxr/minimap.vim',
	--     -- build = "cargo install --locked code-minimap",
	--     config = function ()
	--         vim.g.minimap_width = 10
	--     end
	-- },
	-- {
	--     "iamcco/markdown-preview.nvim",
	--     build = "cd app && npm install",
	--     setup = function()
	--         vim.g.mkdp_filetypes = {"markdown"}
	--     end,
	--     cmd = "MarkdownPreview",
	--     cond = executable("npm")
	-- },
	-- {
	--     'barrett-ruth/import-cost.nvim',
	--     build = 'sh install.sh yarn',
	--     cond = executable("yarn")
	-- },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- {
	-- 	"s1n7ax/nvim-terminal",
	-- 	config = function()
	-- 		require("nvim-terminal").setup({
	-- 			window = {
	-- 				height = 7,
	-- 			},
	-- 			toggle_keymap = "<leader>t",
	-- 		})
	-- 	end,
	-- },
	{
		"voldikss/vim-floaterm",
	},
	{
		"alvan/vim-closetag",
		config = function()
			vim.g.closetag_filenames = "*.html,*.xhtml,*.vue,*.jsx"
			vim.g.closetag_emptyTags_caseSensitive = 1
		end,
	},
	{
		"SmiteshP/nvim-navic",
		config = function()
			vim.o.winbar = "      %{%v:lua.require'nvim-navic'.get_location()%}"
			require("nvim-navic").setup({
				highlight = true,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		config = function()
			local highlight = {
				"VertSplit",
			}

			local highlight_rainbow = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				-- Cannot put in colorbuddy, this load before colorbuddy
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			require("ibl").setup({
				indent = { highlight = highlight },
				whitespace = {
					highlight = highlight,
					remove_blankline_trail = false,
				},
				scope = { highlight = highlight_rainbow },
			})

			vim.g.rainbow_delimiters = { highlight = highlight_rainbow }
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{
		"mbbill/undotree",
		-- event = "VimEnter",
		config = function()
			nmap("<Leader>u", ":UndotreeToggle<CR>")
			vim.api.undolevel = 500
			vim.cmd([[
                if has("persistent_undo")
                    let target_path = expand(stdpath("config") . "\undodir")
                    if !isdirectory(target_path)
                        call mkdir(target_path, "p", 0700)
                    endif
                    let &undodir=target_path
                    set undofile
                endif
            ]])
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			nmap("<Leader>n", ":NvimTreeToggle<CR>")

			local function tree_mapping(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "l", api.tree.change_root_to_node, opts("CD"))
				vim.keymap.set("n", "c", api.fs.create, opts("Create File Or Directory"))
			end

			require("nvim-tree").setup({
				respect_buf_cwd = true,
				sort_by = "case_sensitive",
				update_focused_file = {
					enable = true,
				},
				view = {
					adaptive_size = true,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
				on_attach = tree_mapping,
			})
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>m",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},
}
