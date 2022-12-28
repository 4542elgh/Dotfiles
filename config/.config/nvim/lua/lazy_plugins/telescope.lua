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
    -- use {
    --     "nvim-telescope/telescope-frecency.nvim",
    --     requires = {"kkharji/sqlite.lua"}
    -- }

    "4542elgh/telescope-smb-unc.nvim",
    "4542elgh/telescope-scratch-run.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cond = not vim.g.is_workpc
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function ()
            require("telescope").setup({
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
                },
            })
        end,
        -- cond = not vim.g.is_workpc
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.0",
        dependencies = {{"nvim-lua/plenary.nvim"}},
        config = function()
            function vimwiki()
                require("telescope.builtin").find_files({
                    search_dirs = {
                        vim.fn.stdpath("config") .. "\\vimwiki"
                    }
                })
            end
            nmap("<Leader>a", ":Telescope live_grep<CR>")
            nmap("<Leader>ff", ":Telescope find_files<CR>")
            nmap("<Leader>fr", ":Telescope oldfiles<CR>")
            nmap("<Leader>fw", ":lua vimwiki()<CR>")
            nmap("<Leader>fn", ":Telescope file_browser<CR>")
            nmap("<Leader>b", ":Telescope buffers<CR>")
            abbrev("reg", ":Telescope registers<CR>")
            abbrev('lang', 'Telescope filetypes')
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
                        -- n = {
                        -- }
                    }
                },
            })
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
            require('telescope').load_extension('smb_unc')
            require('telescope').load_extension('scratch_run')
            -- require("telescope").load_extension("frecency")
        end,
        -- cond = not vim.g.is_workpc
    }
}
