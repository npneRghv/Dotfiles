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
PS1='[\u@\h \W]\$ '
set -o vi

