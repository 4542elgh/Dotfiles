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
-- autocmd({"CursorHold", "CursorHoldI"}, {"*"}, "lua vim.diagnostic.open_float(nil, {border='rounded', focus=false})")

vim.cmd('set foldlevelstart=99')
vim.g.indentLine_enabled = 1

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

-- Show what word(s) you yanked, like y4w it will highlight 4 words
autocmd({"TextYankPost"}, {"*"}, "lua vim.highlight.on_yank({higroup = 'IncSearch', timeout = 300})")

-- avoid repeating hjkl keys
-- local id
-- local function avoid_hjkl(mode, mov_keys)
--     for _, key in ipairs(mov_keys) do
--         local count = 0
--         vim.keymap.set(mode, key, function()
--             if count >= 10 then
--                 id = vim.notify("Hold it Cowboy!", vim.log.levels.WARN, {
--                     icon = "🤠",
--                     replace = id,
--                     keep = function()
--                         return count >= 5
--                     end,
--                 })
--             else
--                 count = count + 1
--                 -- after 5 seconds decrement
--                 vim.defer_fn(function()
--                     count = count - 1
--                 end, 5000)
--                 return key
--             end
--         end, { expr = true })
--     end
-- end
--
-- -- Hard mode toggle
-- HardMode = false
-- function ToggleHardMode()
--     local modes = { "n" }
--     local movement_keys = { "h", "j", "k", "l", "<Up>", "<Down>", "<Left>", "<Right>" }
--     if HardMode then
--         for _, mode in pairs(modes) do
--             for _, m_key in pairs(movement_keys) do
--                 vim.api.nvim_del_keymap(mode, m_key)
--             end
--         end
--         vim.notify("Hard mode OFF")
--     else
--         for _, mode in pairs(modes) do
--             avoid_hjkl(mode, movement_keys)
--         end
--         vim.notify("Hard mode ON")
--     end
--     HardMode = not HardMode
-- end
--
-- ToggleHardMode()
