# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理している dotfiles。

## 管理対象

| ファイル | 内容 |
| --- | --- |
| `dot_zshrc` | zsh 設定 |
| `dot_tmux.conf` | tmux 設定(prefix `C-a`、vim-tmux-navigator など) |
| `dot_gitconfig` | git 設定 |
| `dot_config/herdr/config.toml` | [herdr](https://herdr.dev/)(エージェント対応ターミナルマルチプレクサ)設定 |

## セットアップ

```sh
# chezmoi 未導入なら
brew install chezmoi

# このリポジトリを展開(初回)
chezmoi init --apply HideakiTouhara
```

### 手動セットアップが必要なもの

一部は設定ファイルではなくコマンド実行で入れる(別マシンでも1回叩けば再現できるため、dotfiles には含めない)。

#### herdr + Claude Code 連携

```sh
# 本体
brew install herdr

# Claude Code のエージェント状態を herdr サイドバーに表示するフックを導入
# （~/.claude/hooks/herdr-agent-state.sh を生成し、~/.claude/settings.json に登録する）
herdr integration install claude

# 導入確認
herdr integration status
```

herdr の設定(prefix `C-a`、直接 `Ctrl+h/j/k/l` でペイン移動、`prefix+|` で左右分割)は
`dot_config/herdr/config.toml` に含まれる。編集後は `herdr server reload-config` で反映。
