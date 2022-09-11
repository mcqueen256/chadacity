#!/bin/zsh
#
# Nic's Software Development Environment for Macosx.
#
# Before running, install xcode and

THIS_SCRIPTS_DIR=${0:a:h}

source $THIS_SCRIPTS_DIR/setup_common.zsh


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

brew install \
  bat \
  bottom \
  brainfuck \
  jandedobbeleer/oh-my-posh/oh-my-posh \
  tmux

