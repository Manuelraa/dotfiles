#!/bin/bash

read -p "This script will override all your config files! Backup them before you continue! Continue? [y/N]: " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi


INSTALL_DIR=$HOME
echo "Installing depends using APT"
sudo apt-get install python3 python3-dev python python-dev i3 git wget curl pylint3 python3-venv fonts-powerline zsh neovim ranger sudo pacman -S --needed python python2 neovim i3 git wget curl pylint3 python-venv fonts-powerline zsh ranger
echo "Installing depends using PACMAN"

echo "Installing NEOVIM python modules"
python3 -m pip install --user neovim
python -m pip install --user neovim

echo "Copy dotfiles to $INSTALL_DIR"
rsync -av ./ $INSTALL_DIR --exclude ".git" --exclude "setup.sh" --exclude "README.md"

echo "Installing neovim plugin: vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "=============================="
echo "Now open neovim using 'nvim' and type ':PlugInstall' to complete neovim installation"
echo "then go to '$INSTALL_DIR/.vim/plugged/YouCompleteMe' and run 'python3 setup.py'"
echo "=============================="

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv $INSTALL_DIR/.zshrc.pre-oh-my-zsh $INSTALL_DIR/.zshrc


echo "Installing tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
