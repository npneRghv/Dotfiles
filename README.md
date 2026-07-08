# Dotfiles

A place to store all dotfiles originally from my Arch Linux system.

The repo is the single source of truth; each live config path is a **symlink**
back into here, so editing either path edits the same file and `git` tracks it.

## Install

### Linux (GNU Stow)

```sh
cd Linux
./install.sh          # symlink everything in Linux/ into $HOME
./install.sh -n       # dry run
./install.sh -D       # remove the symlinks
```

The whole `Linux/` folder is one stow package mirroring `$HOME`
(`Linux/.bashrc` → `~/.bashrc`, `Linux/.config/…` → `~/.config/…`, etc.).
Anything added under `Linux/` later is picked up on the next run.

### Windows (PowerShell)

Symlink creation on Windows needs an **elevated** PowerShell (Run as
Administrator) or Developer Mode enabled.

```powershell
cd Windows
./install.ps1 -DryRun   # preview
./install.ps1           # symlink into place
./install.ps1 -Copy     # copy instead of link (no elevation needed)
```

Managed links live in the `$Links` table at the top of `install.ps1`
(Neovim/Neovide, VsVim, and the shared VS Code config).
