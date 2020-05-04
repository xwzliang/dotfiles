# My fish theme
# based on gnuykeaj
# ---------------
# name: gnuykeaj
# ---------------
# Based on clearance, which is based off idan.
# 1 line minimal, beautiful version of clearance.
# Display the following bits on the left:
# - Virtualenv name (if applicable, see https://github.com/adambrenecki/virtualfish)
# - Current directory name
# - Git branch and dirty state (if inside a git repo)

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l last_status $status

  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color --bold blue)
  set -l green (set_color green)
  set -l gray (set_color grey)
  set -l normal (set_color normal)

  set -l cwd $blue(pwd | sed "s:^$HOME:~:")

  # Display [venvname] if in a virtualenv
  if set -q VIRTUAL_ENV
      echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
  end

  # Print pwd or full path
  echo -n -s $cwd $normal

  # Show git branch
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info $yellow $git_branch $normal
    echo -n -s $blue ":" $git_info $normal
  end

  set -l prompt_color $red
  if test $last_status = 0
    set prompt_color $gray
  end

  # Terminate with a fish symbol
  echo -e -n -s $prompt_color ' ⋊> ' $normal
end
