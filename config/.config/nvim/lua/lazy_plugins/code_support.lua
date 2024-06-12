return {
    "xiyaowong/nvim-cursorword",
    { "windwp/nvim-autopairs", config = true },
    { "kylechui/nvim-surround", config = true },
    { "lewis6991/gitsigns.nvim", config = true },
    { "terrortylor/nvim-comment",
        -- The plugin name and git repo name are different, cant use short hand
        config = function()
            require("nvim_comment").setup()
        end
    },
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
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        cond = executable("yarn")
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
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup({
                handle = {
                    text = " ",
                    color = "#a9b7c6"
                },
                marks = {
                    Search = { text = { "--", "==" } },
                    Error = { text = { "--", "==" } },
                    Warn = { text = { "--", "==" } },
                    Info = { text = { "--", "==" } },
                    Hint = { text = { "--", "==" } },
                    Misc = { text = { "--", "==" } },
                }
            })
        end
    },
    {
        "alvan/vim-closetag",
        config = function()
            vim.g.closetag_filenames = "*.html,*.xhtml,*.vue,*.jsx"
            vim.g.closetag_emptyTags_caseSensitive = 1
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local highlight = {
                "CursorColumn",
                "Whitespace",
            }
            require("ibl").setup {
                indent = { highlight = highlight, char = "" },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false,
                },
                scope = { enabled = false },
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

            local function tree_mapping(bufnr)
                local api = require "nvim-tree.api"

                local function opts(desc)
                  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
              
                -- default mappings
                api.config.mappings.default_on_attach(bufnr)
              
                -- custom mappings
                vim.keymap.set('n', '<left>', api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', 'right',     api.tree.change_root_to_node, opts('CD'))
                vim.keymap.set('n', 'c',     api.fs.create, opts('Create File Or Directory'))
            end

            require("nvim-tree").setup({
                respect_buf_cwd = true,
                sort_by = "case_sensitive",
                update_focused_file = {
                    enable = true
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
                on_attach = tree_mapping
            })
        end
    }
}
