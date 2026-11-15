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
PS1='\[\033[1;34m\]\u\[\033[0m\]\[\033[1;34m\]@\[\033[0m\]\[\033[1;34m\]\h\[\033[0m\]$(if [ "$PWD" != "$HOME" ]; then printf "\[\033[1;32m\] [%s]\[\033[0m\]" "$(basename $PWD)"; fi)$(if git rev-parse --is-inside-work-tree &>/dev/null; then b=$(git branch --show-current 2>/dev/null); [ -n "$b" ] && printf "\[\033[1;31m\] (%s)\[\033[0m\]" "$b"; fi) \[\033[1;34m\]\$\[\033[0m\] '
set -o vi

