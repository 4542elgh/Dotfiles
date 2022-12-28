----------------------------------------------------------------------------------
-- Make Vim default better
----------------------------------------------------------------------------------
return {
    "moll/vim-bbye",
    "junegunn/vim-peekaboo",
    {
        "ethanholz/nvim-lastplace",
        config = true
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = function ()
            require("colorful-winsep").setup({
                highlight = {
                    bg = "#323232",
                    fg = "#c57825",
                }
            })
        end
    },
    -- {
    --     "mihaifm/bufstop",
    --     config = function()
    --         nmap("<Leader>b", ":BufstopFast<CR>")
    --     end,
    --     -- cond = vim.g.is_workpc
    -- },
    {
        "ggandor/lightspeed.nvim",
        -- keys = "f",
        config = function()
            require("lightspeed").setup({
                ignore_case = true,
            })
            vim.g.lightspeed_no_default_keymaps = true
            nmap("f", "<Plug>Lightspeed_omni_s")
        end
    }
}
