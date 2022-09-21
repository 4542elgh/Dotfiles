let mapleader=" "

colorscheme darcula
filetype plugin indent on 
syntax on
set nu
set relativenumber
set ignorecase
set smartcase
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set hidden
set cursorcolumn
set cursorline
set splitright
set splitbelow
set updatetime=100
set viminfo+='1000

" let g:python3_host_prog = 'C:\Users\mliu\AppData\Local\Programs\Python\Python310\python.exe'

"--------------------------------------------------------------------------------
" Windows integration
"--------------------------------------------------------------------------------
if has('win32')
    source $VIMRUNTIME/mswin.vim
    behave mswin
    " Make Arrow key work in Windows mode
    set keymodel-=stopsel
endif

"--------------------------------------------------------------------------------
" The mapping you dont think you need, but it change your life
"--------------------------------------------------------------------------------
nnoremap ; :

"--------------------------------------------------------------------------------
" Faster delete
"--------------------------------------------------------------------------------
nnoremap dA d$
nnoremap dI d^

"--------------------------------------------------------------------------------
" Leader key mapping
"--------------------------------------------------------------------------------
nmap <Leader>s :%s/
nmap <Leader>c :let @/=''<CR>

"--------------------------------------------------------------------------------
" Abbrev in command mode
"--------------------------------------------------------------------------------
cnoreabbrev lang set syntax=

" Abbrev need to expand with these special commands
cnoreabbrev vimrc edit <C-R>=expand(stdpath('config') . '/init.vim')<CR>
cnoreabbrev zshrc edit ~/.zshrc
cnoreabbrev sourcethis source %

"Vsplit current file from 3 commits ago
cnoreabbrev Ghead Gvsplit HEAD~3:% 

