#!/bin/sh
# https://github.com/NicolasCARPi/.dotfiles
# install sane env

headless=0
if [ "$1" = '--headless' ]; then
    headless=1
fi

cd "$HOME"

# make the links
if [ ! -d "$HOME/.vim" ]; then
    ln -sf "$HOME/.dotfiles/vim" "$HOME/.vim"
fi
if [ ! -d "$HOME/.zsh" ]; then
    ln -sf .dotfiles/zsh "$HOME/.zsh"
fi
# zsh will not read $HOME/.zsh/zshrc
ln -sf "$HOME/.dotfiles/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/.dotfiles/Xdefaults" "$HOME/.Xdefaults"
ln -sf "$HOME/.dotfiles/mailcap" "$HOME/.mailcap"
ln -sf "$HOME/.dotfiles/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/.dotfiles/tmuxinator" "$HOME/.tmuxinator"
ln -sf "$HOME/.dotfiles/pystartup" "$HOME/.pystartup"
ln -sf "$HOME/.dotfiles/gemrc" "$HOME/.gemrc"
ln -sf "$HOME/.dotfiles/zprofile" "$HOME/.zprofile"

# config dir
mkdir -p "$HOME/.config"
if [ $headless -eq 0 ]; then
    ln -sf "$HOME/.dotfiles/awesome" "$HOME/.config/awesome"
    ln -sf "$HOME/.dotfiles/ncmpcpp" "$HOME/.config/ncmpcpp"
    ln -sf "$HOME/.dotfiles/config/mpd" "$HOME/.config/mpd"
    ln -sf "$HOME/.dotfiles/user-dirs.dir" "$HOME/.config/user-dirs.dir"
fi

# create dirs for vim
mkdir -p "$HOME/.vim/backup"
mkdir -p "$HOME/.vim/undodir"
