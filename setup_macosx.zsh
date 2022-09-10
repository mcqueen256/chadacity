#!/bin/zsh
#
# Nic's Software Development Environment for Macosx.
#
# Before running, install xcode and

THIS_SCRIPTS_DIR=${0:a:h}

source $THIS_SCRIPTS_DIR/setup_common.zsh


if ! [ -d ~/Development/chadacity ]
then
    mkdir -p ~/Development
    cd ~/Development
    git clone git@github.com:mcqueen256/chadacity.git
fi

# VSCode setup.
VSCODE_BIN_PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
if [ -d "$VSCODE_BIN_PATH" ] && ! [ -f ~/bin/code  ]
then
    mkdir -p ~/bin
    ln -s "$VSCODE_BIN_PATH/code" ~/bin/code
fi

# Fonts
# Change font to "MesloLGMZD Nerd Font Mono"
echo "Downloading and Unzipping Meslo Nerd Fonts..."
MESLO_ZIP="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip"
PREVIOUS_DIR=$PWD
cd $HOME/Library/Fonts
chmod u+x $THIS_SCRIPTS_DIR/util/progress_bar.zsh
# curl:   Download the fonts and send zip to stdout.
# bsdtar: Unzip stdin, place in current directory, send file names to stdout.
# cut:    Want only the file names, expect "x <file name with spaces>
# awk:    convert names to line number
# xargs:  print a progress bar (we know there are 96 items).
curl --proto '=https' --tlsv1.2 -sSL $MESLO_ZIP \
    | bsdtar -xvf- 2>&1 \
    | cut -d' ' -f 2- \
    | awk '{print NR; system("")}' \
    | xargs -I _ $THIS_SCRIPTS_DIR/util/progress_bar.zsh Unzipping _ 96
# Remove windows fonts because this script is for macosx.
ls $HOME/Library/Fonts/ | grep Windows | xargs -I _ rm "$HOME/Library/Fonts/_"
cd $PREVIOUS_DIR

# Oh My Zsh
echo installing Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# curl --proto '=https' --tlsv1.2 -sSL $MESLO_ZIP | bsdtar -xvf- 2>&1 | grep Windows | cut -d' ' -f 2- | xargs -I _ rm \"_\"
# curl --proto '=https' --tlsv1.2 -sSL $MESLO_ZIP | bsdtar -xvf- 2>&1 | cut -d' ' -f 2- | nl | cut -f1
# curl --proto '=https' --tlsv1.2 -sSL $MESLO_ZIP --output Meslo.zip 1>&2
# curl --proto '=https' --tlsv1.2 -sSf $MESLO_ZIP | bsdtar -xvf-
# TMP_FILE=/tmp/setup/meslo_unzip_output.txt
# mkdir -p /tmp/setup
# curl --proto '=https' --tlsv1.2 -L -sSf $MESLO_ZIP | bsdtar -xvf- 2> $TMP_FILE
# # Remove windows fonts.
# cat $TMP_FILE | grep Windows | cut -d' ' -f 2-
# echo "Unzipping Fonts..."
# unzip 
