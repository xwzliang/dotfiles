# Dotfiles

Clean, organized dotfiles configuration with automated symlink management.

## Directory Structure

```
dotfiles/
├── agents/
│   ├── AGENTS.md        # Shared global instructions
│   ├── codex.md         # Codex-only instructions
│   ├── antigravity.md   # Antigravity-only instructions
│   ├── claude.md        # Claude-only instructions
│   └── opencode.md      # OpenCode-only instructions
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

Global agent instructions use shared rules plus a separate file for each agent:

| Edit this source | Applies to |
| --- | --- |
| `agents/AGENTS.md` | All four agents |
| `agents/codex.md` | Codex only |
| `agents/antigravity.md` | Antigravity only |
| `agents/claude.md` | Claude Code only |
| `agents/opencode.md` | OpenCode only |

After editing a source, run `./install.sh link`. It combines the shared rules
with each agent's own rules into `agents/generated/<agent>.md` and links:

- `~/.codex/AGENTS.md` → generated `codex.md`
- `~/.gemini/GEMINI.md` → generated `antigravity.md`
- `~/.claude/CLAUDE.md` → generated `claude.md`
- `~/.config/opencode/AGENTS.md` → generated `opencode.md`

Generated files are ignored by Git. Do not edit the installed instruction links
or generated files directly: the next install replaces their contents. This is
an exception to the two-way editing behavior of the other dotfiles.
Run the installer after pulling source changes on another machine as well.

Existing regular files receive timestamped backups before linking. Existing
links from the earlier shared-file setup are migrated automatically. `status`
and `unlink` include all four links; unlinking leaves sources, generated files,
and backups intact. Backups are not restored automatically.

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
