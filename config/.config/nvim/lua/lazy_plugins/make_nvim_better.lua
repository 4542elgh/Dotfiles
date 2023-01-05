----------------------------------------------------------------------------------
-- Make Vim default better
----------------------------------------------------------------------------------
return {
    "moll/vim-bbye",
    "kyazdani42/nvim-web-devicons",
    "junegunn/vim-peekaboo",
    {"asiryk/auto-hlsearch.nvim", config = true },
    { "ethanholz/nvim-lastplace", config = true },
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
    {
        "ggandor/lightspeed.nvim",
        config = function()
            require("lightspeed").setup({
                ignore_case = true,
            })
            vim.g.lightspeed_no_default_keymaps = true
            nmap("f", "<Plug>Lightspeed_omni_s")
        end
    }
}
