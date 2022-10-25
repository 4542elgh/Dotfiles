--==========================================================
--     ____  ____  ____  _____________________  ___    ____ 
--    / __ )/ __ \/ __ \/_  __/ ___/_  __/ __ \/   |  / __ \
--   / __  / / / / / / / / /  \__ \ / / / /_/ / /| | / /_/ /
--  / /_/ / /_/ / /_/ / / /  ___/ // / / _, _/ ___ |/ ____/ 
-- /_____/\____/\____/ /_/  /____//_/ /_/ |_/_/  |_/_/      
--==========================================================
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

--==========================================================
--     ____  _______________   __  ____  ___________
--    / __ \/ ____/ ____/   | / / / / / /_  __/ ___/
--   / / / / __/ / /_  / /| |/ / / / /   / /  \__ \ 
--  / /_/ / /___/ __/ / ___ / /_/ / /___/ /  ___/ / 
-- /_____/_____/_/   /_/  |_\____/_____/_/  /____/  
--==========================================================
----------------------------------------------------------------------------------
-- Microsoft features
----------------------------------------------------------------------------------
vim.cmd("source $VIMRUNTIME/mswin.vim")
vim.cmd("behave mswin")

-- Make Arrow key work in Windows mode
vim.opt.keymodel:remove({'stopsel'})

----------------------------------------------------------------------------------
-- Mapping leader key
----------------------------------------------------------------------------------
vim.g.mapleader = " "

----------------------------------------------------------------------------------
-- Global variable
----------------------------------------------------------------------------------
vim.g.os = vim.loop.os_uname().sysname

----------------------------------------------------------------------------------
-- Color sccheme
----------------------------------------------------------------------------------
vim.opt.termguicolors = true

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
-- Update
----------------------------------------------------------------------------------
vim.opt.updatetime = 50

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

--==========================================================
--     ________  ___   ______________________  _   _______
--    / ____/ / / / | / / ____/_  __/  _/ __ \/ | / / ___/
--   / /_  / / / /  |/ / /     / /  / // / / /  |/ /\__ \ 
--  / __/ / /_/ / /|  / /___  / / _/ // /_/ / /|  /___/ / 
-- /_/    \____/_/ |_/\____/ /_/ /___/\____/_/ |_//____/  
--==========================================================
----------------------------------------------------------------------------------
-- Just some helper functions making setup less repetitive
----------------------------------------------------------------------------------
function nmap(left,right)
    vim.keymap.set('n', left, right)
end

function abbrev(short, expand)
    vim.cmd('cnoreabbrev ' .. short .. ' ' .. expand)
end

function executable(name)
    return vim.fn.executable(name) == 1
end

function autocmd(mode, ext, cmd)
    vim.api.nvim_create_autocmd(mode,{
        pattern = ext,
        command = cmd
    })
end

--===================================================
--     ____  __________  _____ ____  _   _____    __ 
--    / __ \/ ____/ __ \/ ___// __ \/ | / /   |  / / 
--   / /_/ / __/ / /_/ /\__ \/ / / /  |/ / /| | / /  
--  / ____/ /___/ _, _/___/ / /_/ / /|  / ___ |/ /___
-- /_/   /_____/_/ |_|/____/\____/_/ |_/_/  |_/_____/
--===================================================
----------------------------------------------------------------------------------
-- Generate a sequence of numbers based on interactive input
----------------------------------------------------------------------------------
function gen()
    local beginRange = vim.fn.input("Begin Range: ")
    local endRange = vim.fn.input("End Range: ")
    local prefix = vim.fn.input("Prefix: ")
    local suffix = vim.fn.input("Suffix: ")

    vim.cmd("silent for i in range(" .. beginRange .. "," .. endRange .. ") | put ='" .. prefix .. "'.i.'" .. suffix .. "' | endfor | -" .. (endRange - beginRange) )
end

--==========================================================
--     ___   __  ____________  __    ____  ___    ____ 
--    /   | / / / /_  __/ __ \/ /   / __ \/   |  / __ \
--   / /| |/ / / / / / / / / / /   / / / / /| | / / / /
--  / ___ / /_/ / / / / /_/ / /___/ /_/ / ___ |/ /_/ / 
-- /_/  |_\____/ /_/  \____/_____/\____/_/  |_/_____/  
--==========================================================
autocmd({"BufNewFile", "BufRead"}, {"*.jsx"}, "set filetype=javascriptreact")
autocmd({"BufNewFile", "BufRead"}, {"*.rasi"}, "setf css")
autocmd({"Filetype"}, {"*"}, "AnyFoldActivate")

