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
" Syntax
" Plug 'dense-analysis/ale'
" Code auto format
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" Color schemes
Plug 'morhetz/gruvbox'

call plug#end()

" Visual stuff
syntax enable
"set t_Co=256

let g:gruvbox_termcolors=16
colorscheme gruvbox
set bg=dark
"
""Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
""If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
""(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
"  if (has("nvim"))
"    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif

if version >= 703
  set colorcolumn=100
endif

highlight colorcolumn ctermbg=darkgray
