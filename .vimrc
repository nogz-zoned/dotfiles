set laststatus=2
set t_Co=256

" OPTIONS
set nocompatible
filetype off
set number
set history=1000
set visualbell
set autoread
syntax on

" HOTKEYS
map <C-n> :NERDTreeToggle<CR>

" PERSISTANT UNDO
if has('persistent_undo')
  silent !mkdir -p ~/.undo > /dev/null 2>&1
  set undodir=~/.undo
  set undofile
endif

" RUNTIME
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" PLUGINS
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'ervandew/supertab'
Plugin 'nathanaelkane/vim-indent-guides'

call vundle#end()

filetype plugin indent on
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
