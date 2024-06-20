----------------------------------------------------------------------------------
-- folke plugins
----------------------------------------------------------------------------------
return {
    {
        "folke/trouble.nvim",
        keys = {{ "<leader>d", "<cmd>TroubleToggle<CR>", desc = "Folke: Trouble"}},
    },

    -- Be sure to have TODO[:], without colon, plugin cannot recognize as valid comment
    { "folke/todo-comments.nvim", config = true },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        end,
        opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        }
    }
}
