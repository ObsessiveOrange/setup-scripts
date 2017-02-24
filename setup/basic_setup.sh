# Define PPAs:
ppaList=(
	"ppa:klaus-vormweg/awesome"
	"ppa:shutter/ppa"
)

packagesList=(
	"awesome"
	"git"
	"xscreensaver"
	"okular"
	"vim"
	"keychain"
	"htop"
	"arandr"
	"shutter"
	"blueman"
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

# Special Installers
## Termite (needs to be compiled from source)
printf "\e[1;34mInstalling termite:\n\e[m"
git clone https://github.com/ObsessiveOrange/termite-installer.git
pushd termite-installer >> /dev/null
./install.sh
popd >> /dev/null
rm -rf termite-installer

# Setup configurations
## Configure awesome-wm
printf "\e[1;34mConfiguring awesome-wm:\n\e[m"
mv ~/.config/awesome ~/.config/awesome.swp
git clone --recursive https://github.com/copycat-killer/awesome-copycats.git
mv awesome-copycats ~/.config/awesome
rsync -a --remove-source-files ~/.config/awesome.swp/ ~/.config/awesome/
rm -rf ~/.config/awesome.swp

## Configure .bashrc & .profile
if ! grep -q '# include .bashrc_user if it exists' "$HOME/.bashrc"
then
	printf "\n# include .bashrc_wongb if it exists\nif [ -f $HOME/.bashrc_wongb ]; then\n    . $HOME/.bashrc_wongb\nfi\n" >> ~/.bashrc
fi

if ! grep -q '# include .profile_user if it exists' "$HOME/.profile"
then
	printf "\n# include .profile_wongb if it exists\nif [ -f $HOME/.profile_wongb ]; then\n    . $HOME/.profile_wongb\nfi\n" >> ~/.profile
fi
