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
set guifont=DejaVu\ Sans\ Mono:h15

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

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
" Easymotion shortcuts
"--------------------------------------------------------------------------------
map / <Plug>(easymotion-sn)
nmap f <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

"--------------------------------------------------------------------------------
"This is for CtrlP
"--------------------------------------------------------------------------------
nnoremap ' :CtrlP<CR> 
let g:ctrlp_map           = "'"
let g:ctrlp_cmd           = 'CtrlP'
let g:ctrlp_match_window  = 'results:100'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

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
" NerdTree
"--------------------------------------------------------------------------------
nmap <C-n> :NERDTreeToggle<CR>

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
	call webdevicons#refresh()
endif

let NERDTreeShowLineNumbers = 1
let NERDTreeShowHidden      = 1
let g:NERDTreeIgnore = ['node_modules']
autocmd FileType nerdtree setlocal relativenumber

nmap <Leader>y "*y

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
cnoreabbrev language set syntax=
cnoreabbrev snipedit UltiSnipsEdit
cnoreabbrev vimrc edit ~/.config/nvim/init.vim 
cnoreabbrev zshrc edit ~/.zshrc
cnoreabbrev sourcethis source %
cnoreabbrev Gdiff Gdiffsplit
"Vsplit current file from 3 commits ago
cnoreabbrev Ghead Gvsplit HEAD~3:% 

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"--------------------------------------------------------------------------------
"This is the begining of Vim-Plug
"--------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'
" Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'doums/darcula'
Plug 'easymotion/vim-easymotion'
Plug 'francoiscabrol/ranger.vim'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-peekaboo'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mileszs/ack.vim'
Plug 'mkitt/tabline.vim'
Plug 'mhinz/vim-signify'
Plug 'moll/vim-bbye'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'preservim/nerdtree'
Plug 'pseewald/vim-anyfold'
Plug 'rbgrouleff/bclose.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'skywind3000/asyncrun.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neovim/nvim-lspconfig'

call plug#end()
" let g:python3_host_prog = 'C:\Users\4542e\AppData\Local\Programs\Python\Python38\python.exe'

"--------------------------------------------------------------------------------
" SuperTAB loop in order (Default is reverse order)
"--------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

"--------------------------------------------------------------------------------
" Easy Align mapping
"--------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"--------------------------------------------------------------------------------
" Start indent Guide
"--------------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1

"--------------------------------------------------------------------------------
" Replace Netrw with ranger
"--------------------------------------------------------------------------------
let g:NERDTreeHijackNetrw  = 0 "add this line if you use NERDTree
let g:ranger_replace_netrw = 1 "open ranger when vim open a directory

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

:lua require'lspconfig'.pyright.setup{}

" let g:UltiSnipsExpandTrigger="<RET>"
