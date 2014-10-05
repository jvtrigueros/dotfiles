dotfiles
=======

It seems like having a dotfiles repo is a good idea so I'm deciding to give it a shot. 
At the moment I'm putting this together on Linux Mint, but really any Debian based distro
should work.

For each of the sections below, there will be a corresponding folder. This way these can be called independently of each other, say for instance I want to _only_ symlink my configuration files into my home directory, but I don't need to install or set up anything else, then I would just call the script associated with the symlink folder.

Setup
-------

There are some things that must be installed before we can even continue, here's the list:

* build-essential
* git

Install
-------

~~git~~
oracle-java
git
z
zsh

Symlink
-------

~~.gitconfig~~
~~.vimrc~~

alias
-----

Scratchpad
----------

CONFIG_PATH=$(cd "$(dirname "$0")" && pwd)

clipit
meld
git extras
    $ (cd /tmp && git clone --depth 1 https://github.com/visionmedia/git-extras.git && cd git-extras && sudo make install)
