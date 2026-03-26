#!/bin/bash
set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# 1. 创建符号链接
echo "Creating symlinks..."
ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES/git/.gitconfig" ~/.gitconfig
mkdir -p ~/.ssh
ln -sf "$DOTFILES/git/.ssh_config" ~/.ssh/config
ln -sf "$DOTFILES/starship/starship.toml" ~/.config/starship.toml
mkdir -p ~/.config/sesh
ln -sf "$DOTFILES/sesh/sesh.toml" ~/.config/sesh/sesh.toml
ln -sf "$DOTFILES/npm/.npmrc" ~/.npmrc
rm -f ~/.config/nvim
ln -sf "$DOTFILES/nvim" ~/.config/nvim
mkdir -p ~/.config/gh
ln -sf "$DOTFILES/gh/config.yml" ~/.config/gh/config.yml
ln -sf "$DOTFILES/gh/hosts.yml" ~/.config/gh/hosts.yml
mkdir -p ~/.claude
ln -sf "$DOTFILES/claude/CLAUDE.md" ~/.claude/CLAUDE.md
ln -sf "$DOTFILES/claude/settings.json" ~/.claude/settings.json

# 2. 从 1Password 生成 ~/.secrets
if command -v op &>/dev/null; then
  echo "Generating ~/.secrets from 1Password..."
  cat > ~/.secrets << 'SECRETS'
# 由 install.sh 从 1Password 自动生成
SECRETS
  echo "export BAY_ADMIN_ACCESS_KEY=\"$(op read 'op://Personal/bay-admin/access-key')\"" >> ~/.secrets
  echo "export BAY_ADMIN_ACCESS_SECRET=\"$(op read 'op://Personal/bay-admin/access-secret')\"" >> ~/.secrets
  echo "export SENSOR_SESSION_ID=\"$(op read 'op://Personal/sensors-data/session-id')\"" >> ~/.secrets
  echo "export YUQUE_TOKEN=\"$(op read 'op://Personal/knl7v2ssfd6k7pd72rlhzffhru/token')\"" >> ~/.secrets
  echo "export NPM_NEXUS_TOKEN=\"$(op read 'op://Personal/npm-nexus/token')\"" >> ~/.secrets
  chmod 600 ~/.secrets
  echo "~/.secrets generated!"
else
  echo "op CLI not found. Please manually create ~/.secrets from .secrets.tpl"
fi

echo "Done! Restart your shell or run: source ~/.zshrc"
