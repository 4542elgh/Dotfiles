----------------------------------------------------------------------------------
-- Note taking
----------------------------------------------------------------------------------
return {
    {
        "vimwiki/vimwiki",
        config = function()
            -- This is not working on lazy.nvim for some reason
            -- vim.cmd("let g:vimwiki_list = [{'path': stdpath('config') . '\\vimwiki', 'syntax': 'markdown', 'ext': '.md'}]")
            --
            -- Will use direct access for now
            -- abbrev("wiki", "VimwikiIndex")
            abbrev("wiki", "e " .. vim.fn.stdpath('config') .. '\\vimwiki\\index.md')
        end
    }
}
