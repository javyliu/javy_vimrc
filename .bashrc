# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
#alias kn='[[ -s "/home/wap/nginx/logs/nginx.pid" ]] && sudo kill `cat /home/wap/nginx/logs/nginx.pid`'
#alias sn='sudo /home/wap/nginx/sbin/nginx'
alias kn='sudo /etc/init.d/nginx stop'
alias sn='sudo /etc/init.d/nginx start'
alias rn='kn;sn'
alias srn='sudo /etc/init.d/nginx reload && echo ok'

alias nginx_edit='vim /home/wap/nginx/conf/nginx.conf'
alias sl='export LANG=zh_CN.utf8;export LANGUAGE=zh_CN.utf8'
alias cdsg='cd /home/wap/pip2fortext/tomcat6.0/webapps/web_sg_for_ren_ren'

alias create_tags='ctags -R -f ./.git/tags . `rvm gemdir`'

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
alias gd='git diff'

#--------end zsh--------------------
export SVN_EDITOR=vimm
export EDITOR=vimm
#for the nvm
[[ -s "$HOME/nvm/nvm.sh" ]] && . "$HOME/nvm/nvm.sh"
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
[[ -r /home/wap/bash_complete/etc/profile.d/bash_completion.sh ]] && . /home/wap/bash_complete/etc/profile.d/bash_completion.sh

#sl
. ~/nvm/nvm.sh

export PATH="/home/wap/bin:$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
