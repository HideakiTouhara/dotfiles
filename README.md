# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理している dotfiles。

## セットアップ

```sh
# chezmoi 未導入なら
brew install chezmoi

# このリポジトリを展開(初回)
chezmoi init --apply HideakiTouhara
```

### 手動セットアップが必要なもの

設定ファイルではなくコマンドで入れるもの(別マシンでも1回叩けば再現できる)。

#### herdr + Claude Code 連携

```sh
# 本体
brew install herdr

# Claude Code のエージェント状態を herdr サイドバーに表示するフックを導入
# (~/.claude/hooks/herdr-agent-state.sh を生成し、~/.claude/settings.json に登録)
herdr integration install claude

# 導入確認
herdr integration status
```
