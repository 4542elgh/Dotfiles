return {
    "xiyaowong/nvim-cursorword",
    { "windwp/nvim-autopairs", config = true },
    { "kylechui/nvim-surround", config = true },
    { "terrortylor/nvim-comment", 
        -- The plugin name and git repo name are different, cant use short hand
        config = function()
            require("nvim_comment").setup()
        end
    },

    -- NEED OPTIMIZATION
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {"markdown"}
        end,
        cmd = "MarkdownPreview",
        cond = executable("npm")
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end
    },
    {
        "s1n7ax/nvim-terminal",
        config = function()
            require("nvim-terminal").setup({
                window = {
                    height = 7,
                },
                toggle_keymap = "<leader>t",
            })
        end
    },
    { "lewis6991/gitsigns.nvim", config = true
        -- config = function()
        --     require('gitsigns').setup()
        --     require("scrollbar.handlers.gitsigns").setup()
        -- end
    },
    { 'pseewald/vim-anyfold' },
    {
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
    },
    { "luochen1990/rainbow",
        config = function()
            vim.g.rainbow_active = 1
        end,
    },
    {
        "alvan/vim-closetag",
        config = function()
            vim.g.closetag_filenames = "*.html,*.xhtml,*.vue,*.jsx"
            vim.g.closetag_emptyTags_caseSensitive = 1
        end,
    },
    -- {
    --     "nathanaelkane/vim-indent-guides",
    --     config = function()
    --         -- vim.g.indent_guides_enable_on_vim_startup = 1
    --         vim.cmd("let g:indent_guides_enable_on_vim_startup = 1")
    --         vim.g.indent_guides_exclude_filetypes = {"help", "nvimtree", "dashboard"}
    --     end
    -- },
    {
        "lukas-reineke/indent-blankline.nvim",
        -- underline value
        -- hl-IndentBlanklineContextStart
        -- Vertical value
        -- hl-IndentBlanklineContextChar
        config = function()
            -- Blank 4 space tab coloring
            vim.cmd [[highlight IndentBlanklineIndent1 guifg=#F7BFB9 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guifg=#C6B1DF gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guifg=#F2ACBA gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent4 guifg=#9FB5CB gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent5 guifg=#A6C6F0 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent6 guifg=#DEE6EC gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent7 guifg=#B1AAAA gui=nocombine]]

            -- vim.opt.list = true
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
                filetype_exclude = {'help', 'lazy', 'dashboard', 'nvimtree'},
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                    "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5",
                    "IndentBlanklineIndent6",
                    "IndentBlanklineIndent7",
                },
            }
        end
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
        end
    },
    {
        "kyazdani42/nvim-tree.lua",
        -- keys = "<Leader>n",
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
}
