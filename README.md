# dotfiles

个人开发环境配置文件，通过符号链接统一管理。

## 包含配置

| 目录/文件 | 说明 |
|-----------|------|
| `zsh/.zshrc` | Zsh 配置（Oh-My-Zsh、别名、环境变量） |
| `nvim/` | Neovim 配置（基于 AstroNvim） |
| `tmux/.tmux.conf` | Tmux 配置 |
| `git/.gitconfig` | Git 全局配置（GPG 签名） |
| `git/.ssh_config` | SSH 多账户配置 |
| `starship/starship.toml` | Starship 提示符主题 |
| `sesh/sesh.toml` | Sesh 会话管理配置 |
| `npm/.npmrc` | npm 私有源配置 |
| `claude/` | Claude Code 配置（全局指令、设置） |
| `Brewfile` | Homebrew 依赖清单 |
| `.secrets.tpl` | 秘钥模板（实际值由 1Password 生成） |

## 安装

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 安装 Homebrew 依赖
brew bundle

# 创建符号链接 & 生成秘钥文件
./install.sh
```

`install.sh` 会自动：
1. 创建所有配置文件的符号链接到 `~` 目录
2. 通过 1Password CLI (`op`) 生成 `~/.secrets`（如未安装 op，可手动从 `.secrets.tpl` 创建）
3. 软链接 Claude Code 配置（`CLAUDE.md`、`settings.json`）

## 秘钥管理

- 敏感信息通过 1Password CLI 注入到 `~/.secrets`，不进入版本控制
- `.secrets` 已加入 `.gitignore`
- `.secrets.tpl` 提供空值模板，便于手动配置