"--------------------------------------------------------------------------------
" Change file detection
"--------------------------------------------------------------------------------
au BufNewFile,BufRead /*.jsx set filetype=javascript.jsx
au BufNewFile,BufRead /*.rasi setf css

"--------------------------------------------------------------------------------
" This is the begining of Vim-Plug
"--------------------------------------------------------------------------------
" rather than ~, stdpath does not resolve path to H: drive for work pc
call plug#begin(stdpath('config') . '\.vim\plugged')

"--------------------------------------------------------------------------------
" Fast searcher
"--------------------------------------------------------------------------------
if executable('ag')
    Plug 'mileszs/ack.vim'
        " set Ack to use silver searcher(faster)
        let g:ackprg = 'ag --vimgrep'
        cnoreabbrev ag Ack!
endif

if executable('ranger')
    " ranger in Windows is not well supported
    Plug 'francoiscabrol/ranger.vim'
        " open ranger when vim open a directory
        let g:ranger_replace_netrw = 1 
endif

if executable('fzf')
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
        nmap <Leader>a :Ag<CR>
        nmap <Leader>f :FZF<CR>
        nmap <Leader>l :Lines<CR>
        tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
endif

"--------------------------------------------------------------------------------
" Status line
"--------------------------------------------------------------------------------
Plug 'itchyny/lightline.vim'
    let g:lightline#bufferline#show_number       = 1
    let g:lightline#bufferline#shorten_path      = 0
    let g:lightline#bufferline#unnamed           = '[No Name]'
    let g:lightline#bufferline#filename_modifier = ':t'
    let g:lightline                              = {}
    let g:lightline.separator                    = { 'left': '', 'right': '' }
    let g:lightline.tabline                      = {'left': [['buffers']], 'right': [['%{fugitive#statusline()}']]}
    let g:lightline.component_expand             = {'buffers': 'lightline#bufferline#buffers'}
    let g:lightline.component_type               = {'buffers': 'tabsel'}
    let g:lightline.active                       = {'left' : [ [ 'mode', 'paste'  ],[ 'gitbranch', 'readonly', 'filename', 'modified'  ] ] }
    let g:lightline.component_function           = {'gitbranch': 'FugitiveHead'}

"--------------------------------------------------------------------------------
" Coding support
"--------------------------------------------------------------------------------
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag' , { 'for': ['html', 'xml', 'vue', 'jsx'] }
Plug 'tomtom/tcomment_vim' 
Plug 'preservim/tagbar'

Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_exclude_filetypes = ['help', 'nvimtree', 'startify']

Plug 'junegunn/vim-easy-align' 
    nmap ga <Plug>(EasyAlign)

Plug 'mbbill/undotree'
    nmap <Leader>u :UndotreeToggle<CR>

Plug 'tpope/vim-surround' 
    if has("persistent_undo")
        let target_path = expand(stdpath('config') . '\undodir')
        if !isdirectory(target_path)
            call mkdir(target_path, "p", 0700)
        endif

        let &undodir=target_path
        set undofile
    endif

Plug 'wellle/context.vim'
    let g:context_enabled = 1

Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1

" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

"--------------------------------------------------------------------------------
" Make Vim default better
"--------------------------------------------------------------------------------
Plug 'moll/vim-bbye'

Plug 'easymotion/vim-easymotion'
    map / <Plug>(easymotion-sn)
    nmap f <Plug>(easymotion-overwin-f)
    let g:EasyMotion_smartcase = 1

Plug 'junegunn/vim-peekaboo' 

Plug 'pseewald/vim-anyfold'
    autocmd Filetype * AnyFoldActivate 
    set foldlevelstart=99
    let g:indentLine_enabled = 1

Plug 'mihaifm/bufstop', { 'on': 'BufstopFast' } 
    nmap <Leader>b :BufstopFast<CR>

Plug 'petertriho/nvim-scrollbar'

"--------------------------------------------------------------------------------
" Git status
"--------------------------------------------------------------------------------
" Plug 'mhinz/vim-signify'

"--------------------------------------------------------------------------------
" Terminal 
"--------------------------------------------------------------------------------
" Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-floaterm' , {'on': 'FloatermToggle'}
    nmap <Leader>t :FloatermToggle<CR>
    tnoremap <Esc> <C-\><C-n>
    "--------------------------------------------------------------------------------
    " Terminal Mode have weird mapping, dont use <C-m> or <C-[>
    "--------------------------------------------------------------------------------
    tnoremap <silent> <C-n> <C-\><C-n>:FloatermNew<CR>
    tnoremap <silent> <C-l> <C-\><C-n>:FloatermPrev<CR>
    tnoremap <silent> <C-w> <C-\><C-n>:FloatermKill<CR>

"--------------------------------------------------------------------------------
" LSP Support
"--------------------------------------------------------------------------------
Plug 'neovim/nvim-lspconfig'
    cnoreabbrev refactor lua vim.lsp.buf.rename()<CR>

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'VonHeikemen/lsp-zero.nvim'

"--------------------------------------------------------------------------------
" LSP Debugger diagnostics
"--------------------------------------------------------------------------------
Plug 'folke/trouble.nvim'
    nmap <Leader>d :TroubleToggle<CR>
    cnoreabbrev debugger Trouble

"--------------------------------------------------------------------------------
" Autocompletion
"--------------------------------------------------------------------------------
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"--------------------------------------------------------------------------------
" Snippets
"--------------------------------------------------------------------------------
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

"--------------------------------------------------------------------------------
" Icons
"--------------------------------------------------------------------------------
Plug 'kyazdani42/nvim-web-devicons'

"--------------------------------------------------------------------------------
" Dashboard
"--------------------------------------------------------------------------------
Plug 'mhinz/vim-startify'
    let g:asciis = [
      \ [
      \ '                                    @       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    ',
      \ '                                 @@@@       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@       ',
      \ '                               @@@@@@       @@@@@@@@@@@@@@@@@@@@@@@@@@@         ',
      \ '                            @@@@@@@@@       @@@@@@@@@@@@@@@@@@@@@@@@            ',
      \ '                          @@@@@@@@@@@       @@@@@@@@@@@@@@@@@@@@@@              ',
      \ '                       @@@@@@@@@@@@@@       @@@@@@@@@@@@@@@@@@@                 ',
      \ '                     @@@@@@@@@@@@@@@@       @@@@@@@@@@@@@@@@@                   ',
      \ '                  @@@@@@@@@@@@@@@@@@@       @@@@@@@@@@@@@@                      ',
      \ '                @@@@@@@@@@@@@@@@@@@@@       @@@@@@@@@@@@                        ',
      \ '             @@@@@@@@@@@@@@@@@@@@@@@@       @@@@@@@@@                           ',
      \ '           @@@@@@@@@@@@@@@@@@@@@@@@@@       @@@@@@@                             ',
      \ '        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@       @@@@                                ',
      \ '      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       @@                                  ',
      \ ]
      \ ]

    let g:footer = [['Enjoy Neovim! You know you made the right choice when switching to NeoVim!']]
    let g:startify_custom_header = 'startify#pad(g:asciis[0])'

    let g:startify_session_dir = '~/AppData/Local/nvim/session'
    let g:startify_session_persistence = 1
    let g:startify_session_number = 10
    let g:startify_session_sort = 1
    let g:startify_custom_footer = 'startify#pad(g:footer[0])'

    cnoreabbrev dash Startify

"--------------------------------------------------------------------------------
" Note taking
"--------------------------------------------------------------------------------
" Somewhat slow during startup, load only on Vim-Wiki Index command
Plug 'vimwiki/vimwiki' , { 'on': 'VimwikiIndex' } 
    let g:vimwiki_list = [{'path': stdpath('config') . '\vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
    cnoreabbrev table VimwikiTable 
    cnoreabbrev wiki VimwikiIndex

call plug#end()

lua << EOF
    local lsp = require('lsp-zero')
    lsp.preset('recommended')
    lsp.setup()

    -- !!! If you use Mason to install typescript-language-server 
    -- !!! You will also need to use npm to install typescript-language-server
    -- !!! npm install typescript-language-server
EOF

lua << EOF
    require'lspconfig'.sumneko_lua.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    }
EOF

lua << EOF
    require("scrollbar").setup({
        handle = {
            text = "   ",
        },
        marks = {
            Search = { text = { "--", "==" } },
            Error = { text = { "--", "==" } },
            Warn = { text = { "--", "==" } },
            Info = { text = { "--", "==" } },
            Hint = { text = { "--", "==" } },
            Misc = { text = { "--", "==" } },
        }
    })
EOF

lua << EOF
    snipLocation = ""
    if(vim.loop.os_uname().sysname == "Windows_NT")
    then
        snipLocation = os.getenv("LOCALAPPDATA") .. "\\nvim\\snippets"
    else
        snipLocation = "~/.config/nvim/snippets"
    end 
    require("luasnip.loaders.from_vscode").load({ paths = snipLocation }) 
    require("luasnip").filetype_extend("vimwiki", {"markdown"})
EOF
