--================================================================================
--     ____  ____  ____  _____________________  ___    ____ 
--    / __ )/ __ \/ __ \/_  __/ ___/_  __/ __ \/   |  / __ \
--   / __  / / / / / / / / /  \__ \ / / / /_/ / /| | / /_/ /
--  / /_/ / /_/ / /_/ / / /  ___/ // / / _, _/ ___ |/ ____/ 
-- /_____/\____/\____/ /_/  /____//_/ /_/ |_/_/  |_/_/      
--================================================================================
local packer_bootstrap = packer_bootstrap()

--================================================================================
--     ____  ___   ________ __ __________ 
--    / __ \/   | / ____/ //_// ____/ __ \
--   / /_/ / /| |/ /   / ,<  / __/ / /_/ /
--  / ____/ ___ / /___/ /| |/ /___/ _, _/ 
-- /_/   /_/  |_\____/_/ |_/_____/_/ |_|  
--================================================================================
vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
    ----------------------------------------------------------------------------------
    -- Packer can manage itself
    ----------------------------------------------------------------------------------
    use {
        "wbthomason/packer.nvim",
        config = function()
            abbrev("install", "PackerUpdate")
            abbrev("update", "PackerCompile")
        end
    }

    ----------------------------------------------------------------------------------
    -- Darcula for life
    ----------------------------------------------------------------------------------
    use{
        "4542elgh/darcula.nvim",
        requires = {{"tjdevries/colorbuddy.nvim"}},
        config = function()
            require("darcula")
        end
    }

    ----------------------------------------------------------------------------------
    -- NEED FOR SPEED
    ----------------------------------------------------------------------------------
    use {
        "lewis6991/impatient.nvim",
        config = function ()
            require("impatient")
        end
    }

    ----------------------------------------------------------------------------------
    -- Profiling
    ----------------------------------------------------------------------------------
    use "dstein64/vim-startuptime"

    ----------------------------------------------------------------------------------
    -- Status line
    ----------------------------------------------------------------------------------
    use {
        "nvim-lualine/lualine.nvim",
        config = function()
            require('lualine').setup({
                options = {
                    theme = "powerline_dark"
                },
                sections = {
                    lualine_c = {
                        "lsp_progress"
                    },
                    lualine_x = {
                        "encoding",
                        "filetype",
                        "filename",
                    },
                }
            })
        end
    }

    ----------------------------------------------------------------------------------
    -- Fast Searcher
    ----------------------------------------------------------------------------------
    use {
        "junegunn/fzf.vim",
        requires = {{"junegunn/fzf"}},
        config = function()
            nmap("<Leader>a", ":Ag<CR>")
            nmap("<Leader>f", ":FZF<CR>")
            nmap("<Leader>h", ":History<CR>")
            vim.cmd([[tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"]])
        end,
        cond = executable("fzf") and vim.g.is_workpc
    }

    ----------------------------------------------------------------------------------
    -- Coding support
    ----------------------------------------------------------------------------------
    use "xiyaowong/nvim-cursorword"

    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end
    }

    use {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    }

    use {
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup()
        end
    }

    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {"markdown"}
        end,
        ft = {"markdown"},
        cmd = "MarkdownPreview",
        cond = executable("npm")
    }

    use {
        "norcalli/nvim-colorizer.lua",
        event = "VimEnter",
        config = function()
            require("colorizer").setup()
        end
    }

    use {
        "s1n7ax/nvim-terminal",
        config = function()
            require("nvim-terminal").setup({
                window = {
                    height = 7,
                },
                toggle_keymap = "<leader>t",
            })
        end
    }

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
        end
    }

    use {
        'pseewald/vim-anyfold',
        cond = vim.g.is_workpc
    }

    use {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup({
                -- handle = {
                --     text = "   ",
                -- },
                -- marks = {
                --     Search = { text = { "--", "==" } },
                --     Error = { text = { "--", "==" } },
                --     Warn = { text = { "--", "==" } },
                --     Info = { text = { "--", "==" } },
                --     Hint = { text = { "--", "==" } },
                --     Misc = { text = { "--", "==" } },
                -- }
            })
        end
    }

    use {
        "luochen1990/rainbow",
        config = function()
            vim.g.rainbow_active = 1
        end,
        cond = vim.g.is_workpc
    }

    use {
        "alvan/vim-closetag",
        config = function()
            vim.g.closetag_filenames = "*.html,*.xhtml,*.vue,*.jsx"
            vim.g.closetag_emptyTags_caseSensitive = 1
        end,
        cond = vim.g.is_workpc
    }

    use {
        "nathanaelkane/vim-indent-guides",
        config = function()
            vim.g.indent_guides_enable_on_vim_startup = 1
            vim.g.indent_guides_exclude_filetypes = {"help", "nvimtree", "startify", "dashboard"}
        end
    }

    use {
        "mbbill/undotree",
        event = "VimEnter",
        config = function()
            nmap("<Leader>u", ":UndotreeToggle<CR>")
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
        end
    }

    use {
        "kyazdani42/nvim-tree.lua",
        keys = "<Leader>n",
        config = function ()
            nmap('<Leader>n', ":NvimTreeToggle<CR>")
            require("nvim-tree").setup({
                respect_buf_cwd = true,
                sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                    mappings = {
                        list = {
                            { key = "<left>", action = "dir_up" },
                            { key = "<right>", action = "cd" },
                            { key = "c", action = "create" },
                        },
                    },
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end
    }

    --================================================================================
    --   __________  _________________ __________________________ 
    --  /_  __/ __ \/ ____/ ____/ ___//  _/_  __/_  __/ ____/ __ \
    --   / / / /_/ / __/ / __/  \__ \ / /  / /   / / / __/ / /_/ /
    --  / / / _, _/ /___/ /___ ___/ // /  / /   / / / /___/ _, _/ 
    -- /_/ /_/ |_/_____/_____//____/___/ /_/   /_/ /_____/_/ |_|  
    --================================================================================
    ----------------------------------------------------------------------------------
    -- Require ZIG
    ----------------------------------------------------------------------------------
    use {
        "nvim-treesitter/nvim-treesitter-context",
        cond = not vim.g.is_workpc
    }
    use {
        "windwp/nvim-ts-autotag",
        cond = not vim.g.is_workpc
    }
    use {
        "p00f/nvim-ts-rainbow",
        cond = not vim.g.is_workpc
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"

            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "rust" },
                -- Async install
                sync_install = true,
                -- auto_install = true,
                highlight = {
                    enable = true,
                },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
                autotag = {
                    enable = true,
                }
            })
        end,
        cond = not vim.g.is_workpc
    }

    --================================================================================
    --   ______________    ___________ __________  ____  ______
    --  /_  __/ ____/ /   / ____/ ___// ____/ __ \/ __ \/ ____/
    --   / / / __/ / /   / __/  \__ \/ /   / / / / /_/ / __/   
    --  / / / /___/ /___/ /___ ___/ / /___/ /_/ / ____/ /___   
    -- /_/ /_____/_____/_____//____/\____/\____/_/   /_____/   
    --                                                        
    --================================================================================
    ----------------------------------------------------------------------------------
    -- Require cmake
    ----------------------------------------------------------------------------------
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cond = not vim.g.is_workpc
    }

    -- use {
    --     "nvim-telescope/telescope-frecency.nvim",
    --     requires = {"kkharji/sqlite.lua"}
    -- }

    use {
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
        cond = not vim.g.is_workpc
    }

    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = {{"nvim-lua/plenary.nvim"}},
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
            -- require("telescope").load_extension("frecency")
        end,
        cond = not vim.g.is_workpc
    }

    ----------------------------------------------------------------------------------
    -- Make Vim default better
    ----------------------------------------------------------------------------------
    use "moll/vim-bbye"
    use "junegunn/vim-peekaboo"

    use {
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup()
        end
    }

    use {
        "nvim-zh/colorful-winsep.nvim",
        config = function ()
            require("colorful-winsep").setup({
                highlight = {
                    guibg = "#323232",
                    guifg = "#c57825",
                }
            })
        end
    }

    use {
        "mihaifm/bufstop",
        config = function()
            nmap("<Leader>b", ":BufstopFast<CR>")
        end,
        cond = vim.g.is_workpc
    }

    use {
        "ggandor/lightspeed.nvim",
        keys = "f",
        config = function()
            require("lightspeed").setup({
                ignore_case = true,
            })
            vim.g.lightspeed_no_default_keymaps = true
            nmap("f", "<Plug>Lightspeed_omni_s")
        end
    }

    ----------------------------------------------------------------------------------
    -- LSP Support
    ----------------------------------------------------------------------------------
    -- KEEP THE ORDER THIS WAY for LSP to work correctly
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "saadparwaiz1/cmp_luasnip"
    use "arkav/lualine-lsp-progress"
    use "kyazdani42/nvim-web-devicons"

    use {
        "hrsh7th/cmp-cmdline",
        config = function()
            require("cmp").setup.cmdline(":", {
                sources = {{ name = "cmdline" }}
            })
        end
    }

    use {
        "VonHeikemen/lsp-zero.nvim",
        config = function()
            local lspZero = require("lsp-zero")
            lspZero.preset("recommended")
            lspZero.setup()
            -- !!! If you use Mason to install typescript-language-server 
            -- !!! You will also need to use npm to install typescript-language-server
            -- !!! npm install typescript-language-server
            require("lspconfig").sumneko_lua.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end
    }

    use {
        "onsails/lspkind.nvim",
        config = function()
            require("cmp").setup({
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    }),
                },
            })
        end
    }

    use {
        'glepnir/lspsaga.nvim',
        config = function()
            require("lspsaga").init_lsp_saga({
                symbol_in_winbar = {
                    enable = false,
                },
            })

            vim.diagnostic.config({
                virtual_text = false
            })

            -- The REAL Peak Definition
            nmap("gp","<cmd>Lspsaga lsp_finder<CR>")
            -- Code action
            nmap("ga","<cmd>Lspsaga code_action<CR>")
            -- Rename
            nmap("gr","<cmd>Lspsaga rename<CR>")
            -- Peak Definition even though it suppose to go to definition
            nmap("gd","<cmd>Lspsaga peek_definition<CR>")
            -- Hover Doc
            nmap("gh","<cmd>Lspsaga hover_doc<CR>")
            -- Show line diagnostics
            nmap("go","<cmd>LSoutlineToggle<CR>")
        end
    }

    ----------------------------------------------------------------------------------
    -- LSP diagnostics and Better comments (inspired by VS Code extension)
    ----------------------------------------------------------------------------------
    use {
        "folke/trouble.nvim",
        config = function()
            nmap("<Leader>d", ":TroubleToggle<CR>")
        end
    }

    -- Be sure to have TODO[:], without colon, plugin cannot recognize as valid comment
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end
    }

    ----------------------------------------------------------------------------------
    -- Autocompletion
    ----------------------------------------------------------------------------------
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            -- Annoying, but its here when you need it, this will show definition when cursor is on ANY word
            -- vim.cmd([[au CursorHold * lua vim.lsp.buf.hover()]])
            local cmp = require "cmp"
            cmp.setup({
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                },
            })
        end
    }

    ----------------------------------------------------------------------------------
    -- Snippets
    ----------------------------------------------------------------------------------
    use "rafamadriz/friendly-snippets"

    use {
        "L3MON4D3/LuaSnip",
        config = function()
            local snipLocation = ""
            if(vim.loop.os_uname().sysname == "Windows_NT") then
                snipLocation = os.getenv("LOCALAPPDATA") .. "\\nvim\\snippets"
            else
                snipLocation = "~/.config/nvim/snippets"
            end
            require("luasnip.loaders.from_vscode").load({ paths = snipLocation })
            require("luasnip").filetype_extend("vimwiki", {"markdown"})
        end
    }

    ----------------------------------------------------------------------------------
    -- Note taking
    ----------------------------------------------------------------------------------
    use {
        "vimwiki/vimwiki",
        config = function()
            vim.cmd("let g:vimwiki_list = [{'path': stdpath('config') . '\\vimwiki', 'syntax': 'markdown', 'ext': '.md'}]")
            abbrev("wiki", "VimwikiIndex")
        end
    }

    ----------------------------------------------------------------------------------
    -- Dashboard
    ----------------------------------------------------------------------------------
    use {
        "mhinz/vim-startify",
        config = function()
            vim.cmd("let g:footer = [['Enjoy Neovim! You know you made the right choice when switching to NeoVim!']]")
            vim.g.startify_session_dir = "~/AppData/Local/nvim/session"
            vim.g.startify_session_persistence = 1
            vim.g.startify_session_number = 10
            vim.g.startify_session_sort = 1
            vim.cmd("let g:startify_custom_footer = 'startify#pad(g:footer[0])'")
            abbrev("dash", "Startify")
        end,
        cond = vim.g.is_workpc
    }

    use {
        "glepnir/dashboard-nvim",
        config = function()
            local db = require("dashboard")
            db.custom_center = {
                {
                    icon = "  ",
                    desc = "Recently opened files                   ",
                    shortcut = "SPC f r"
                },
                {
                    icon = "  ",
                    desc = "Find File                               ",
                    shortcut = "SPC f f"
                },
                {
                    icon = "  ",
                    desc = "File Browser                            ",
                    shortcut = "SPC f n"
                },
                {
                    icon = "  ",
                    desc = "Vim Wiki                                ",
                    shortcut = "SPC f w"
                },
            }
        end,
        cond = not vim.g.is_workpc
    }

    ----------------------------------------------------------------------------------
    -- Discord Presence
    ----------------------------------------------------------------------------------
    use {
        'andweeb/presence.nvim',
        cond = not vim.g.is_workpc
    }

    -- Packerbootstrap, keep this at the very bottom
    if packer_bootstrap then
        require("packer").sync()
    end
end)
