# 如果你从bash切换过来，你可能需要更改你的$PATH。
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# 秘钥（从 ~/.secrets 加载，由 install.sh 生成）
[[ -f ~/.secrets ]] && source ~/.secrets

# 插件
plugins=(
    git
    zsh-syntax-highlighting
    docker
    kubectl
    fzf
    pip
)

# Oh-my-zsh配置
source ~/.oh-my-zsh/oh-my-zsh.sh
# 显式启用补全
autoload -Uz compinit
compinit

# 补全样式配置
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


# Homebrew
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# kubectl
source <(kubectl completion zsh)

# zsh-syntax-highlighting
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# system alias
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# docker alias
alias dkps="docker ps"
alias dkst="docker stats"
alias dkpsa="docker ps -a"
alias dkimgs="docker images"
alias dkcpup="docker-compose up -d"
alias dkcpdown="docker-compose down"
alias dkcpstart="docker-compose start"
alias dkcpstop="docker-compose stop"

# Kubernetes alias
alias k="kubectl"
alias kc="kubectx"
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deploy'
alias kgsec='kubectl get secrets'
alias kns='kubectl config set-context --current --namespace'
# Proxy alias
alias gp='export http_proxy=http://127.0.0.1:1087 https_proxy=http://127.0.0.1:1087'
alias ngp='unset http_proxy https_proxy'

# Tools alias
function nvimvenv {
  if [[ -e "$VIRTUAL_ENV" && -f "$VIRTUAL_ENV/bin/activate" ]]; then
    source "$VIRTUAL_ENV/bin/activate"
    command nvim "$@"
    deactivate
  else
    command nvim "$@"
  fi
}

alias nvim=nvimvenv
alias lg='lazygit'
alias vim=nvim

set -o vi

# pyenv
export PATH="$HOME/.pyenv/shims:$PATH"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# nvm (lazy-loading)
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -t __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# Go
export PATH="/usr/local/go/bin:$PATH"
export PATH="/$HOME/go/bin:$PATH"
export GOPATH="$HOME/go"
export GO111MODULE="on"
export GOPROXY="https://goproxy.cn/"
export GOPRIVATE="my.git.host"

# MySQL
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# 开发测试环境变量
export DB_PASSWORD="123456"
export PWSHARD_PASSWORD="123456"

export ANDROID_HOME=$HOME/android_sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
#eval "$(gh copilot alias -- zsh)"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval "$(zoxide init zsh)"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"

export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1

eval "$(starship init zsh)"



[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# Created by `pipx` on 2025-08-20 07:54:41
export PATH="$PATH:/Users/wings/.local/bin"

# Added by Antigravity
export PATH="/Users/wings/.antigravity/antigravity/bin:$PATH"

# Obsidian CLI
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# ── Claude Code aliases ──────────────────────────────────────────
_CC_DANGER='--dangerously-skip-permissions'

# 基础启动 (危险模式，跳过权限确认)
alias cc="claude $_CC_DANGER"                        # 默认模型交互
alias ccs="claude --model sonnet $_CC_DANGER"        # Sonnet
alias cco="claude --model opus $_CC_DANGER"          # Opus
alias cch="claude --model haiku $_CC_DANGER"         # Haiku

# 继续上次会话 (危险模式)
alias ccr="claude --continue $_CC_DANGER"            # 继续最近会话
alias ccrs="claude --continue --model sonnet $_CC_DANGER"
alias ccro="claude --continue --model opus $_CC_DANGER"

# 安全模式 (需要逐步确认权限)
alias sc='claude'
alias scs='claude --model sonnet'
alias sco='claude --model opus'
alias scr='claude --continue'

# 单次问答 (pipe 模式，问完即走)
ccq() { claude -p --model sonnet "$*"; }       # 快问: ccq "如何写单测"
ccqo() { claude -p --model opus "$*"; }        # 快问 Opus

# 代码审查 (pipe 当前 git diff 给 Claude)
alias ccreview='git diff --cached | claude -p --model sonnet "Review this diff, point out bugs and suggest improvements"'
alias ccdiff='git diff | claude -p --model sonnet "Summarize these changes concisely"'

# 快速解释文件
ccf() { cat "$1" | claude -p --model haiku "Explain this file concisely"; }
# ── end Claude Code aliases ──────────────────────────────────────
