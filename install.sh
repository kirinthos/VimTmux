#!/bin/bash

echo "#############################################################"
echo "#"
echo "#  Installing (n)vim, tmux, zsh, and gitconfig files"
echo "#"
echo "#############################################################"
echo
echo

set -x

cp zshrc ~/.zshrc
cp gitconfig ~/.gitconfig
cp tmux.conf ~/.tmux.conf
cp alacritty.toml ~/.alacritty.toml
cp vimrc ~/.vimrc
cp -r vim ~/.vim

mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua
