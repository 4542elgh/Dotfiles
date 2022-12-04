--================================================================================
--     ___    ____  ____  ____  _______    __
--    /   |  / __ )/ __ )/ __ \/ ____/ |  / /
--   / /| | / __  / __  / /_/ / __/  | | / / 
--  / ___ |/ /_/ / /_/ / _, _/ /___  | |/ /  
-- /_/  |_/_____/_____/_/ |_/_____/  |___/   
--================================================================================
if not vim.g.is_windows then
    abbrev('zshrc', 'edit ~/.zshrc')
end

-- Git
abbrev('Ghead', 'Gvsplit HEAD~3:%')

-- Vim shortcut edits
abbrev('vimrc', "edit " .. vim.fn.stdpath('config') .. vim.g.separator .. "init.lua<CR>")
abbrev('snippet', "NvimTreeOpen " .. vim.fn.stdpath('config') .. vim.g.separator .. "snippets<CR>")
abbrev('color', 'edit ' .. vim.fn.stdpath('data') .. concatPath({"site", "pack", "packer", "start", "darcula.nvim", "lua", "darcula.lua"}, vim.g.separator, true, false))

-- Make current buffer's path to working path, so FZF can work correctly
abbrev('cdthis', [[cd <C-R>=expand("%:p:h")<CR>]])

if vim.g.is_workpc then
    abbrev('lang', 'set syntax=')
end

-- If you need to copy content with notepad, or just use "+y and copy it to system clipboard
abbrev('open', 'silent !notepad.exe %')
abbrev('exp', 'silent !explorer.exe <C-R>=expand("%:p:h")<CR>')
abbrev('appdata', 'silent !explorer.exe ' .. vim.fn.stdpath('config'))

-- Personal functions
abbrev('gen', ':lua gen()')
abbrev('reverse', 'lua reverse()')
abbrev('ssh', 'lua ssh()')

if not vim.g.is_workpc then
    abbrev('smb', ':Telescope smb_unc')
else
    abbrev('smb', ':lua networkPath()')
end
