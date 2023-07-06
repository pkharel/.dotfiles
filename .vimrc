" Change backup scheme for webpack
set backupcopy=yes

" Change default buffer to system
"set clipboard=unnamedplus

" Enable mouse
"set mouse=a

" tab stuff
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

autocmd FileType python setlocal ts=4 sw=4 sts=2 et

" Set Word wrap to 80
set textwidth=100
set formatoptions+=t
set formatoptions-=l

" Auto install Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" On-demand loading
Plug 'tpope/vim-sensible'
" Plug 'Yggdroot/indentLine'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
" Syntac
Plug 'dense-analysis/ale'
" Code auto format
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" Color schemes
Plug 'Lokaltog/vim-distinguished'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

" Visual stuff
syntax enable
set t_Co=256
colorscheme distinguished
"colorscheme gruvbox
"set background=black

if version >= 703
  set colorcolumn=100
endif

highlight colorcolumn ctermbg=darkgray
