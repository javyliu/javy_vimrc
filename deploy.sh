#!/usr/bin/env bash
#install ack
curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 !#:3
#fot vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
cp .vimrc .gvimrc ~/
vim +PluginInstall +qa
cp .gitconfig ~/

# snipmate-snippets
#git submodule init; git submodule update
#cd snipmate-snippets/; rake deploy_local; cd -
