#!/usr/bin/env bash
# Setup script for setting up a new ubuntu machine
# Be prepared to turn your ubuntu into an awesome
# development environment !
#
#
BOB_VERSION=v2.9.1
NVIM_VERSION=0.9.5

fancy_output ()
{
  local CYAN=$(tput setaf 6)
  local WHITE=$(tput setaf 15)
  echo -e "${CYAN}\n#########################################################\n${WHITE}"
  echo -e "${CYAN}\n                 $1                                      \n${WHITE}"
  echo -e "${CYAN}\n#########################################################\n${WHITE}"

}

# update apt repository
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install unzip build-essential fzf python3-venv -y



# Install neovim version manager
if [ ! -d "$HOME/.local/bin" ]; then
  mkdir -p "$HOME/.local/bin"
fi
fancy_output "Install bob(neovim version manager)..."
BOB_PREFIX="$HOME"/.bob-nvim
wget https://github.com/MordechaiHadad/bob/releases/download/$BOB_VERSION/bob-linux-x86_64.zip -O bob.zip
unzip bob.zip -d "$BOB_PREFIX"/ && mv "$BOB_PREFIX"/bob-linux-x86_64/bob "$BOB_PREFIX"/
chmod +x "$BOB_PREFIX"/bob && rm -rf "$BOB_PREFIX"/bob-linux-x86_64/


# Install n
curl -L https://git.io/n-install | bash

# Install tfenv
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.zprofile

# Install zsh
fancy_output "Install zsh..."
sudo DEBIAN_FRONTEND=noninteractive apt install zsh -y

# Install aws cli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install starship
fancy_output "Install starship..."
curl -sS https://starship.rs/install.sh | sudo sh

# Install exa
fancy_output "Install exa..."
sudo DEBIAN_FRONTEND=noninteractive apt install exa -y

# Install neovim with bob
"$BOB_PREFIX"/bob install $NVIM_VERSION && "$BOB_PREFIX"/bob use $NVIM_VERSION


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

# configure git user
fancy_output "Configuring gitconfig..."
cp -a "$basedir"/gitconfig "$HOME"/.gitconfig

# change login shell to zsh
sudo chsh -s /bin/zsh "$USER"



# Install after changing to zsh
# Install miniconda
# fancy_output "Install miniconda..."
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# chmod +x Miniconda3-latest-Linux-x86_64.sh
# ./Miniconda3-latest-Linux-x86_64.sh

