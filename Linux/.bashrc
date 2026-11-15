#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
export EDITOR=nvim
export VISUAL=nvim
# Git branch helper
__git_branch() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch=$(git branch --show-current 2>/dev/null)
        [ -n "$branch" ] && echo " ($branch)"
    fi
}

PS1='\[\033[1;34m\]\u\[\033[0m\] \[\033[1;32m\]@\[\033[0m\] \[\033[1;34m\]\h\[\033[0m\] \[\033[1;32m\]$(__git_branch)\[\033[0m\] \[\033[1;34m\]\$\[\033[0m\] '
set -o vi

