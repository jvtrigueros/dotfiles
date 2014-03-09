#!/bin/bash
sudo apt-get install vim

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s $PWD/vimrc.symlink $HOME/.vimrc
vim +BundleInstall +qall
