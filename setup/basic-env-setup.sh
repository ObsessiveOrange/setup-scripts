#!/bin/bash

# Define PPAs:
ppaList=(
)

packagesList=(
	"git"
	"vim"
	"keychain"
	"htop"
)

fontPackagesList=(
	"fonts-cantarell"
	"lmodern"
	"ttf-aenigma"
	"ttf-bitstream-vera"
	"ttf-engadget"
	"ttf-mscorefonts-installer"
	"ttf-sjfonts"
	"fonts-tuffy"
	"tv-fonts"
	"ubuntustudio-font-meta"
)

# Add ppa
printf "\e[1;34mAdding APT repositories (PPAs):\n\e[m"
for i in "${ppaList[@]}"
do
	printf "\e[1;36m> Adding apt-repository %s:\n\e[m" $i
	sudo add-apt-repository -y $i
done
echo ""

# Update apt
printf "\e[1;34mUpdating APT cache:\n\e[m"
sudo apt update
echo ""

# Install packages
packageStr=$(printf "\n> %s" "${packagesList[@]}")
printf "\e[1;34mInstalling packages: \e[1;36m%s\e[1;34m\n\e[m" "$packageStr"
sudo apt install -y "${packagesList[@]}"
echo ""

# Install packages
fontPackageStr=$(printf "\n> %s" "${fontPackagesList[@]}")
printf "\e[1;34mInstalling fonts packages: \e[1;36m%s\e[1;34m\n\e[m" "$fontPackageStr"
sudo apt install -y "${fontPackagesList[@]}"
echo ""

# Configure .bashrc & .profile
if ! grep -q '# include .bashrc_user if it exists' "$HOME/.bashrc"
then
	printf "\n# include .bashrc_wongb if it exists\nif [ -f $HOME/.bashrc_wongb ]; then\n    . $HOME/.bashrc_wongb\nfi\n" >> ~/.bashrc
	cp .bashrc_wongb $HOME/.bashrc_wongb
fi

if ! grep -q '# include .profile_user if it exists' "$HOME/.profile"
then
	printf "\n# include .profile_wongb if it exists\nif [ -f $HOME/.profile_wongb ]; then\n    . $HOME/.profile_wongb\nfi\n" >> ~/.profile
	cp .profile_wongb $HOME/.profile_wongb
fi
