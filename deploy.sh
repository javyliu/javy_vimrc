#!/usr/bin/env bash
#install ack
mkdir ~/bin
#curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
cp ./ack ~/bin/ack
chmod 0755 ~/bin/ack
#fot vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
cp .vimrc .gvimrc .pryrc ~/
vim +PluginInstall +qa
cp .gitconfig ~/

# snipmate-snippets
#git submodule init; git submodule update
#cd snipmate-snippets/; rake deploy_local; cd -
