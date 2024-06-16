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
        'tzachar/local-highlight.nvim',
        config = function()
            require('local-highlight').setup({
                hlgroup = 'LocalHighlight'
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua" },
                -- Async install
                -- sync_install = true,
                highlight = { enable = true, },
                autotag = { enable = true, },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
            })
        end
    }
}
