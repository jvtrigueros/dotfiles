call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'jdhao/better-escape.vim'
Plug 'jeffkreeftmeijer/neovim-sensible'
Plug 'justinmk/vim-sneak'
Plug 'sheerun/vim-polyglot'

call plug#end()

" easymotion
nmap gss <Plug>(easymotion-overwin-f2)
