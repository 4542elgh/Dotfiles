----------------------------------------------------------------------------------
-- folke plugins
----------------------------------------------------------------------------------
return {
    {
        "folke/trouble.nvim",
        keys = {{ "<leader>d", "<cmd>TroubleToggle<CR>", desc = "Folke: Trouble"}},
    },

    -- Be sure to have TODO[:], without colon, plugin cannot recognize as valid comment
    { "folke/todo-comments.nvim", config = true }
}
