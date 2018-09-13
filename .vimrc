call plug#begin("~/.vim/plugged")

Plug 'cespare/vim-toml'
Plug 'editorconfig/editorconfig-vim'
Plug 'powerline/powerline'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tomasr/molokai'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'

call plug#end()

set autowrite
set number
set wrap

colorscheme molokai
