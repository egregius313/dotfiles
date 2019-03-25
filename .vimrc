call plug#begin("~/.vim/plugged")

Plug 'cespare/vim-toml'
Plug 'editorconfig/editorconfig-vim'
Plug 'powerline/powerline'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tomasr/molokai'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'

call plug#end()

set autowrite
set number
set wrap

colorscheme molokai

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" support going C-a C-k in insert-mode to support deleting a line like in
" Emacs
inoremap <c-a><c-k> <ESC>ddi

" Automatically use a 2-space tabs in C
autocmd FileType c setlocal shiftwidth=2


map <C-n> :NERDTreeToggle<CR>
