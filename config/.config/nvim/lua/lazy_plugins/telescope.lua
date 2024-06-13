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
local telescope_config = {
    "4542elgh/telescope-smb-unc.nvim",
    "4542elgh/telescope-scratch-run.nvim",
    "4542elgh/telescope-youtube-mpv.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.8",
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
            -- Windows cannot build fzf-native without cmake which isnt installed by default
            if vim.g.has_fzf then
                require("telescope").load_extension("fzf")
            end
            require("telescope").load_extension("file_browser")
            require('telescope').load_extension('smb_unc')
            require('telescope').load_extension('scratch_run')

        end,
    },
}

-- FZF not working on windows when first cloning the repo, need cmake from Visual Studio C++ (look at individual component, one should say C++ CMake)
-- Add cmake to path with C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe
-- Build will trigger on Install/Update
if vim.g.has_cmake then
    vim.g.has_fzf = true
    table.insert(telescope_config,
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        }
    )
end

if vim.g.is_windows and vim.fn.filereadable(vim.fn.stdpath('config') .. vim.g.separator .. 'bin' .. vim.g.separator .. 'sqlite3.dll') == 0 then
else
    table.insert(telescope_config, 
        {
            'prochri/telescope-all-recent.nvim',
            dependencies = "kkharji/sqlite.lua",
            config = function()
                if vim.g.is_windows then
                    require('telescope-all-recent').setup({
                        vim.cmd("let g:sqlite_clib_path = '" .. vim.fn.stdpath('config') .. vim.g.separator .. 'bin' .. vim.g.separator .. 'sqlite3.dll\'')
                    })
                else 
                    require('telescope-all-recent').setup()
                end
            end
        }
    )
end

return telescope_config