#!/usr/bin/env bash
# Setup script for setting up a new macos machine
# Be prepared to turn your macbook into an awesome
# development environment !

# checks architecture
# Rosetta 2 enables a Mac with Apple silicon to use apps built for a Mac with
# an Intel processor.
if [ "$(uname -m)" = "arm64" ]
  then
  # checks if Rosetta is already installed
  if ! pkgutil --pkg-info=com.apple.pkg.RosettaUpdateAuto > /dev/null 2>&1
  then
    echo "Installing Rosetta"
    # Installs Rosetta2
    softwareupdate --install-rosetta --agree-to-license
  else
    echo "Rosetta is installed"
  fi
fi


# # install xcode CLI
xcode-select --install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Update homebrew recipes
brew update

# Installing from the API is now the default behaviour!
# You can save space and time by running below command.
brew untap homebrew/core
brew untap homebrew/cask

# Install packages
PACKAGES=(
  bash
  zsh
  git
  docker
  neovim
  tmux
  wget
  bat
  fd
  ripgrep
  zoxide
  fzf
  exa
  ghq
  peco
  starship
  awscli
)
unzip


echo "Installing packages..."
brew install ${PACKAGES[@]}


# Install cask
CASKS=(
  item2
  firefox
  neteasemusic
  itsycal
  keepingyouawake
)
echo "Installing cask..."
brew install --cask ${CASKS[@]}

# Install nerd fonts
echo "Installing fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-sauce-code-pro-nerd-font

# Language specific
echo "Configuring Python..."
PYPACKAGES=(
  pyenv
)
brew install ${PYPACKAGES[@]}

echo "Configuring Nodejs..."
NODEPACKAGES=(
  n
)
brew install ${NODEPACKAGES[@]}

echo "Configuring Go..."
GOPACKAGE=(
  goenv
)
brew install ${GOPACKAGE[@]}

echo "Configuring Terraform..."
TFPACKAGE=(
  tfenv
)
brew install ${TFPACKAGE[@]}


# ZSH
if [ ! -d "$HOME/.config/" ]; then
  mkdir "$HOME/.config"
fi
basedir=$(dirname $0)
if [ -f "$HOME/.zshrc" ]; then
  echo "Backup zshrc file..."
  mv $HOME/.zshrc $HOME/.zshrc.bak
fi
cp $basedir/zshrc $HOME/.zshrc
cp $basedir/env.zsh $HOME/.env.zsh

# Neovim
echo "Configuring Neovim..."
git clone git@github.com:rafi/vim-config.git ~/.config/nvim


echo "Configuring OS..."
# Set fast key repeat rate
defaults write NSGLobalDomain KeyRepeat -int 0
# Autohide Dock when mouse is out
defaults write com.apple.dock "autohide" -bool "true" && killall Dock
