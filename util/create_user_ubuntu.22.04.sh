#!/bin/sh

USERNAME=$1
adduser $USERNAME  --shell /bin/zsh --disabled-password --ingroup sudo
echo "$USERNAME  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/username