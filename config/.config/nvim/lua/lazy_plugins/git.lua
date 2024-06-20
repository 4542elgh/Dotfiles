return {
    { "lewis6991/gitsigns.nvim", config = true },
    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    { "sindrets/diffview.nvim", config = true }
}
