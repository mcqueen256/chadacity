# Setup Macosx

This is a script for setting up my Macos Environment automatically.

Machine setup Instructions.

## Install XCode.

## Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Run the setup script

```
mkdir ~/Development
cd ~/Development
git clone git@github.com:mcqueen256/chadacity.git
cd
zsh ~/Development/chadacity/setup_macosx.zsh
```