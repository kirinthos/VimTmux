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
cp alacritty.yml ~/.alacritty.yml
cp vimrc ~/.vimrc
cp -r vim ~/.vim

mkdir -p ~/.config/nvim
cp init.vim.nvim ~/.config/nvim/init.vim
