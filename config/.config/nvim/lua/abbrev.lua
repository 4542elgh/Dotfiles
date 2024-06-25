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

-- Vim shortcut edits
abbrev('vimrc'  , "edit " .. vim.fn.stdpath('config') .. vim.g.separator .. "init.lua<CR>")
abbrev('vimrcdir', 'silent !explorer.exe ' .. vim.fn.stdpath('config'))

abbrev('color'  , 'edit ' .. vim.fn.stdpath('data') .. concatPath({"site", "pack", "packer", "start", "darcula.nvim", "lua", "darcula.lua"}, vim.g.separator, true, false))
abbrev('snippet', "NvimTreeOpen " .. vim.fn.stdpath('config') .. vim.g.separator .. "snippets<CR>")

-- Make current buffer's path to working path, so FZF can work correctly
abbrev('cdthis' , [[cd <C-R>=expand("%:p:h")<CR>]])

-- If you need to copy content with notepad, or just use "+y and copy it to system clipboard
abbrev('openfile'   , 'silent !notepad.exe %')
abbrev('explorer'    , 'silent !explorer.exe <C-R>=expand("%:p:h")<CR>')

-- Personal functions
abbrev('ssh'    , 'lua ssh()')
abbrev('gen'    , 'lua gen()')
abbrev('reverse', 'lua reverse()')
abbrev('format' , 'lua vim.lsp.buf.format()')
abbrev('git'    , 'terminal lazygit<CR>a')
abbrev('smb'    , 'Telescope smb_unc')
abbrev('run'    , 'Telescope scratch_run')
