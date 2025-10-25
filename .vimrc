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
" Programming Plugins "
Plug 'davidhalter/jedi-vim'
Plug 'preservim/vim-wheel'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-signify'
" Writing Plugins "
" Dependencies "
Plug 'kana/vim-textobj-user'
" Main list "
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-textobj-quote'
Plug 'preservim/vim-wordy'
Plug 'preservim/vim-lexical'
Plug 'preservim/vim-textobj-sentence'
Plug 'preservim/vim-litecorrect'
Plug 'dbmrq/vim-ditto'
" General Plugins "
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
" Theme Plugins "
Plug 'morhetz/gruvbox'
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
" vim-pencil "
let g:pencil#cursorwrap = 1     " 0=disable, 1=enable (def)
" vim-lexical "
let g:lexical#thesaurus = ['~/.vim/thesaurus/mthesaur.txt', '~/.vim/thesaurus/words.txt',]
let g:lexical#thesaurus_key = '<leader>T'
" vim-signify " 
" default updatetime 4000ms is not good for async update
set updatetime=100

""""""""""""
" KEYBINDS "
""""""""""""
" Personal keymaps "
nmap <leader>w :w<CR>
nmap <leader>W :wq<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>
nmap <leader>n :Prose<CR>
" NERDTree "
nmap <leader>\ :NERDTreeToggle<CR>
nmap <leader>o :NERDTreeFocus<CR>
nmap <leader>] :NERDTreeExplore<CR>
" goyo.vim "
nmap <leader>g :Goyo<CR>
" vim-ditto "
" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
au FileType markdown,text,tex DittoOn  " Turn on Ditto's autocmds
nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off

" If you don't want the autocmds, you can also use an operator to check
" specific parts of your text:
" vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" nmap <leader>d <Plug>Ditto	       " Call Ditto on operator movement

nmap =d <Plug>DittoNext                " Jump to the next word
nmap -d <Plug>DittoPrev                " Jump to the previous word
nmap +d <Plug>DittoGood                " Ignore the word under the cursor
nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
nmap ]d <Plug>DittoMore                " Show the next matches
nmap [d <Plug>DittoLess                " Show the previous matches

""""""""""""""""""""
" GENERAL SETTINGS "
""""""""""""""""""""
" show line numbers "
set number
set relativenumber
" enable syntax highlighting "
syntax on
filetype plugin indent on

" enable goyo.vim + prose plugins upon initialization "
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Function to enable prose plugins "
function! Prose()
  Limelight!!
  PencilToggle
  setl spell spl=en_us fdl=4 noru nonu nornu
  setl fdo+=search
 
  call textobj#quote#init()
  call textobj#sentence#init()
  call lexical#init()
  call litecorrect#init()

  " manual reformatting shortcuts "
  nnoremap <buffer> <silent> Q gqap
  xnoremap <buffer> <silent> Q qq
  nnoremap <buffer> <silent> <leader>Q vapJgqap
 
  " force top correction on most recent misspelling " 
  nnoremap <buffer> <C-s> [s1z=<c-o>
  inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=']A<c-g>u
 
  " replace common punctuation " 
  iabbrev <buffer> -- –
  iabbrev <buffer> --- —
  iabbrev <buffer> << «
  iabbrev <buffer> >> »
  iabbrev <buffer> ...  …

  " replace typographical quotes ( via vim-textobj-quote ) "
  map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
  map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

  " Toggle Pencil current buffer autoformat "
  noremap <silent> <F7> :<C-u>PFormatToggle<cr>
  inoremap <silent> <F7> <C-o>:PFormatToggle<cr>

  " rapid-fire word highlighting ( via vim-wordy ) "
  noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>

endfunction
" manual activation by command "
command! -nargs=0 Prose call Prose()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE: I choose not to autoenable by filetype because there's times "
" 	when I don't want to start in 'Goyo' mode.		     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
