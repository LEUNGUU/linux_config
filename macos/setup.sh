#!/usr/bin/env bash
# Setup script for setting up a new macos machine
# Be prepared to turn your macbook into an awesome
# development environment !

# checks architecture
# Rosetta 2 enables a Mac with Apple silicon to use apps built for a Mac with
# an Intel processor.

fancy_output ()
{
  local CYAN=`tput setaf 6`
  local WHITE=`tput setaf 15`
  local msg="${CYAN}\n$1\n${WHITE}"
  echo -e $msg
}

if [ "$(uname -m)" = "arm64" ]
  then
  # checks if Rosetta is already installed
  if ! pkgutil --pkg-info=com.apple.pkg.RosettaUpdateAuto > /dev/null 2>&1
  then
    fancy_output "Installing Rosetta"
    # Installs Rosetta2
    softwareupdate --install-rosetta --agree-to-license
  else
    fancy_output "Rosetta is installed"
  fi
fi


# # install xcode CLI
xcode-select --install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
  fancy_output "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Update homebrew recipes
brew update

# Installing from the API is now the default behaviour!
# You can save space and time by running below command.
brew untap homebrew/core || true
brew untap homebrew/cask || true

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
  unzip
  awscli
)


fancy_output "Installing packages..."
brew install ${PACKAGES[@]}


# Install cask
CASKS=(
  item2
  firefox
  neteasemusic
  itsycal
  keepingyouawake
)
fancy_output "Installing cask..."
brew install --cask ${CASKS[@]}

# Install nerd fonts
fancy_output "Installing fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-sauce-code-pro-nerd-font

# Language specific
fancy_output "Configuring Python..."
PYPACKAGES=(
  pyenv
)
brew install ${PYPACKAGES[@]}

fancy_output "Configuring Nodejs..."
NODEPACKAGES=(
  n
)
brew install ${NODEPACKAGES[@]}

fancy_output "Configuring Go..."
GOPACKAGE=(
  goenv
)
brew install ${GOPACKAGE[@]}

fancy_output "Configuring Terraform..."
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
  fancy_output "Backup zshrc file..."
  mv $HOME/.zshrc $HOME/.zshrc.bak
fi
cp $basedir/zshrc $HOME/.zshrc
cp $basedir/env.zsh $HOME/.env.zsh

# GHQ
if [ ! -d "$HOME/development/" ]; then
  fancy_output "Creating development folder..."
  mkdir "$HOME/development"
fi

# Neovim
fancy_output "Configuring Neovim..."
if [ ! -d "$HOME/.config/nvim/" ]; then
  git clone https://github.com/rafi/vim-config.git $HOME/.config/nvim
fi


fancy_output "Configuring OS..."
# Set fast key repeat rate
defaults write NSGLobalDomain KeyRepeat -int 0
# Autohide Dock when mouse is out
defaults write com.apple.dock "autohide" -bool "true" && killall Dock
