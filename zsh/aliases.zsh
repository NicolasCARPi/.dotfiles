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
alias serve='python2 -m SimpleHTTPServer 8888'
alias dmesg='dmesg -H'
alias tesla='vncviewer 192.168.102.122'
alias pielcommon='vncviewer 192.168.102.6'
alias mvideopiel='vncviewer 192.168.102.14'
alias bigasscpu='vncviewer 192.168.102.82'
alias axiom='vncviewer 192.168.102.131'
alias europa='vncviewer 192.168.102.134'
alias symux='vncviewer 192.168.102.19'
alias mvideodam='vncviewer 192.168.102.147'
alias mvideobravo='vncviewer 192.168.102.163'

# before it was d for Desktop
if [[ $(hostname) == "kwala" ]]; then
    export d=~
else
    export d=~/tmp
fi
alias mutt='~/.bin/mount-share.sh && cd $d && mutt && clear'
alias m='mutt'
export s=~/.share
