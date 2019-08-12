#!/bin/bash

read -p "This script will override all your config files! Backup them before you continue! Continue? [y/N]: " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
echo ""

echo ">>>>>>> Starting install in 5 seconds..."
echo ">>>>>>> Last chance to cancel and look at the script..."
sleep 5
INSTALL_DIR=$HOME
echo ">>>>>>> Installing depends using APT"
sudo apt install python3 python3-dev fonts-powerline zsh neovim ranger 

echo ">>>>>>> Other stuff I use"
sudo apt install i3 git wget curl httpie python3-venv flameshot

echo ">>>>>>> Installing python modules I use"
pip3 install --user -U pip setuptools wheel
pip3 install --user -U neovim pipenv

echo ">>>>>>> Copy dotfiles to $INSTALL_DIR"
rsync -av ./ $INSTALL_DIR --exclude ".git" --exclude "setup.sh" --exclude "README.md"

echo "BELLOW FOLLOWS ADDITIONAL INFO ABOUT MY DOTFILES"
echo "======== Shell stuff ========"
echo "I recommend to install oh_my_zsh and make zsh your default shell"
echo "When installing oh_my_zsh it will copy your aka. my .zshrc config to .zshrc.before_oh_my_zsh"
echo "Copy it back to .zshrc to get my oh_my_zsh configuration"
echo ""
echo "======== Terminatl emulator stuff ========"
echo "Install 'termite terminal' because its great"
echo "Design it with 'termite-style'"
echo ""
echo "======== Other info ========"
echo "first time u start neovim it will install all plugins. Some might need additional setup. instructions printed bellow"
echo ""
echo "Vim python better completions setup:"
echo "after that u have to close it. cd to '$HOME/.config/nvim/plugged/YouCompleteMe'. and run python3 install.py"

