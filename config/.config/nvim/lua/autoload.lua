--================================================================================
--     ___   __  ____________  __    ____  ___    ____ 
--    /   | / / / /_  __/ __ \/ /   / __ \/   |  / __ \
--   / /| |/ / / / / / / / / / /   / / / / /| | / / / /
--  / ___ / /_/ / / / / /_/ / /___/ /_/ / ___ |/ /_/ / 
-- /_/  |_\____/ /_/  \____/_____/\____/_/  |_/_____/  
--================================================================================
autocmd({"BufNewFile", "BufRead"}, {"*.jsx"}, "set filetype=javascriptreact")
autocmd({"BufNewFile", "BufRead"}, {"*.rasi"}, "setf css")

-- Show line diagnostics automatically in hover window
autocmd({"CursorHold", "CursorHoldI"}, {"*"}, "lua vim.diagnostic.open_float(nil, {border='rounded', focus=false})")

vim.cmd('set foldlevelstart=99')
vim.g.indentLine_enabled = 1

-- if vim.g.is_workpc then
--     autocmd({"Filetype"}, {"*"}, "AnyFoldActivate")
-- else
    -- Telescope have issue opening file with folding enable (does not allow za toggle) Need this autocmd to manually start up folding
vim.api.nvim_create_autocmd('BufRead', {
   callback = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
         once = true,
         command = 'normal! zx'
      })
      vim.api.nvim_create_autocmd('BufWinEnter', {
         once = true,
         command = 'normal! zR'
      })
   end
})
-- end

-- Show what word(s) you yanked, like y4w it will highlight 4 words
autocmd({"TextYankPost"}, {"*"}, "lua vim.highlight.on_yank({higroup = 'IncSearch', timeout = 300})")
