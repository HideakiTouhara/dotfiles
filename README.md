# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup

```sh
# If chezmoi is not installed yet
brew install chezmoi

# Apply this repository (first time)
chezmoi init --apply HideakiTouhara
```

### Manual setup

Things installed via commands rather than tracked config files
(re-runnable on any machine, so they are not stored in the dotfiles).

#### herdr + Claude Code integration

```sh
# herdr itself
brew install herdr

# Install the hook that shows Claude Code agent state in the herdr sidebar
# (generates ~/.claude/hooks/herdr-agent-state.sh and registers it in ~/.claude/settings.json)
herdr integration install claude

# Verify
herdr integration status
```
