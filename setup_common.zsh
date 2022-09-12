#!/bin/zsh

# Ensure the zsh shell is running.
if [[ $SHELL != *zsh ]]
then
    echo "This script must be run with zsh."
    exit 1
fi

THIS_SCRIPTS_DIR=${0:a:h}
source $THIS_SCRIPTS_DIR/settings.zsh

# Setup git
git config --global user.name "$GIT_FULL_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor "$GIT_EDITOR"
git config --global url.https://github.com/.insteadOf git://github.com/

# Create basic directory structure
mkdir -p ~/bin
mkdir -p ~/.config

if ! [ -d ~/Development/chadacity ]
then
    mkdir -p ~/Development
    cd ~/Development
    git clone git@github.com:mcqueen256/chadacity.git
fi


# Oh My Zsh
echo installing Oh My ZSH
# RUNZSH - 'no' means the installer will not run zsh after the install (default: yes)
RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Oh My Posh
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O $HOME/bin/oh-my-posh
chmod +x $HOME/bin/oh-my-posh

# Install our custom zsh run commands.
rm -rf ~/.zshrc
cp ~/Development/chadacity/zshrc ~/.zshrc
cp ~/Development/chadacity/oh-my-posh.json ~/.config/oh-my-posh.json

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
cargo install --locked exa

