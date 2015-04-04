#!/bin/bash
echo Installing Antigen
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen

echo Setting zsh to be the default shell
#chsh -s `which zsh`

echo Copying the zshrc configuration
ln -s $PWD/zshrc.symlink $HOME/.zshrc
