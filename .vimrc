let mapleader = " "
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'davidhalter/jedi-vim'
Plug 'vim-test/vim-test'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
call plug#end()

"ALE settings
let g:ale_linters = { 'python': ['flake8'] }
let g:ale_fixers = { 'python': ['black'] }
let g:ale_fix_on_save = 1

" Personal keymaps
nmap <leader>w :w<CR>
nmap <leader>W :wq<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>


" Custom keymappings
	" Vim Test
nmap <leader>t :TestNearest<CR>
nmap <leader>T :TestFile<CR>
nmap <leader>s :TestSuite<CR>
	" NERDTree
nmap <leader>\ :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFocus<CR>
nmap <leader>e :NERDTreeExplore<CR>


" Running Python code
nmap <leader>P :!python3 %<CR>

" Python specific settings
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab

" show line numbers
set number
set relativenumber

" enable syntax highlighting
syntax on
filetype plugin indent on

" colorschemes, have to be in order!
set termguicolors
set background=dark
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_italic = 1
autocmd vimenter * ++nested colorscheme gruvbox

" ALE highlight fixes
" highlight ALEError guifg=#ff5555 guibg=NONE ctermfg=Red ctermbg=NONE
" highlight ALEWarning guifg=#ffaa00 guibg=NONE ctermfg=Yellow ctermbg=NONE
" highlight ALEInfo guifg=#00afff guibg=NONE ctermfg=Cyan ctermbg=NONE

" Optional: signs in the gutter
" highlight ALEErrorSign guifg=#ff5555 guibg=NONE ctermfg=Red ctermbg=NONE
" highlight ALEWarningSign guifg=#ffaa00 guibg=NONE ctermfg=Yellow ctermbg=NONE
" highlight ALEInfoSign guifg=#00afff guibg=NONE ctermfg=Cyan ctermbg=NONE

" Popup menu colors
highlight Pmenu guibg=#1c1c1c guifg=#d0d0d0 ctermbg=236 ctermfg=252
highlight PmenuSel guibg=#5f87ff guifg=#ffffff ctermbg=69 ctermfg=15
highlight PmenuSbar guibg=#444444 ctermbg=238
highlight PmenuThumb guibg=#aaaaaa ctermbg=248

" Coc floating window (docs, signature help)
highlight CocFloating guibg=#1c1c1c guifg=#d0d0d0 ctermbg=236 ctermfg=252

