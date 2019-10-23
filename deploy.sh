#!/usr/bin/env bash
#change respo
sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
sudo curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#install epel repo
sudo yum -y install epel-release
#make cache
sudo yum clean all &&  sudo yum makecache

#install git
sudo yum install git
#install vim 8
vim_src_path=~/software/vim_src
sudo yum instal gcc  libXt-devel.x86_64 ncurses-devel.x86_64
git clone https://github.com/vim/vim.git $vim_src_path
cd $vim_src_path
./configure --enable-gui=X11 --enable-gui --with-x=yes  --enable-cscope --enable-multibyte --enable-xim --enable-fontset --with-features=huge
make && sudo make install


#install ack
mkdir ~/bin
#curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
cp ./ack ~/bin/ack
chmod 0755 ~/bin/ack
cp ./new_bash.sh ~/bin/
#for vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
cp .vimrc .gvimrc .pryrc ~/
vim +PluginInstall +qa
cp .gitconfig ~/

git clone git://github.com/wting/autojump.git ~/software/autojump
cd ~/software/autojump
./install.py



# snipmate-snippets
#git submodule init; git submodule update
#cd snipmate-snippets/; rake deploy_local; cd -

#install docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum -y install docker-ce

sudo systemctl enable docker
sudo systemctl start docker
