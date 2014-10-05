#!/bin/bash
sudo apt-get install vim

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
ln -s $PWD/vimrc.symlink $HOME/.vimrc
vim +PluginInstall +qall
