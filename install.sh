#!/bin/sh
# http://github.com/NicolasCARPi/.dotfiles
# install sane env

# make the links
ln -s -i ~/.dotfiles/vim ~/.vim
mkdir -p ~/.vim/backup
ln -s -i .dotfiles/zsh ~/.zsh
# zsh will not read ~/.zsh/zshrc
ln -s -i ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s -i ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s -i ~/.dotfiles/Xdefaults ~/.Xdefaults
ln -s -i ~/.dotfiles/mailcap ~/.mailcap
ln -s -i ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/tmuxinator ~/.tmuxinator
mkdir ~/.config
ln -s -i ~/.dotfiles/config/awesome ~/.config/awesome
ln -s -i ~/.dotfiles/config/mpd ~/.config/mpd
ln -s ~/.dotfiles/config/bspwm ~/.config/bspwm
ln -s ~/.dotfiles/config/sxhkd ~/.config/sxhkd

