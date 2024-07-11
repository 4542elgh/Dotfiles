----------------------------------------------------------------------------------
-- Make Vim default better
----------------------------------------------------------------------------------
return {
	"moll/vim-bbye",
	"kyazdani42/nvim-web-devicons",
	"junegunn/vim-peekaboo",
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "info",
				auto_session_enable_last_session = false,
				auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
				auto_session_enabled = true,
				auto_save_enabled = nil,
				auto_restore_enabled = nil,
				auto_session_use_git_branch = nil,
				-- the configs below are lua only
				bypass_session_save_file_types = nil,
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		end,
		cond = not vim.g.is_workpc,
	},
	{ "asiryk/auto-hlsearch.nvim", config = true },
	{ "ethanholz/nvim-lastplace", config = true },
	{
		"nvim-zh/colorful-winsep.nvim",
		config = function()
			require("colorful-winsep").setup({
				hi = {
					bg = "#323232",
					fg = "#c57825",
				},
			})
		end,
	},
	{
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup({
				ignore_case = true,
			})
			vim.g.lightspeed_no_default_keymaps = true
			nmap("f", "<Plug>Lightspeed_omni_s")
		end,
	},
}
