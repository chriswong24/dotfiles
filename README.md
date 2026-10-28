# dotfiles

Personal configuration for:

- **zsh** with Oh My Zsh and the powerlevel10k theme (`.zshrc`)
- **tmux** (`.tmux.conf`)
- **neovim** (`.config/nvim`)
- **herdr** terminal multiplexer (`.config/herdr/config.toml`), plus its Claude Code skill

## Install

```
git clone <repo-url> ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install.sh --with-deps
```

Options:

- `--with-deps` installs Oh My Zsh, powerlevel10k and herdr if they are missing, and writes the herdr Claude Code skill (`herdr --skill`) to `~/.claude/skills/herdr`.
- `--dry-run` (`-n`) shows what would happen without changing anything.
- `--help` (`-h`) prints usage.

The script symlinks each file into `$HOME`. Existing files are not deleted; they are backed up to `*.backup.<timestamp>` first.
