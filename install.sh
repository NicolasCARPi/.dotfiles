#!/bin/sh
# http://github.com/NicolasCARPi/.dotfiles
# install sane env

# the ln version of OpenBSD doesn't have -i
i=""
if [ "$(uname)" != "OpenBSD" ]; then
    i=" -i"
fi

# make the links
ln -s $i $HOME/.dotfiles/vim $HOME/.vim
mkdir -p $HOME/.vim/backup
ln -s $i .dotfiles/zsh $HOME/.zsh
# zsh will not read $HOME/.zsh/zshrc
ln -s $i $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $i $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $i $HOME/.dotfiles/Xdefaults $HOME/.Xdefaults
ln -s $i $HOME/.dotfiles/mailcap $HOME/.mailcap
ln -s $i $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/tmuxinator $HOME/.tmuxinator
mkdir -p $HOME/.config
ln -s $i $HOME/.dotfiles/config/awesome $HOME/.config/awesome
ln -s $i $HOME/.dotfiles/config/mpd $HOME/.config/mpd
ln -s $HOME/.dotfiles/config/bspwm $HOME/.config/bspwm
ln -s $HOME/.dotfiles/config/sxhkd $HOME/.config/sxhkd
ln -s $HOME/.dotfiles/octaverc $HOME/.octaverc
ln -s $HOME/.dotfiles/pystartup $HOME/.pystartup
ln -s $HOME/.dotfiles/gemrc $HOME/.gemrc
