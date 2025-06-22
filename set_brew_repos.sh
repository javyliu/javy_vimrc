#!/bin/bash

# Homebrew 镜像配置脚本 - 支持清华源 & 恢复官方源

set -e

# 镜像地址
TSINGHUA_BREW="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
TSINGHUA_CORE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
TSINGHUA_BOTTLE="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# 恢复地址
OFFICIAL_BREW="https://github.com/Homebrew/brew.git"
OFFICIAL_CORE="https://github.com/Homebrew/homebrew-core.git"
OFFICIAL_BOTTLE=""

# 检查 Homebrew 是否存在
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew 未安装，请先安装 Homebrew。"
  exit 1
fi

function set_mirror() {
  echo "🔧 正在配置为清华镜像..."

  git -C "$(brew --repo)" remote set-url origin "$TSINGHUA_BREW"
  #git -C "$(brew --repo homebrew/core)" remote set-url origin "$TSINGHUA_CORE"

  export HOMEBREW_BOTTLE_DOMAIN="$TSINGHUA_BOTTLE"
  echo 'export HOMEBREW_BOTTLE_DOMAIN="'"$TSINGHUA_BOTTLE"'"' >> ~/.bash_profile

  echo ------------
  echo $HOMEBREW_BOTTLE_DOMAIN
  echo --------

  echo "✅ 已切换到清华源。请运行 'brew update' 测试效果。"
}

function unset_mirror() {
  echo "🔄 正在还原为官方源..."

  git -C "$(brew --repo)" remote set-url origin "$OFFICIAL_BREW"
  git -C "$(brew --repo homebrew/core)" remote set-url origin "$OFFICIAL_CORE"

  sed -i '' '/HOMEBREW_BOTTLE_DOMAIN/d' ~/.bash_profile || true
  unset HOMEBREW_BOTTLE_DOMAIN

  echo "✅ 已还原为官方源。"
}

case "$1" in
  set)
    set_mirror
    ;;
  unset)
    unset_mirror
    ;;
  *)
    echo "用法: $0 {set|unset}"
    ;;
esac

