#!/bin/sh
# http://github.com/NicolasCARPi/.dotfiles
# install sane env

# the ln version of OpenBSD doesn't have -i
i=""
if [ "$(uname)" != "OpenBSD" ]; then
    i=" -i"
fi

# create dirs
mkdir -p $HOME/.vim/backup
mkdir -p $HOME/.config

# make the links
ln -s $i $HOME/.dotfiles/vim $HOME/.vim
ln -s $i .dotfiles/zsh $HOME/.zsh
# zsh will not read $HOME/.zsh/zshrc
ln -s $i $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $i $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $i $HOME/.dotfiles/Xdefaults $HOME/.Xdefaults
ln -s $i $HOME/.dotfiles/mailcap $HOME/.mailcap
ln -s $i $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -s $i $HOME/.dotfiles/tmuxinator $HOME/.tmuxinator
ln -s $i $HOME/.dotfiles/awesome $HOME/.config/awesome
ln -s $i $HOME/.dotfiles/ncmpcpp $HOME/.config/ncmpcpp
ln -s $i $HOME/.dotfiles/config/mpd $HOME/.config/mpd
ln -s $i $HOME/.dotfiles/user-dirs.dir $HOME/.config/user-dirs.dir
ln -s $i $HOME/.dotfiles/octaverc $HOME/.octaverc
ln -s $i $HOME/.dotfiles/pystartup $HOME/.pystartup
ln -s $i $HOME/.dotfiles/gemrc $HOME/.gemrc
