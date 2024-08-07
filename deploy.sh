#!/usr/bin/env bash
#change respo
sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
sudo curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#install epel repo
sudo yum -y install epel-release
#make cache
sudo yum clean all &&  sudo yum makecache

#install git
#sudo yum install git
#install vim 8
vim_src_path=~/software/vim_src
mkdir -p $vim_src_path
sudo yum -y install gcc  libXt-devel.x86_64 ncurses-devel.x86_64
git clone https://github.com/vim/vim.git $vim_src_path
cd $vim_src_path
./configure --enable-gui=X11 --enable-gui --with-x=yes  --enable-cscope --enable-multibyte --enable-xim --enable-fontset --with-features=huge
make && sudo make install

#support rz sz
sudo yum -y install lrzsz

#install ack
mkdir ~/bin
#curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
cd ~/software/javy_vimrc

#cp ./ack ~/bin/ack
ln -s ~/software/javy_vimrc/ack ~/bin/
ln -s ~/software/javy_vimrc/docker-tags ~/bin/
ln -s ~/software/javy_vimrc/new-bash ~/bin/
ln -s ~/software/javy_vimrc/jq ~/bin/
#chmod 0755 ~/bin/ack
#cp ./new_bash.sh ~/bin/
#for vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc .gvimrc .pryrc ~/
vim +PluginInstall +qa
cp .gitconfig ~/

# 安装autojump
git clone git@github.com:wting/autojump.git ~/software/autojump
cd ~/software/autojump
./install.py

echo " [[ -s /home/${USER}/.autojump/etc/profile.d/autojump.sh ]] && source /home/${USER}/.autojump/etc/profile.d/autojump.sh" >> ~/.bashrc


#enable password login
sudo sed -i '/^PasswordAuthentication/s/no/yes/' /etc/ssh/sshd_config
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config # 永久禁止selinux
# snipmate-snippets
#git submodule init; git submodule update
#cd snipmate-snippets/; rake deploy_local; cd -

#install depencity software  for the rails
sudo yum -y install mysql_devel
curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum -y install nodejs
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum -y install yarn

#install mysql client
sudo yum install https://repo.mysql.com/yum/mysql-5.5-community/el/6/x86_64/mysql-community-client-5.5.60-2.el6.i686.rpm

#set the yarn registry
#yarn config set registry https://registry.npm.taobao.org
npm config set registry  https://registry.npmmirror.com

#install some tool
sudo yum install  -y tree wget bash-completion net-tools tcpdump ab expect
#install rvm
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
. ~/.bashrc
rvm install 2.6

#install imagemagick
sudo yum -y install ImageMagick
sudo sed -i '/pattern="LABEL"/s/none/read|write/' /etc/ImageMagick/policy.xml


#install docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum -y install docker-ce

sudo systemctl enable docker
sudo systemctl start docker

sudo groupadd docker #add docker group
sudo gpasswd -a $USER docker #add current user to docker group
newgrp docker #update docker group
#docker ps
#update docker mirror
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'>/dev/null
{
  "registry-mirrors": ["https://ngh30kcx.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

#postsql 源
#sudo yum install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rp

#install google-chrome-stable

sudo tee /etc/yum.repos.d/google-chrome.repo <<-'EOF'>/dev/null
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
sudo yum install -y google-chrome-stable

#install firefox
sudo yum install -y firefox
