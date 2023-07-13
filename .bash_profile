# User specific aliases and functions

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi
#alias kn='[[ -s "/home/wap/nginx/logs/nginx.pid" ]] && sudo kill `cat /home/wap/nginx/logs/nginx.pid`'
#alias sn='sudo /home/wap/nginx/sbin/nginx'
alias kn='sudo /etc/init.d/nginx stop'
alias sn='sudo /etc/init.d/nginx start'
alias rn='kn;sn'
alias srn='sudo /etc/init.d/nginx reload && echo ok'

alias nginx_edit='vim /home/wap/nginx/conf/nginx.conf'
alias sl='export LANG=zh_CN.utf8;export LANGUAGE=zh_CN.utf8'
alias cdsg='cd /home/wap/pip2fortext/tomcat6.0/webapps/web_sg_for_ren_ren'


#for memcached
alias start_memcache='memcached -d -m 900 -p 11211 -P /tmp/memcached.pid'
alias stop_memcache='kill `cat /tmp/memcached.pid`'
alias restart_memcach='stop_memcache;start_memcache;'

#--------from zsh--------------------

alias md='mkdir -p'
alias rd=rmdir

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
# for rails
alias b='bundle'
alias be='bundle exec'
alias r='rails'
alias qmliu='ssh qmliu@192.168.30.39'
alias oswap='ssh oswap@pipgame.com'
#https://blog.csdn.net/JineD/article/details/124896196
alias vagrant='ssh -o "ProxyJump qmliu@192.168.30.39" vagrant@192.168.30.33'

#--------end zsh--------------------
#export SVN_EDITOR=vimm
export EDITOR=/usr/bin/vim
#for the nvm
#[[ -s "$HOME/nvm/nvm.sh" ]] && . "$HOME/nvm/nvm.sh"
#[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
#[[ -r /home/wap/bash_complete/etc/profile.d/bash_completion.sh ]] && . /home/wap/bash_complete/etc/profile.d/bash_completion.sh

#sl
#. ~/nvm/nvm.sh

#export PATH="/home/wap/bin:$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s /Users/quan/.autojump/etc/profile.d/autojump.sh ]] && source /Users/quan/.autojump/etc/profile.d/autojump.sh
export PATH="$PATH:$HOME/flutter/bin:$HOME/flutter/bin/cache/dart-sdk/bin:$HOME/bin"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export  CLICOLOR=1
export  LSCOLOR=Gxfxaxdxcxegedabagacad
export  ANDROID_HOME=/Users/quan/Library/Android/sdk

export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export PATH="$PATH":"$HOME/flutter/.pub-cache/bin"
#homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export PATH="/usr/local/opt/node@16/bin:$PATH"
export address=home

alias create_tags='ctags -R -f ./.git/tags . `rvm gemdir` --exclude=.git'
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
