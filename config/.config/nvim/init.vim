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

"--------------------------------------------------------------------------------
" Windows integration
"--------------------------------------------------------------------------------
source $VIMRUNTIME/mswin.vim
behave mswin
" Make Arrow key work in Windows mode
set keymodel-=stopsel

"--------------------------------------------------------------------------------
" The mapping you dont think you need, but it change your life
"--------------------------------------------------------------------------------
nnoremap ; :

"--------------------------------------------------------------------------------
" ,s trigger substitute syntax
"--------------------------------------------------------------------------------
nnoremap <Leader>s :%s/

"--------------------------------------------------------------------------------
" Faster delete
"--------------------------------------------------------------------------------
nnoremap dA d$
nnoremap dI d^

"--------------------------------------------------------------------------------
" Switch window pane
"--------------------------------------------------------------------------------
nnoremap <C-l> <C-w>l<cr>
nnoremap <C-h> <C-w>h<cr>
nnoremap <C-j> <C-w>j<cr>
nnoremap <C-k> <C-w>k<cr>


"--------------------------------------------------------------------------------
" Floaterm
"--------------------------------------------------------------------------------
nmap <Leader>t :FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>

"--------------------------------------------------------------------------------
" Terminal Mode have weird mapping, dont use <C-m> or <C-[>
"--------------------------------------------------------------------------------
tnoremap <silent> <C-n> <C-\><C-n>:FloatermNew<CR>
tnoremap <silent> <C-l> <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <C-w> <C-\><C-n>:FloatermKill<CR>

"--------------------------------------------------------------------------------
" Buffer toggle
"--------------------------------------------------------------------------------
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

"--------------------------------------------------------------------------------
" Abbrev in command mode
"--------------------------------------------------------------------------------
cnoreabbrev ag Ack!
cnoreabbrev lang set syntax=
cnoreabbrev vimrc edit ~/.config/nvim/init.vim 
cnoreabbrev zshrc edit ~/.zshrc
cnoreabbrev sourcethis source %
cnoreabbrev Gdiff Gdiffsplit
cnoreabbrev debugger Trouble
"Vsplit current file from 3 commits ago
cnoreabbrev Ghead Gvsplit HEAD~3:% 
cnoreabbrev dash Startify
cnoreabbrev table VimwikiTable 

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"--------------------------------------------------------------------------------
"This is the begining of Vim-Plug
"--------------------------------------------------------------------------------
if has('win32')
    call plug#begin('~/AppData/Local/nvim/.vim')
else
    call plug#begin('~/.config/nvim/.vim')
endif

" Fast searcher
Plug 'mileszs/ack.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Status line
Plug 'itchyny/lightline.vim'

" Coding support
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tomtom/tcomment_vim'
Plug 'mkitt/tabline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'wellle/context.vim'
Plug 'luochen1990/rainbow',
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Make Vim default better
Plug 'moll/vim-bbye'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-peekaboo'
Plug 'pseewald/vim-anyfold'
Plug 'mihaifm/bufstop'

" Git status
Plug 'mhinz/vim-signify'

" Terminal 
Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-floaterm'

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" LSP enabled side nav
Plug 'kyazdani42/nvim-tree.lua'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" LSP sane default
Plug 'VonHeikemen/lsp-zero.nvim'

" LSP Debugger diagnostics
Plug 'folke/trouble.nvim'

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" Dashboard
Plug 'mhinz/vim-startify'

" Note taking
Plug 'vimwiki/vimwiki'

call plug#end()

let g:python3_host_prog = 'C:\Users\4542e\AppData\Local\Programs\Python\Python38\python.exe'
let g:vimwiki_list = [{'path': '~/AppData/Local/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
"--------------------------------------------------------------------------------
" Easymotion shortcuts
"--------------------------------------------------------------------------------
map / <Plug>(easymotion-sn)
nmap f <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

"--------------------------------------------------------------------------------
" CtrlP file search
"--------------------------------------------------------------------------------
nnoremap ' :CtrlP<CR> 
let g:ctrlp_map           = "'"
let g:ctrlp_cmd           = 'CtrlP'
let g:ctrlp_match_window  = 'results:100'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"--------------------------------------------------------------------------------
" SuperTAB loop in order (Default is reverse order)
"--------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

"--------------------------------------------------------------------------------
" Easy Align mapping
"--------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"--------------------------------------------------------------------------------
" Start indent Guide
"--------------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1

"--------------------------------------------------------------------------------
" Replace Netrw with ranger
"--------------------------------------------------------------------------------
if executable('ranger')
    let g:ranger_replace_netrw = 1 "open ranger when vim open a directory
endif

"--------------------------------------------------------------------------------
"This is for lightline tabline
"--------------------------------------------------------------------------------
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
"This is for Anyfold's plugin to auto start
"--------------------------------------------------------------------------------
autocmd Filetype * AnyFoldActivate 
set foldlevelstart=99
let g:indentLine_enabled = 1

"--------------------------------------------------------------------------------
" Change file detection
"--------------------------------------------------------------------------------
au BufNewFile,BufRead /*.jsx set filetype=javascript.jsx
au BufNewFile,BufRead /*.rasi setf css

nmap <Leader>d :TroubleToggle<CR>
nmap <Leader>n :NvimTreeToggle<CR>
nmap <Leader>b :BufstopFast<CR>
nmap <Leader>v :vs<CR>

" let g:context_enabled = 1

function Test()
    if !argc()
    else
        TroubleToggle
        NvimTreeToggle
        wincmd w
    endif
endfunction

autocmd VimEnter * call Test()

let g:indent_guides_exclude_filetypes = ['help', 'nvimtree', 'startify']

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

let g:footer = [
  \ [
  \ 'Enjoy Neovim! You know you made the right choice when switching to NeoVim!',
  \ ]]
let g:startify_custom_header = 'startify#pad(g:asciis[0])'

let g:startify_session_dir = '~/AppData/Local/nvim/session'
let g:startify_session_persistence = 1
let g:startify_session_number = 10
let g:startify_session_sort = 1
let g:startify_custom_footer = 'startify#pad(g:footer[0])'

let g:rainbow_active = 1

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
    local lsp = require('lsp-zero')
    lsp.preset('recommended')
    lsp.setup()
EOF

lua << EOF
    vim.g.loaded = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            adaptive_size = true,
            mappings = {
                list = {{ key = "u", action = "dir_up" }},
            },
        },
        renderer = { group_empty = true },
        filters = { dotfiles = true },
    })
EOF

