alias create_tags='ctags -R -f ./.git/tags . `rvm gemdir` --exclude=.git'
# List directory contents
alias lsa='ls -lah -G'
alias l='ls -lah -G'
alias ll='ls -lh -G'
alias la='ls -lAh -G'
alias vagrant='ssh vagrant@192.168.30.33'
alias oswap='ssh oswap@pipgame.com'
alias kq='ssh qmliu@kq.press5.cn'
alias pipstat='ssh pipstat@pipgame.com'
alias pipstat_test='ssh pipstat@192.168.0.5'
alias logbak='ssh pipstat@120.92.144.39'
alias glogbak='grun ssh pipstat@120.92.144.39'
alias cdn='ssh web@120.92.137.221'
alias r='bin/rails'
alias b='bundle'
alias be='bundle exec'
alias gd='git diff'
alias gt='git status'

export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH=~/flutter/bin:~/bin:$PATH
[[ -s /Users/qmliu/.autojump/etc/profile.d/autojump.sh ]] && source /Users/qmliu/.autojump/etc/profile.d/autojump.sh
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export PATH="$PATH":"$HOME/flutter/.pub-cache/bin"

#/Users/qmliu/Library/Android/sdk
export PATH="$HOME/Library/Android/sdk/tools:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home/
export PATH="/usr/local/opt/node@16/bin:$PATH"

export db="mysql2://javy:Javy123123@192.168.30.33:3306/tsmile?charset=utf8&connectTimeout=500"

export EDITOR=/usr/bin/vim

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:/Users/qmliu/.rvm/"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

export PATH="/usr/local/sbin:$PATH"
#for postsql'
export LDFLAGS="-L/usr/local/opt/libpq/lib"
export CPPFLAGS="-I/usr/local/opt/libpq/include"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$GEM_HOME/bin:$HOME/.rvm/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
