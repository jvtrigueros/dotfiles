#!/bin/bash
sudo apt-get install vim

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

ln -s $PWD/vimrc.symlink $HOME/.vimrc
