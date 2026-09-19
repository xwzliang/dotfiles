# Source aliases and env
bax "source $HOME/.all_sh_aliases"
bax "source $HOME/.all_sh_env"

# Set terminal to automatically use tmux, with a tmux session named 'default'
if test -z "$TMUX"
    # Only run tmux for interactive shell
    if status --is-interactive
        tmux attach -t default || tmux new -s default
    end
end

fish_vi_key_bindings

# Don't show time stamp on the right
function fish_right_prompt
end

# Don't show vi mode indicator, override it with an empty function
function fish_mode_prompt
end

# Don't show welcome message
set fish_greeting

function fish_user_key_bindings
    # Control+f to accept whole autosuggestion, Alt+f to accept first word
    bind --preset -M insert \cf forward-char
    bind --preset -M insert \ef forward-word
end

# Source file using bax
function bs
    bax "source $argv"
end

# Aliases for fish
alias e="emacs"
# Using zsh te
alias te="$HOME/.oh-my-zsh/plugins/emacs/emacsclient.sh -nw"
# Using zsh x
alias x="bax extract"
