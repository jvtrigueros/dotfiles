call plug#begin('~/.vim/plugged')

Plug 'jeffkreeftmeijer/neovim-sensible'
Plug 'jdhao/better-escape.vim'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'

call plug#end()

" easymotion
nmap gss <Plug>(easymotion-overwin-f2)
