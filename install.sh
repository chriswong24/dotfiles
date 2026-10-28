#!/usr/bin/env bash
# Symlink dotfiles from this repo into $HOME. Compatible with bash 3.2 (macOS) and Linux.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
WITH_DEPS=0

OMZ_DIR="$HOME/.oh-my-zsh"
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
OMZ_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
P10K_URL="https://github.com/romkatv/powerlevel10k.git"
HERDR_URL="https://herdr.dev/install.sh"
HERDR_INSTALL_DIR="${HERDR_INSTALL_DIR:-$HOME/.local/bin}"
HERDR_SKILL_DIR="$HOME/.claude/skills/herdr"

info() { printf '==> %s\n' "$*"; }
warn() { printf 'warning: %s\n' "$*" >&2; }

usage() {
  cat <<EOF
Usage: ./install.sh [options]

Symlinks .zshrc, .tmux.conf, .config/nvim and .config/herdr/config.toml into \$HOME.
Targets already linked or identical to the repo are skipped; other existing
files are moved to <target>.backup.<timestamp>.

Options:
  -n, --dry-run   Show what would happen without changing anything
  --with-deps     Install Oh My Zsh, powerlevel10k and herdr if missing
  -h, --help      Show this help
EOF
}

# Run a command, or only print it in dry-run mode.
run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    printf '  [dry-run] %s\n' "$*"
  else
    "$@"
  fi
}

# Print the herdr binary path, checking PATH then the installer's default dir.
herdr_bin() {
  if command -v herdr >/dev/null 2>&1; then
    command -v herdr
  elif [ -x "$HERDR_INSTALL_DIR/herdr" ]; then
    printf '%s\n' "$HERDR_INSTALL_DIR/herdr"
  else
    return 1
  fi
}

install_deps() {
  if [ -d "$OMZ_DIR" ]; then
    info "Oh My Zsh found at $OMZ_DIR"
  elif [ "$WITH_DEPS" -eq 1 ]; then
    info "Installing Oh My Zsh"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf '  [dry-run] RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL %s)" "" --unattended\n' "$OMZ_URL"
    else
      local omz_installer
      omz_installer="$(curl -fsSL "$OMZ_URL")" || { warn "failed to download Oh My Zsh installer"; exit 1; }
      RUNZSH=no KEEP_ZSHRC=yes sh -c "$omz_installer" "" --unattended
      [ -d "$OMZ_DIR" ] || { warn "Oh My Zsh install did not create $OMZ_DIR"; exit 1; }
    fi
  else
    warn "Oh My Zsh not found at $OMZ_DIR (run with --with-deps to install it)"
  fi

  if [ -d "$P10K_DIR" ]; then
    info "powerlevel10k found at $P10K_DIR"
  elif [ "$WITH_DEPS" -eq 1 ]; then
    info "Cloning powerlevel10k into $P10K_DIR"
    run mkdir -p "$(dirname "$P10K_DIR")"
    run git clone --depth=1 "$P10K_URL" "$P10K_DIR"
  else
    warn "powerlevel10k not found at $P10K_DIR (run with --with-deps to install it)"
  fi

  if herdr_bin >/dev/null; then
    info "herdr found at $(herdr_bin)"
  elif [ "$WITH_DEPS" -eq 1 ]; then
    info "Installing herdr into $HERDR_INSTALL_DIR"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf '  [dry-run] curl -fsSL %s | HERDR_INSTALL_DIR=%s sh\n' "$HERDR_URL" "$HERDR_INSTALL_DIR"
    else
      local herdr_installer
      herdr_installer="$(curl -fsSL "$HERDR_URL")" || { warn "failed to download herdr installer"; exit 1; }
      HERDR_INSTALL_DIR="$HERDR_INSTALL_DIR" sh -c "$herdr_installer"
      herdr_bin >/dev/null || { warn "herdr install did not produce a binary in $HERDR_INSTALL_DIR"; exit 1; }
    fi
  else
    warn "herdr not found (run with --with-deps to install it)"
  fi

  if [ -e "$HERDR_SKILL_DIR" ] || [ -L "$HERDR_SKILL_DIR" ]; then
    info "herdr skill found at $HERDR_SKILL_DIR"
  elif [ "$WITH_DEPS" -eq 1 ]; then
    info "Writing herdr skill to $HERDR_SKILL_DIR/SKILL.md"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf '  [dry-run] herdr --skill > %s/SKILL.md\n' "$HERDR_SKILL_DIR"
    else
      mkdir -p "$HERDR_SKILL_DIR"
      "$(herdr_bin)" --skill > "$HERDR_SKILL_DIR/SKILL.md"
    fi
  else
    warn "herdr skill not found at $HERDR_SKILL_DIR (run with --with-deps to add it)"
  fi
}

# link <repo-path> <target-path>
link() {
  local src="$1" dest="$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    info "already linked: $dest"
    return 0
  fi

  # A real file/dir with the same contents as the repo is already installed; leave it alone.
  if [ -e "$dest" ] && [ ! -L "$dest" ] && diff -rq "$src" "$dest" >/dev/null 2>&1; then
    info "already installed (identical to repo): $dest"
    return 0
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    local backup="$dest.backup.$TIMESTAMP"
    info "backing up $dest -> $backup"
    run mv "$dest" "$backup"
  fi

  run mkdir -p "$(dirname "$dest")"
  run ln -s "$src" "$dest"
  if [ "$DRY_RUN" -eq 0 ]; then
    info "linked $dest -> $src"
  fi
}

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    -n|--dry-run) DRY_RUN=1 ;;
    --with-deps) WITH_DEPS=1 ;;
    -h|--help) usage; exit 0 ;;
    *) warn "unknown option: $arg"; usage >&2; exit 1 ;;
  esac
done

[ "$DRY_RUN" -eq 1 ] && info "dry run: no changes will be made"

install_deps

link "$DOTFILES_DIR/.zshrc"       "$HOME/.zshrc"
link "$DOTFILES_DIR/.tmux.conf"   "$HOME/.tmux.conf"
link "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
link "$DOTFILES_DIR/.config/herdr/config.toml" "$HOME/.config/herdr/config.toml"

for cmd in zsh nvim tmux git herdr; do
  command -v "$cmd" >/dev/null 2>&1 || warn "'$cmd' not found on PATH"
done

info "done"
