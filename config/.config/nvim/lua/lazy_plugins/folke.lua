----------------------------------------------------------------------------------
-- folke plugins
----------------------------------------------------------------------------------
return {
    {
        "folke/trouble.nvim",
        config = function()
            nmap("<Leader>d", ":TroubleToggle<CR>")
        end
    },

    -- Be sure to have TODO[:], without colon, plugin cannot recognize as valid comment
    {
       "folke/todo-comments.nvim",
       dependencies = { "nvim-lua/plenary.nvim" },
       config = function()
           require("todo-comments").setup()
       end
    }

    -- This delays single key action like ">"
    -- use {
    --     "folke/which-key.nvim",
    --     config = function()
    --         require("which-key").setup()
    --     end
    -- }
}
