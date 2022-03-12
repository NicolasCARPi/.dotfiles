# common aliases
alias ls='ls --color=auto'
alias ll='ls -lA'
alias lll='ls -lA|less'
alias dodo='cd ~ && fusermount -u .password-store; fusermount -u .share; sudo systemctl suspend'
alias cp='cp -i'
alias mv='mv -i'
alias vmi='vim'
alias v='vim'
alias c='clear'
alias df='df -h'
alias free='free -h'
alias g='git'
alias m='mutt'
alias steam='flatpak run com.valvesoftware.Steam'
alias elabc='docker exec -it dev-web-1'

# custom aliases
alias serve='python -m http.server 8888'
alias dmesg='dmesg -H'
alias mutt='~/.bin/mount-share.sh && cd $d && mutt && clear'
alias eject="eject /dev/sr0"
alias tmux='tmux -u'
alias r='tmux attach'
alias cdrip='abcde'
alias snes='zsnes'
alias nes='fceux'
alias tv='vim /mnt/data/var/docs/tv.txt'
alias utf8chk='find . -type f -exec file -bi {} \; -print|less'
alias rss='newsboat'
alias irc='weechat'
alias dc='docker-compose'
alias tf='terraform'

# apps
alias mutt='~/.bin/mount-share.sh 2>/dev/null && cd $d && mutt && clear'
alias fiji='~/.opt/Fiji.app/ImageJ-linux64'
alias minecraft='~/.opt/minecraft-launcher/minecraft-launcher'

# exported variables
export dev=~/.dev
export t=/mnt/data/

# before it was d for Desktop
if [[ $(hostname) == "ryzen" ]]; then
    export d=~
else
    export d=~/cloud/tmp
fi
alias y='docker exec -it dev-web-1 yarn'
alias cmp='docker exec -it dev-web-1 composer'
