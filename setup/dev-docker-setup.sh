printf "\e[1;34mSetting up Docker\n\e[m"

printf "\e[1;34mPrinting lsb_version\n\e[m"
cat /etc/os-release

printf "\e[1;33mPlease enter the ubuntu version identifier (eg bionic), then press [Enter]\n\e[m"
read ubuntu_version

printf "\e[1;34mSetting up APT repositories\n\e[m"
sudo apt-get -y install apt-transport-https ca-certificates curl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $ubuntu_version \
       stable"
sudo apt-get update

printf "\e[1;34mInstalling Docker-CE\n\e[m"
sudo apt-get -y install docker-ce

printf "\e[1;34mAdding current user to docker group\n\e[m"
sudo groupadd docker
sudo usermod -aG docker $USER

printf "\e[1;34mDocker setup successful\n\e[m"
printf "\e[1;93mNOTE: You will need to logout and log back in to run docker without sudo\n\e[m"
