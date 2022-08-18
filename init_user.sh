#!/bin/sh

USERNAME=$1


adduser $USERNAME -m --shell /bin/zsh --disabled-password -aG sudo
echo "$USERNAME  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/username
echo 'eval "$(starship init zsh)"' >> /home/$USERNAME/.zshrc