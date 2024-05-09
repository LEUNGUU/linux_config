#!/usr/bin/env bash
# Setup script for setting up a new ubuntu machine
# Be prepared to turn your ubuntu into an awesome
# development environment !

fancy_output ()
{
  local CYAN=$(tput setaf 6)
  local WHITE=$(tput setaf 15)
  echo -e "${CYAN}\n#########################################################\n${WHITE}"
  echo -e "${CYAN}\n                 $1                                      \n${WHITE}"
  echo -e "${CYAN}\n#########################################################\n${WHITE}"

}

# update apt repository
sudo apt update -y


# Install neovim
fancy_output "Install neovim..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update 
sudo apt install neovim -y

# Install zsh
fancy_output "Install zsh..."
sudo apt install zsh -y

# Install starship
fancy_output "Install starship..."
curl -sS https://starship.rs/install.sh | sudo sh

# Install exa
fancy_output "Install exa..."
sudo apt install exa -y


if [ ! -d "$HOME/.config/" ]; then
  mkdir "$HOME/.config"
fi

basedir=$(dirname "$0")

# configure zsh
if [ -f "$HOME/.zshrc" ]; then
  fancy_output "Backup zshrc file..."
  mv "$HOME"/.zshrc "$HOME"/.zshrc.bak
fi
fancy_output "Configuring zsh..."
cp "$basedir"/zshrc "$HOME"/.zshrc
cp "$basedir"/env.zsh "$HOME"/.env.zsh

# Configuring starship prompt
fancy_output "Configuring starship..."
cp "$basedir"/starship.toml "$HOME"/.config/starship.toml

# configure neovim
fancy_output "Configuring nvim..."
cp -a "$basedir"/../nvim "$HOME"/.config/

# configure tmux
fancy_output "Configuring tmux..."
cp -a "$basedir"/tmux.conf "$HOME"/.tmux.conf