--==========================================================
--     ___    ____  ____  ____  _______    __
--    /   |  / __ )/ __ )/ __ \/ ____/ |  / /
--   / /| | / __  / __  / /_/ / __/  | | / / 
--  / ___ |/ /_/ / /_/ / _, _/ /___  | |/ /  
-- /_/  |_/_____/_____/_/ |_/_____/  |___/   
--==========================================================
if vim.g.os ~= "Windows_NT" then
    abbrev('zshrc', 'edit ~/.zshrc')
end
abbrev('Ghead', 'Gvsplit HEAD~3:%')
abbrev('vimrc', [[edit <C-R>=expand(stdpath('config') . '/init.lua')<CR>]])
abbrev('snippet', [[NvimTreeOpen <C-R>=expand(stdpath('config') . '/snippets')<CR>]])

-- Make current buffer's path to working path, so FZF can work correctly
abbrev('cdthis', [[cd <C-R>=expand("%:p:h")<CR>]])
abbrev('lang', 'set syntax=')
abbrev('gen', ':lua gen()')

-- If you need to copy content with notepad, or just use "+y and copy it to system clipboard
abbrev('open', 'silent !notepad.exe %')
abbrev('exp', 'silent !explorer.exe <C-R>=expand("%:p:h")<CR>')

--==========================================================
--     __  ______    ____  ____  _____   _____________
--    /  |/  /   |  / __ \/ __ \/  _/ | / / ____/ ___/
--   / /|_/ / /| | / /_/ / /_/ // //  |/ / / __ \__ \ 
--  / /  / / ___ |/ ____/ ____// // /|  / /_/ /___/ / 
-- /_/  /_/_/  |_/_/   /_/   /___/_/ |_/\____//____/  
--==========================================================
----------------------------------------------------------------------------------
-- The remap you dont know you need
----------------------------------------------------------------------------------
nmap(';', ':')

----------------------------------------------------------------------------------
-- Quick navigation
----------------------------------------------------------------------------------
nmap('dA', 'd$')
nmap('dI', 'd^')

nmap('n', 'nzz')
nmap('N', 'Nzz')

nmap('<', '<<')
nmap('>', '>>')

nmap('<C-d>', '<C-d>zz')
nmap('<C-u>', '<C-u>zz')

----------------------------------------------------------------------------------
-- Buffer wide substitute
----------------------------------------------------------------------------------
nmap('<Leader>s', ':%s/')

----------------------------------------------------------------------------------
-- Clear last search highlight
----------------------------------------------------------------------------------
nmap('<Leader>c', ':let @/=\'\'<CR>')

