""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Llama's .vimrc file, settings are arranged by order of "
" most used to least-used configuration types. Enjoy =)  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""
" Enable Vim-Plug "
"""""""""""""""""""
let mapleader = " "
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
""""""""""""""""""""""""""""
" Enable / Install Plugins "
""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
Plug 'dense-analysis/ale'
Plug 'davidhalter/jedi-vim'
Plug 'vim-test/vim-test'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'preservim/vim-pencil'
call plug#end()

"""""""""""""""""""
" PLUGIN SETTINGS "
"""""""""""""""""""
" ALE settings "
let g:ale_linters = { 'python': ['flake8'] }
let g:ale_fixers = { 'python': ['black'] }
let g:ale_fix_on_save = 1
" Coc.nvim setings "
let g:coc_global_extensions = ['coc-json', 'coc-dictionary', 'coc-pyright', 'coc-ltex']

""""""""""""
" KEYBINDS "
""""""""""""
" Personal keymaps "
nmap <leader>w :w<CR>
nmap <leader>W :wq<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>
" NERDTree "
nmap <leader>\ :NERDTreeToggle<CR>
nmap <leader>o :NERDTreeFocus<CR>
nmap <leader>] :NERDTreeExplore<CR>
" Running Python code "
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

""""""""""""""""""""
" GENERAL SETTINGS "
""""""""""""""""""""
" show line numbers "
set number
set relativenumber
" enable syntax highlighting "
syntax on
filetype plugin indent on

"""""""""""""""""""
" PYTHON SETTINGS "
"""""""""""""""""""
" Python indentation options "
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab
" Running Python code "
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"""""""""""""""""""""
" MARKDOWN SETTINGS "
"""""""""""""""""""""

""""""""""""""""""""""""""
" COLOR / THEME SETTINGS "
""""""""""""""""""""""""""
" colorschemes "
" NOTE: they  have to be in order! "
set termguicolors
set background=dark
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_italic = 1
autocmd vimenter * ++nested colorscheme gruvbox
" ALE highlight fixes "
highlight ALEError guifg=#ff5555 guibg=NONE ctermfg=Red ctermbg=NONE
highlight ALEWarning guifg=#ffaa00 guibg=NONE ctermfg=Yellow ctermbg=NONE
highlight ALEInfo guifg=#00afff guibg=NONE ctermfg=Cyan ctermbg=NONE
" Optional: signs in the gutter "
highlight ALEErrorSign guifg=#ff5555 guibg=NONE ctermfg=Red ctermbg=NONE
highlight ALEWarningSign guifg=#ffaa00 guibg=NONE ctermfg=Yellow ctermbg=NONE
highlight ALEInfoSign guifg=#00afff guibg=NONE ctermfg=Cyan ctermbg=NONE
" Popup menu colors "
highlight Pmenu guibg=#1c1c1c guifg=#d0d0d0 ctermbg=236 ctermfg=252
highlight PmenuSel guibg=#5f87ff guifg=#ffffff ctermbg=69 ctermfg=15
highlight PmenuSbar guibg=#444444 ctermbg=238
highlight PmenuThumb guibg=#aaaaaa ctermbg=248
" Coc floating window (docs, signature help) "
highlight CocFloating guibg=#1c1c1c guifg=#d0d0d0 ctermbg=236 ctermfg=252
