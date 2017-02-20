# Define PPAs:
ppaList=(
	"ppa:klaus-vormweg/awesome"
)

packagesList=(
	"awesome"
	"git"
	"xscreensaver"
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
