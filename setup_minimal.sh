#!/bin/bash
set -e

read -p "This script will override all your config files! Backups will be created to .before_manuelraa_dotfiles Continue? [y/N]: " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
printf "\n"

printf ">>>>>>> Starting install in 5 seconds...\n"
printf ">>>>>>> Last chance to cancel and look at the script...\n"
sleep 5

printf "\n>>>>>>> copy all files which will be overriden to new file with ending .before_manuelraa_dotfiles\n"
printf ">>>>>>> to delete the backups use \"find -name \"*.before_manuelraa_dotfiles\" -exec rm -rf {} \;\"\n"
for file in $(find . -type f -not -name 'setup.sh' -not -name 'setup_minimal.sh' -not -name 'README.md' -not -path '*.git*'); do
    if test -f "$file"; then
        printf "COPY \"$HOME/$file\" TO \"$HOME/$file.before_manuelraa_dotfiles\"\n"
        cp "$HOME/$file" "$HOME/$file.before_manuelraa_dotfiles" || true
    fi
done

INSTALL_DIR=$HOME

printf "\n>>>>>>> Installing python modules I use\n"
pip3 install --user -U pip setuptools wheel ipdb

printf "\n>>>>>>> Copy dotfiles to $INSTALL_DIR"
rsync -av ./ $INSTALL_DIR --exclude ".git" --exclude "setup.sh" --exclude "setup_minimal.sh" --exclude "README.md" --exclude "create_nvim_venv.sh"

printf "\n>>>>>>> Installing TMUX plugin manager\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true

printf "\n>>>>>>> Installing NeoVim nightly\n"
mkdir $HOME/bin || true
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $HOME/bin/nvim_pre
chmod u+x $HOME/bin/nvim_pre

printf "\n>>>>>>> Installing node lts for NeoVim coc.nvim plugin"
curl -sL install-node.now.sh/lts | sudo bash

printf "\n>>>>>>> Installing NeoVim plugins\n"
$HOME/bin/nvim_pre +PlugInstall +q +q
$HOME/bin/nvim_pre "+CocInstall coc-python coc-vetur coc-yaml coc-tsserver coc-json coc-html"

printf "\nRestart your shell/system now! Just to make sure ^^\n"
printf "TODO: change python3 intepreter for nvim and install pynvim module\n"
printf ">>>>>>> to delete the backups of your old configs use \"find -name \"*.before_manuelraa_dotfiles\" -exec rm -rf {} \;\"\n"
