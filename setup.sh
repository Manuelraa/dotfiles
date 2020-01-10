#!/bin/bash

read -p "This script will override all your config files! Backups will be created to .before_manuelraa_dotfiles Continue? [y/N]: " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
echo ""

echo ">>>>>>> Starting install in 5 seconds..."
echo ">>>>>>> Last chance to cancel and look at the script..."

echo ">>>>>>> copy all files which will be overriden to new file with ending .before_manuelraa_dotfiles"
echo ">>>>>>> to delete the backups use \"find -name \"*.before_manuelraa_dotfiles\" -exec rm -rf {} \;\""
for file in $(find . -type f -not -name 'setup.sh' -not -name 'README.md' -not -path '*.git*'); do
    echo "COPY \"$HOME/$file\" TO \"$HOME/$file.before_manuelraa_dotfiles\""
    cp "$HOME/$file" "$HOME/$file.before_manuelraa_dotfiles"
done

sleep 5
INSTALL_DIR=$HOME
echo ">>>>>>> Installing dependencies using APT"
sudo apt install python3 python3-dev python3-venv python3-pip fonts-powerline zsh neovim ranger volumeicon-alsa lxappearance dolphin

echo ">>>>>>> Other stuff I use"
sudo apt install i3 git wget curl httpie python3-venv flameshot htop

echo ">>>>>>> Installing python modules I use"
pip3 install --user -U pip setuptools wheel
pip3 install --user -U neovim pynvim flake8

echo ">>>>>>> Installing tools I use"
# tldr
echo "tldr -- easy man pages broken down to the important stuff"
mkdir -p ~/bin
curl -o ~/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
chmod +x ~/bin/tldr

# commacd
echo "Faster then cd....  -> https://github.com/shyiko/commacd"
curl -sSL https://raw.githubusercontent.com/shyiko/commacd/master/commacd.sh -o ~/.commacd.sh

echo ">>>>>>> Copy dotfiles to $INSTALL_DIR"
rsync -av ./ $INSTALL_DIR --exclude ".git" --exclude "setup.sh" --exclude "README.md"

echo ">>>>>>> Installing TMUX plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo ">>>>>>> Installing Icon Pack"
wget -qO- https://git.io/papirus-icon-theme-install | sh

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

