#!/bin/sh
# https://github.com/NicolasCARPi/.dotfiles
# install sane env

# the ln version of OpenBSD doesn't have -i
i=""
if [ "$(uname)" != "OpenBSD" ]; then
    i=" -i"
fi

# make the links
ln -sf $i $HOME/.dotfiles/vim $HOME/.vim
ln -sf $i .dotfiles/zsh $HOME/.zsh
# zsh will not read $HOME/.zsh/zshrc
ln -sf $i $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
ln -sf $i $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
ln -sf $i $HOME/.dotfiles/Xdefaults $HOME/.Xdefaults
ln -sf $i $HOME/.dotfiles/mailcap $HOME/.mailcap
ln -sf $i $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -sf $i $HOME/.dotfiles/tmuxinator $HOME/.tmuxinator
ln -sf $i $HOME/.dotfiles/octaverc $HOME/.octaverc
ln -sf $i $HOME/.dotfiles/pystartup $HOME/.pystartup
ln -sf $i $HOME/.dotfiles/gemrc $HOME/.gemrc

# config dir
mkdir -p $HOME/.config
ln -sf $i $HOME/.dotfiles/awesome $HOME/.config/awesome
ln -sf $i $HOME/.dotfiles/ncmpcpp $HOME/.config/ncmpcpp
ln -sf $i $HOME/.dotfiles/config/mpd $HOME/.config/mpd
ln -sf $i $HOME/.dotfiles/user-dirs.dir $HOME/.config/user-dirs.dir

# create dirs for vim
mkdir -p $HOME/.vim/backup
mkdir -p $HOME/.vim/undodir

echo "All symlinks created. Now run :PluginInstall in vim"
