#!/bin/bash
set -e -x

read -p "This script will override all your config files! Backups will be created to .before_manuelraa_dotfiles Continue? [y/N]: " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
printf ""

printf ">>>>>>> Starting install in 5 seconds...\n"
printf ">>>>>>> Last chance to cancel and look at the script...\n"
sleep 5

printf "\n>>>>>>> copy all files which will be overriden to new file with ending .before_manuelraa_dotfiles\n"
printf ">>>>>>> to delete the backups use \"find -name \"*.before_manuelraa_dotfiles\" -exec rm -rf {} \;\"\n"
for file in $(find . -type f -not -name 'setup.sh' -not -name 'setup_minimal.sh' -not -name 'README.md' -not -path '*.git*'); do
    if test -f "$file"; then
        printf "COPY \"$HOME/$file\" TO \"$HOME/$file.before_manuelraa_dotfiles\""
        cp "$HOME/$file" "$HOME/$file.before_manuelraa_dotfiles"  || true
    fi
done

INSTALL_DIR=$HOME
printf "\n>>>>>>> Installing dependencies using APT\n"
sudo apt install python3 python3-dev python3-venv python3-pip fonts-powerline zsh neovim ranger volumeicon-alsa ctags

printf "\n>>>>>>> Other stuff I use\n"
sudo apt install git wget curl httpie flameshot htop

printf "\n>>>>>>> Installing python modules I use\n"
pip3 install --user -U pip setuptools wheel ipdb pynvim

printf "\n>>>>>>> Installing tools I use\n"
# tldr
printf "tldr -- easy man pages broken down to the important stuff\n"
mkdir ~/bin || true
curl -o ~/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
chmod u+x ~/bin/tldr

# commacd
printf "Faster then cd....  -> https://github.com/shyiko/commacd\n"
curl -sSL https://raw.githubusercontent.com/shyiko/commacd/master/commacd.sh -o ~/.commacd.sh

printf "\n>>>>>>> Copy dotfiles to $INSTALL_DIR"
rsync -av ./ $INSTALL_DIR --exclude ".git" --exclude "setup.sh" --exclude "setup_minimal.sh" --exclude "README.md" --exclude "create_nvim_venv.sh"

printf "\n>>>>>>> Installing TMUX plugin manager\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true

printf "\n>>>>>>> Installing NeoVim nightly\n"
mkdir $HOME/bin || true
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $HOME/bin/nvim_pre
chmod u+x $HOME/bin/nvim_pre

printf "\n>>>>>>> Installing NeoVim plugins\n"
nvim +PlugInstall +q +q

#printf ">>>>>>> Installing Icon Pack"
#wget -qO- https://git.io/papirus-icon-theme-install | sh

printf "\n>>>>>>> Installing OhMyZsh\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv $INSTALL_DIR/.zshrc.pre_oh_my_zsh $INSTALL_DIR/.zshrc

printf "\n>>>>>>> Installing pyenv\n"
git clone https://github.com/pyenv/pyenv.git ~/.pyenv || true
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv || true
sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

printf "\nRestart your shell/system now! Just to make sure ^^\n"
printf "Then use the create_nvim_venv.sh script inside zsh\n"
printf ">>>>>>> to delete the backups of your old configs use \"find -name \"*.before_manuelraa_dotfiles\" -exec rm -rf {} \;\"\n"
