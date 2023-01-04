--================================================================================
--   __________  _________________ __________________________ 
--  /_  __/ __ \/ ____/ ____/ ___//  _/_  __/_  __/ ____/ __ \
--   / / / /_/ / __/ / __/  \__ \ / /  / /   / / / __/ / /_/ /
--  / / / _, _/ /___/ /___ ___/ // /  / /   / / / /___/ _, _/ 
-- /_/ /_/ |_/_____/_____//____/___/ /_/   /_/ /_____/_/ |_|  
--================================================================================
----------------------------------------------------------------------------------
-- require zig
----------------------------------------------------------------------------------
return {
    "windwp/nvim-ts-autotag",
    "p00f/nvim-ts-rainbow",
    "nvim-treesitter/nvim-treesitter-context",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "rust" },
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
