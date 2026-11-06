# Claude-specific instructions

<!-- Add instructions that apply only to Claude here. -->

## Check long-running commands every few minutes

A foreground or background command can hang for a long time without returning
any output or exit status. Never wait blindly on one: check its progress (log
tail, output file, process state, or the work it drives) at least once every
several minutes, and tell the user what it is doing. Prefer short bounded waits
over one long wait, and treat an unchanged log as a possible stall to investigate.
