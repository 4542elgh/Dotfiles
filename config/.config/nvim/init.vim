let mapleader=" "
filetype plugin indent on 
syntax on
set nu
set relativenumber
set termguicolors
set ignorecase
set smartcase
set tabstop=2
set shiftwidth=2
set hidden
set cursorcolumn
set cursorline
set splitright
set splitbelow

"--------------------------------------------------------------------------------
" Windows integration
"--------------------------------------------------------------------------------
source $VIMRUNTIME/mswin.vim
behave mswin

"--------------------------------------------------------------------------------
" The mapping you dont think you need, but it change your life
"--------------------------------------------------------------------------------
nnoremap ; :

"--------------------------------------------------------------------------------
" Rofi file extensions interpret as css syntax
"--------------------------------------------------------------------------------
au BufNewFile,BufRead /*.rasi setf css

"--------------------------------------------------------------------------------
" ,s trigger substitute syntax
"--------------------------------------------------------------------------------
nnoremap <Leader>s :%s/

"--------------------------------------------------------------------------------
" Exit terminal mode
"--------------------------------------------------------------------------------
tnoremap <Esc> <C-\><C-n>

"--------------------------------------------------------------------------------
" This is for configure lightline bufferline
"--------------------------------------------------------------------------------
set showtabline=2

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
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'results:100' 

"--------------------------------------------------------------------------------
" Floaterm
"--------------------------------------------------------------------------------
nmap <Leader>t :FloatermToggle<CR>

"--------------------------------------------------------------------------------
" NerdTree
"--------------------------------------------------------------------------------
nmap <Leader>p :NERDTreeToggle<CR>

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
"LEARN TO BE A BETTER VIMMER
"--------------------------------------------------------------------------------
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"--------------------------------------------------------------------------------
" Abbrev in command mode
"--------------------------------------------------------------------------------
cnoreabbrev ag Ack!
cnoreabbrev language set syntax=
cnoreabbrev snipedit UltiSnipsEdit
cnoreabbrev vimrc edit ~/.config/nvim/init.vim 
cnoreabbrev sourcethis source %
cnoreabbrev termlist CocList floaterm
cnoreabbrev fzf FloatermNew fzf --preview 'bat --theme=darkula --color=always {}'
cnoreabbrev ranger FloatermNew ranger

"--------------------------------------------------------------------------------
"This is the begining of Vim-Plug
"--------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'pseewald/vim-anyfold'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'moll/vim-bbye'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'alvan/vim-closetag'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'doums/darcula'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'skywind3000/asyncrun.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'ervandew/supertab'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'neoclide/coc.nvim'
Plug 'ervandew/supertab'
Plug 'voldikss/vim-floaterm'
Plug 'francoiscabrol/ranger.vim'

call plug#end()

"--------------------------------------------------------------------------------
"Set vim editor theme to Jetbrains Darcula 
"--------------------------------------------------------------------------------
colorscheme darcula

"--------------------------------------------------------------------------------
" SuperTAB loop in order (Default is reverse order)
"--------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

"--------------------------------------------------------------------------------
" Start indent Guide
"--------------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1

"--------------------------------------------------------------------------------
" Replace Netrw with ranger
"--------------------------------------------------------------------------------
let g:NERDTreeHijackNetrw = 0 "add this line if you use NERDTree
let g:ranger_replace_netrw = 1 "open ranger when vim open a directory

"--------------------------------------------------------------------------------
"This is for lightline tabline
"--------------------------------------------------------------------------------
let g:lightline#bufferline#show_number       = 1
let g:lightline#bufferline#shorten_path      = 0
let g:lightline#bufferline#unnamed           = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline                  = {}
let g:lightline.separator        = { 'left': '', 'right': '' }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

"--------------------------------------------------------------------------------
"This is for Anyfold's plugin to auto start
"--------------------------------------------------------------------------------
autocmd Filetype * AnyFoldActivate 
set foldlevelstart=99
let g:indentLine_enabled =1 

"--------------------------------------------------------------------------------
"This is for Ack.vim to use ag(faster) to search through file content
"--------------------------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
endif

"--------------------------------------------------------------------------------
" COC Snippets Keybind
"--------------------------------------------------------------------------------
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

imap <C-Enter> <Plug>(coc-snippets-expand)

nnoremap cA c$
nnoremap cI c^


