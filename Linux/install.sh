#!/usr/bin/env bash
#
# Symlink the Linux dotfiles into $HOME using GNU Stow.
#
# The whole `Linux/` folder is a single stow "package" whose layout mirrors
# $HOME:  Linux/.bashrc -> ~/.bashrc,  Linux/.config/... -> ~/.config/... , etc.
# Stow folds directories automatically: if ~/.config already exists it links
# the files underneath rather than replacing the directory. Anything you add
# to Linux/ later (e.g. Linux/.config/nvim/init.lua) is picked up on re-run.
#
# Usage:
#   ./install.sh            # stow (create/refresh symlinks)
#   ./install.sh -n         # dry run (show what stow would do)
#   ./install.sh -D         # unstow (remove the symlinks)
#   ./install.sh --adopt    # pull existing real files in $HOME INTO the repo,
#                           #   then link them (review `git diff` afterwards!)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # .../Dotfiles/Linux
STOW_DIR="$(dirname "$SCRIPT_DIR")"                          # .../Dotfiles
PACKAGE="$(basename "$SCRIPT_DIR")"                          # Linux
TARGET="$HOME"

# --- require GNU Stow -------------------------------------------------------
if ! command -v stow >/dev/null 2>&1; then
    echo "GNU Stow is not installed. Install it with one of:" >&2
    echo "  Arch:    sudo pacman -S stow" >&2
    echo "  Debian:  sudo apt install stow" >&2
    echo "  Fedora:  sudo dnf install stow" >&2
    echo "  macOS:   brew install stow" >&2
    exit 1
fi

# Default action = restow (safe to run repeatedly); pass through any flags.
ARGS=("--restow")
if [[ $# -gt 0 ]]; then
    ARGS=("$@")
fi

echo "stow ${ARGS[*]}  (dir=$STOW_DIR  target=$TARGET  package=$PACKAGE)"
echo

# --verbose so you can see each link; --no-folding keeps deep dirs as real
# directories with per-file links (nicer for shared trees like ~/.config).
if ! stow --dir="$STOW_DIR" --target="$TARGET" --verbose=1 "${ARGS[@]}" "$PACKAGE"; then
    echo >&2
    echo "Stow reported conflicts (existing real files in \$HOME)." >&2
    echo "Back them up and re-run, or adopt them into the repo with:" >&2
    echo "  ./install.sh --adopt      # then review: git -C \"$STOW_DIR\" diff" >&2
    exit 1
fi

echo
echo "Done."
