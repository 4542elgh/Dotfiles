--================================================================================
--     ____  _______________   __  ____  ___________
--    / __ \/ ____/ ____/   | / / / / / /_  __/ ___/
--   / / / / __/ / /_  / /| |/ / / / /   / /  \__ \ 
--  / /_/ / /___/ __/ / ___ / /_/ / /___/ /  ___/ / 
-- /_____/_____/_/   /_/  |_\____/_____/_/  /____/  
--================================================================================
----------------------------------------------------------------------------------
-- Microsoft features
----------------------------------------------------------------------------------
vim.cmd("source $VIMRUNTIME/mswin.vim")

-- Make Arrow key work in Windows mode
vim.opt.keymodel:remove({'stopsel'})

vim.g.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1

if vim.g.is_windows then
    vim.opt.guifont = { "DejaVuSansM Nerd Font Mono", ":h16" }
else
    vim.opt.guifont = { "DejaVuSansMono Nerd Font", ":h16" }
end

vim.g.separator = "/"
if vim.g.is_windows then vim.g.separator = "\\" end

vim.g.hostname = ""

if vim.g.is_windows then
    vim.g.hostname = hostname()
else
    vim.g.hostname = "linux"
end

vim.g.has_cmake = vim.fn.executable("cmake") == 1

vim.g.is_workpc = substr(vim.g.hostname,1,3) == "M16" or substr(vim.g.hostname,1,3) == "ECC"
----------------------------------------------------------------------------------
-- Mapping leader key
----------------------------------------------------------------------------------
vim.g.mapleader = " "

----------------------------------------------------------------------------------
-- Color sccheme
----------------------------------------------------------------------------------
vim.opt.termguicolors = true

----------------------------------------------------------------------------------
-- Global status line
----------------------------------------------------------------------------------
vim.opt.laststatus = 3

----------------------------------------------------------------------------------
-- Hide Ex line
----------------------------------------------------------------------------------
vim.opt.cmdheight = 1

----------------------------------------------------------------------------------
-- Eighty column print
----------------------------------------------------------------------------------
vim.opt.colorcolumn = '80'

----------------------------------------------------------------------------------
-- Scroll down when there is 10 spaces left either to the top or bottom
----------------------------------------------------------------------------------
vim.opt.scrolloff = 10

----------------------------------------------------------------------------------
-- Disable prompt for cmdline, we have cmp-cmdline for autocompletion
----------------------------------------------------------------------------------
vim.opt.wildmenu = false

----------------------------------------------------------------------------------
-- line number and relative number
----------------------------------------------------------------------------------
vim.wo.number = true
vim.opt.relativenumber = true

----------------------------------------------------------------------------------
-- case insensitive search
----------------------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true

----------------------------------------------------------------------------------
-- conceal level
----------------------------------------------------------------------------------
vim.opt.conceallevel = 2

----------------------------------------------------------------------------------
-- Tab magics
----------------------------------------------------------------------------------
-- A tab character will be 8 characters wide (you wont see it when you press TAB here due to me having below setting to always convert tab into space)
vim.opt.tabstop = 8

-- Govern how many space tab and >> will take
vim.opt.shiftwidth = 4

-- When set to 0, it will make NON-empty line tab action shift 4 spaces, and back space gose back 1 spack at a time. 
-- This means if you type a 3 character word and press tab, it will immediately start inserting 4 spaces. This is different from the following condition.
-- If this is off or -1, and you type in a 3 character word, it will fill 1 space to make it 4 space, then tab will start inserting 4 spaces
vim.opt.softtabstop = 0

-- Always convert tab into spaces, this will eliminate different tab implementation on different system
vim.opt.expandtab = true

-- Make vim always use shiftwidth for all tab related actions 
vim.opt.smarttab = true

----------------------------------------------------------------------------------
-- Buffer allow to be hidden (so you dont stuck on one buffer and need to save before moving on)
----------------------------------------------------------------------------------
vim.opt.hidden = true

----------------------------------------------------------------------------------
-- Cross hair cursor highlight
----------------------------------------------------------------------------------
vim.wo.cursorline = true
vim.wo.cursorcolumn = true

----------------------------------------------------------------------------------
-- Split window will always go to right then bottom
----------------------------------------------------------------------------------
vim.opt.splitright = true
vim.opt.splitbelow = true

----------------------------------------------------------------------------------
-- Update interval
----------------------------------------------------------------------------------
vim.opt.updatetime = 50

----------------------------------------------------------------------------------
-- Change Directory when opening a new file
----------------------------------------------------------------------------------
vim.opt.autochdir = true

----------------------------------------------------------------------------------
-- Disable build in plugins
----------------------------------------------------------------------------------
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

----------------------------------------------------------------------------------
-- Set Lazyredraw
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up, upto 6-7x faster 
----------------------------------------------------------------------------------
vim.opt.lazyredraw = true