--==========================================================
--     ____  ___   ________ __ __________ 
--    / __ \/   | / ____/ //_// ____/ __ \
--   / /_/ / /| |/ /   / ,<  / __/ / /_/ /
--  / ____/ ___ / /___/ /| |/ /___/ _, _/ 
-- /_/   /_/  |_\____/_/ |_/_____/_/ |_|  
--==========================================================
vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
    ----------------------------------------------------------------------------------
    -- Packer can manage itself
    ----------------------------------------------------------------------------------
    use {
        'wbthomason/packer.nvim',
        config = function()
            abbrev('install', 'PackerUpdate')
            abbrev('update', 'PackerCompile')
        end
    }

    use{
        '4542elgh/darcula.nvim',
        requires = {{'tjdevries/colorbuddy.nvim'}},
        config = function()
            require("darcula")
        end
    }

    ----------------------------------------------------------------------------------
    -- NEED FOR SPEED
    ----------------------------------------------------------------------------------
    use {
        'lewis6991/impatient.nvim',
        config = function ()
            require('impatient')
        end
    }

    ----------------------------------------------------------------------------------
    -- Profiling
    ----------------------------------------------------------------------------------
    -- use 'dstein64/vim-startuptime'

    ----------------------------------------------------------------------------------
    -- Status line
    ----------------------------------------------------------------------------------
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'powerline_dark'
                },
                sections = {
                    lualine_c = {
                        'lsp_progress'
                    }
                }
            }
        end
    }

    ----------------------------------------------------------------------------------
    -- Fast Searcher
    ----------------------------------------------------------------------------------
    if executable('fzf') then
        use {
            requires = {{ 'junegunn/fzf' }},
            'junegunn/fzf.vim',
            config = function()
                nmap('<Leader>a', ':Ag<CR>')
                nmap('<Leader>f', ':FZF<CR>')
                nmap('<Leader>l', ':Lines<CR>')
                nmap('<Leader>r', ':History<CR>')
                vim.cmd([[tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"]])
            end
        }
    end

    ----------------------------------------------------------------------------------
    -- Coding support
    ----------------------------------------------------------------------------------
    use 'farmergreg/vim-lastplace'
    use 'jiangmiao/auto-pairs'
    use {
        'tomtom/tcomment_vim',
        keys = {'gc', 'gcc'}
    }
    use 'preservim/tagbar'
    use 'tpope/vim-surround'
    use 'xiyaowong/nvim-cursorword'

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }

    use {
        's1n7ax/nvim-terminal',
        config = function()
            vim.o.hidden = true
            require('nvim-terminal').setup({
                window = {
                    height = 7,
                },
                toggle_keymap = '<leader>t',
            })
        end,
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    use {
        'pseewald/vim-anyfold',
        config = function()
            vim.cmd('set foldlevelstart=99')
            vim.g.indentLine_enabled = 1
        end
    }

    use {
        'petertriho/nvim-scrollbar',
        config = function()
            require("scrollbar").setup({
                -- handle = {
                --     text = "   ",
                -- },
                -- marks = {
                --     Search = { text = { "--", "==" } },
                --     Error = { text = { "--", "==" } },
                --     Warn = { text = { "--", "==" } },
                --     Info = { text = { "--", "==" } },
                --     Hint = { text = { "--", "==" } },
                --     Misc = { text = { "--", "==" } },
                -- }
            })
        end
    }

    use 'junegunn/vim-easy-align'

    use {
        'luochen1990/rainbow',
        config = function()
            vim.g.rainbow_active = 1
        end
    }

    use {
        'alvan/vim-closetag',
        config = function()
            vim.g.closetag_filenames = '*.html,*.xhtml,*.vue,*.jsx'
            vim.g.closetag_emptyTags_caseSensitive = 1
        end
    }

    use {
        'nathanaelkane/vim-indent-guides',
        config = function()
            vim.g.indent_guides_enable_on_vim_startup = 1
            vim.g.indent_guides_exclude_filetypes = {'help', 'nvimtree', 'startify'}
        end
    }

    use {
        'mbbill/undotree',
        config = function()
            nmap('<Leader>u', ':UndotreeToggle<CR>')
            vim.cmd([[
                if has("persistent_undo")
                    let target_path = expand(stdpath('config') . '\undodir')
                    if !isdirectory(target_path)
                        call mkdir(target_path, "p", 0700)
                    endif
                    let &undodir=target_path
                    set undofile
                endif
                ]]
            )
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        config = function ()
            nmap('<Leader>n', ":NvimTreeToggle<CR>")
            require("nvim-tree").setup({
                respect_buf_cwd = true,
                sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                    mappings = {
                        list = {
                            { key = "<left>", action = "dir_up" },
                            { key = "<right>", action = "cd" },
                            { key = "c", action = "create" },
                        },
                    },
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end
    }
    ----------------------------------------------------------------------------------
    -- Make Vim default better
    ----------------------------------------------------------------------------------
    use 'moll/vim-bbye'
    use 'junegunn/vim-peekaboo'

    use {
        'mihaifm/bufstop',
        config = function()
            nmap('<Leader>b', ':BufstopFast<CR>')
        end
    }

    use {
        'ggandor/lightspeed.nvim',
        keys = "f",
        config = function()
            require('lightspeed').setup {
                ignore_case = true,
            }
            vim.g.lightspeed_no_default_keymaps = true
            nmap("f", "<Plug>Lightspeed_omni_s")
        end
    }

    use {
        'hrsh7th/cmp-cmdline',
        config = function()
            local cmp = require('cmp')
            cmp.setup.cmdline(':', {
                sources = {
                    { name = 'cmdline' }
                }
            })
        end
    }

    ----------------------------------------------------------------------------------
    -- LSP Support
    ----------------------------------------------------------------------------------
    -- KEEP THE ORDER THIS WAY for LSP to work correctly
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'saadparwaiz1/cmp_luasnip'
    use 'arkav/lualine-lsp-progress'
    use 'kyazdani42/nvim-web-devicons'

    use {
        'VonHeikemen/lsp-zero.nvim',
        config = function()
            local lsp = require('lsp-zero')
            lsp.preset('recommended')
            lsp.setup()

            -- !!! If you use Mason to install typescript-language-server 
            -- !!! You will also need to use npm to install typescript-language-server
            -- !!! npm install typescript-language-server
            require'lspconfig'.sumneko_lua.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    }
                }
            }
        end
    }

    use {
        'onsails/lspkind.nvim',
        config = function()
            local lspkind = require('lspkind')
            require('cmp').setup {
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text', -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    })
                }
            }
        end
    }

    use {
        'glepnir/lspsaga.nvim',
        config = function()
            local saga = require('lspsaga')
            saga.init_lsp_saga({
                symbol_in_winbar = {
                    enable = false,
                },
            })
            local keymap = vim.keymap.set
            -- The REAL Peak Definition
            keymap("n", "gp", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
            -- Code action
            keymap({"n","v"}, "ga", "<cmd>Lspsaga code_action<CR>", { silent = true })
            -- Rename
            keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
            -- Peak Definition even though it suppose to go to definition
            keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
            -- Hover Doc
            keymap("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
            -- Show line diagnostics
            keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
        end
    }

    ----------------------------------------------------------------------------------
    -- LSP diagnostics / error console
    ----------------------------------------------------------------------------------
    use {
        'folke/trouble.nvim',
        config = function()
            nmap('<Leader>d', ':TroubleToggle<CR>')
        end
    }

    ----------------------------------------------------------------------------------
    -- Autocompletion
    ----------------------------------------------------------------------------------
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require "cmp"
            cmp.setup {
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
                    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
                },
            }
        end
    }

    ----------------------------------------------------------------------------------
    -- Snippets
    ----------------------------------------------------------------------------------
    use {
        'L3MON4D3/LuaSnip',
        config = function()
            local snipLocation = ""
            if(vim.loop.os_uname().sysname == "Windows_NT") then
                snipLocation = os.getenv("LOCALAPPDATA") .. "\\nvim\\snippets"
            else
                snipLocation = "~/.config/nvim/snippets"
            end
            require("luasnip.loaders.from_vscode").load({ paths = snipLocation })
            require("luasnip").filetype_extend("vimwiki", {"markdown"})
        end
    }

    use 'rafamadriz/friendly-snippets'

    ----------------------------------------------------------------------------------
    -- Note taking
    ----------------------------------------------------------------------------------
    use {
        'vimwiki/vimwiki',
        config = function()
            vim.cmd("let g:vimwiki_list = [{'path': stdpath('config') . '\\vimwiki', 'syntax': 'markdown', 'ext': '.md'}]")
            abbrev('wiki', 'VimwikiIndex')
        end
    }

    ----------------------------------------------------------------------------------
    -- Dashboard
    ----------------------------------------------------------------------------------
    use {
        'mhinz/vim-startify',
        config = function()
            vim.cmd("let g:footer = [['Enjoy Neovim! You know you made the right choice when switching to NeoVim!']]")
            vim.g.startify_session_dir = '~/AppData/Local/nvim/session'
            vim.g.startify_session_persistence = 1
            vim.g.startify_session_number = 10
            vim.g.startify_session_sort = 1
            vim.cmd("let g:startify_custom_footer = 'startify#pad(g:footer[0])'")
            abbrev('dash', 'Startify')
        end
    }

    ----------------------------------------------------------------------------------
    -- Discord Presence
    ----------------------------------------------------------------------------------
    use 'andweeb/presence.nvim'

    if packer_bootstrap then
        require('packer').sync()
    else
        -- This was causing conflict with Packer bootstrap
        autocmd({"Filetype"}, {"*"}, "AnyFoldActivate")
    end
end)
