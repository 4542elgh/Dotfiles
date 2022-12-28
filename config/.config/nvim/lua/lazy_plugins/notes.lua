----------------------------------------------------------------------------------
-- Note taking
----------------------------------------------------------------------------------
return {
    {
        "vimwiki/vimwiki",
        config = function()
            vim.cmd("let g:vimwiki_list = [{'path': stdpath('config') . '\\vimwiki', 'syntax': 'markdown', 'ext': '.md'}]")
            abbrev("wiki", "VimwikiIndex")
        end
    }
}
