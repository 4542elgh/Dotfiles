--================================================================================
--     __   _____ ____ 
--    / /  / ___// __ \
--   / /   \__ \/ /_/ /
--  / /______/ / ____/ 
-- /_____/____/_/      
--================================================================================
-- KEEP THE ORDER THIS WAY for LSP to work correctly, hopefully with lazy.nvim we dont need to keep order this way
return {
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "arkav/lualine-lsp-progress",
        },
        config = function()
            local lspZero = require("lsp-zero")
            lspZero.preset("recommended")
            lspZero.setup()

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {'lua_ls'},
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                },
            })

            -- !!! If you use Mason to install typescript-language-server 
            -- !!! You will also need to use npm to install typescript-language-server
            -- !!! npm install typescript-language-server
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end
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
                    }),
                },
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
        },
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
    },
    {
        "hrsh7th/cmp-cmdline",
        config = function()
            require("cmp").setup.cmdline(":", {
                sources = {{ name = "cmdline" }}
            })
        end
    },
    -- {
    --     'glepnir/lspsaga.nvim',
    --     keys = {
    --         -- The REAL Peak Definition
    --         {"gp","<cmd>Lspsaga lsp_finder<CR>"},
    --         -- Code action
    --         {"ga","<cmd>Lspsaga code_action<CR>"},
    --         -- Rename
    --         {"gr","<cmd>Lspsaga rename<CR>"},
    --         -- Peak Definition even though it suppose to go to definition
    --         -- nmap("gd","<cmd>Lspsaga peek_definition<CR>")
    --         -- Hover Doc
    --         {"gh","<cmd>Lspsaga hover_doc<CR>"},
    --         -- Show line diagnostics
    --         {"go","<cmd>LSoutlineToggle<CR>"}
    --     },
    --     config = function()
    --         require("lspsaga").init_lsp_saga({
    --             symbol_in_winbar = {
    --                 enable = false,
    --             },
    --             code_action_lightbulb = {
    --                 enable = false,
    --             }
    --         })
    --         vim.diagnostic.config({
    --             virtual_text = false
    --         })
    --     end
    -- },
    {
        "jose-elias-alvarez/null-ls.nvim",
        run = "npm install -g @fsouza/prettierd",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettierd
                },
            })
        end
    },

    ----------------------------------------------------------------------------------
    -- Snippets
    ----------------------------------------------------------------------------------
    "rafamadriz/friendly-snippets",
    {
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
}
