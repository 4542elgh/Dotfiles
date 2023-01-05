--================================================================================
--   ______________    ___________ __________  ____  ______
--  /_  __/ ____/ /   / ____/ ___// ____/ __ \/ __ \/ ____/
--   / / / __/ / /   / __/  \__ \/ /   / / / / /_/ / __/   
--  / / / /___/ /___/ /___ ___/ / /___/ /_/ / ____/ /___   
-- /_/ /_____/_____/_____//____/\____/\____/_/   /_____/   
--================================================================================
----------------------------------------------------------------------------------
-- Require cmake
----------------------------------------------------------------------------------
return {
    "4542elgh/telescope-smb-unc.nvim",
    "4542elgh/telescope-scratch-run.nvim",
    "4542elgh/telescope-youtube-mpv.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
        'prochri/telescope-all-recent.nvim',
        dependencies = "kkharji/sqlite.lua",
        config = function()
            require('telescope-all-recent').setup({
                vim.cmd("let g:sqlite_clib_path = 'C:/Users/mliu/AppData/Local/nvim/bin/sqlite3.dll'")
            })
        end
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cond = not vim.g.is_workpc,
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.0",
        dependencies = {"nvim-lua/plenary.nvim"},
        keys = {
            {"<Leader>a" , ":Telescope live_grep<CR>"},
            {"<Leader>ff", ":Telescope find_files<CR>"},
            {"<Leader>fr", ":Telescope oldfiles<CR>"},
            {"<Leader>fw", ":lua vimwiki()<CR>"},
            {"<Leader>fn", ":Telescope file_browser<CR>"},
            {"<Leader>b" , ":Telescope buffers<CR>"}
        },
        config = function()
            function vimwiki()
                require("telescope.builtin").find_files({
                    search_dirs = {
                        vim.fn.stdpath("config") .. "\\vimwiki"
                    }
                })
            end
            abbrev("reg" , "Telescope registers<CR>")
            abbrev('lang', "Telescope filetypes<CR>")
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-d>"] = actions.delete_buffer,
                            ["<esc>"] = actions.close,
                        },
                    }
                },
                extensions = {
                    file_browser = {
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                            },
                            ["n"] = {
                              -- your custom normal mode mappings
                            },
                        },
                    },
                    scratch_run = {
                        custom_compilers = {
                            lua = {
                                name = "lua",
                                cmd = ":w !jit"
                            }
                        }
                    }
                },
            })
            if not vim.g.is_workpc then
                require("telescope").load_extension("fzf")
            end
            require("telescope").load_extension("file_browser")
            require('telescope').load_extension('smb_unc')
            require('telescope').load_extension('scratch_run')

        end,
    }
}
