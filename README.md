# dotfiles

Personal configuration for:

- **zsh** with Oh My Zsh and the powerlevel10k theme (`.zshrc`)
- **tmux** (`.tmux.conf`)
- **neovim** (`.config/nvim`)

## Install

```
git clone <repo-url> ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install.sh --with-deps
```

Options:

- `--with-deps` installs Oh My Zsh and powerlevel10k if they are missing.
- `--dry-run` (`-n`) shows what would happen without changing anything.
- `--help` (`-h`) prints usage.

The script symlinks each file into `$HOME`. Existing files are not deleted; they are backed up to `*.backup.<timestamp>` first.
