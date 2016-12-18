# common aliases
alias r='tmux attach'
alias ls='ls --color=auto'
alias ll='ls -lA'
alias lll='ls -lA|less'
alias cp='cp -i'
alias mv='mv -i'
alias vmi='vim'
alias v='vim'
alias c='clear'
alias df='df -h'
alias free='free -h'
alias g='git'
alias serve='python2 -m SimpleHTTPServer'
alias dmesg='dmesg -H'
# before it was d for Desktop
if [[ $(hostname) == "kwala" ]]; then
    export d=~
else
    export d=~/tmp
fi
alias mutt='cd $d && mutt'
