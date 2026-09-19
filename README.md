# Dotfiles

Clean, organized dotfiles configuration with automated symlink management.

## Directory Structure

```
dotfiles/
├── config/              # Directly maps to ~/.config/
│   ├── browsh/          # browsh config.toml
│   ├── fish/            # fish shell config and prompt functions
│   ├── mpv/             # mpv video player configuration
│   ├── qutebrowser/     # qutebrowser config & user stylesheets
│   └── zathura/         # zathura PDF viewer configuration
├── shell/               # Maps to ~/.<filename>
│   ├── all_sh_aliases   -> ~/.all_sh_aliases
│   ├── all_sh_env       -> ~/.all_sh_env
│   ├── bash_aliases     -> ~/.bash_aliases
│   ├── bash_profile     -> ~/.bash_profile
│   └── zsh_aliases      -> ~/.zsh_aliases
├── vim/                 # Vim configuration
│   ├── vimrc            -> ~/.vimrc
│   ├── vimrc.bundles    -> ~/.vimrc.bundles
│   └── vim_vixen_config.json
├── tmux/
│   └── tmux.conf        -> ~/.tmux.conf
├── ssh/
│   └── config           -> ~/.ssh/config
├── aria2/
│   └── aria2.conf       -> ~/.aria2/aria2.conf
├── elinks/
│   └── elinks.conf      -> ~/.elinks/elinks.conf
├── gdb/
│   └── gdbinit          -> ~/.gdbinit
├── X11/
│   └── Xresources       -> ~/.Xresources
└── install.sh           # Management script (link, status, unlink)
```

## How It Works (Two-Way Sync)

All configurations in `$HOME` are symbolic links pointing directly to the files in this repository.
- Modifying a file in `$HOME` (e.g. `~/.zsh_aliases` or `~/.config/mpv/mpv.conf`) modifies the file in this repo.
- Modifying a file in this repository immediately applies to the system.
- `git status` in this repository shows any changes made from either location.

## Management Script

`./install.sh` manages all symlinks:

```bash
# Check link status of all managed dotfiles
./install.sh status

# Create or update all symlinks in $HOME (default action)
./install.sh
# or
./install.sh link

# Remove symlinks created by this repository
./install.sh unlink
```
