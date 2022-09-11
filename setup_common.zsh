#!/bin/zsh

# Ensure the zsh shell is running.
if [[ $SHELL != *zsh ]]
then
    echo "This script must be run with zsh."
    exit 1
fi

# Setup git
git config --global user.name "Nicholas Buckeridge"
git config --global user.email bucknich@gmail.com
git config --global core.editor vim

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

# Install Starship.rs
# curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir $HOME/bin --yes > /dev/null

# Install our custom zsh run commands.
rm -rf ~/.zshrc
cp ~/Development/chadacity/zshrc ~/.zshrc
cp ~/Development/chadacity/oh-my-posh.json ~/.config/oh-my-posh.json

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

