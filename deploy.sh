#!/usr/bin/env bash

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
cp .vimrc .gvimrc ~/
vim +PluginInstall +qa
cp .gitconfig ~/

# snipmate-snippets
#git submodule init; git submodule update
#cd snipmate-snippets/; rake deploy_local; cd -
