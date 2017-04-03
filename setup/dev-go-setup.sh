#!/bin/bash

GOVERSION=1.8
printf "\e[1;34mSetting up Golang %s\n\e[m" $GOVERSION

printf "\e[1;36mDownloading binary\n\e[m"
wget -N -q --show-progress https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go$GOVERSION.linux-amd64.tar.gz 

if ! grep -q '/usr/local/go/bin' /etc/profile
then
	printf "\e[1;36mSetting global GOROOT, adding GOROOT/bin to PATH\n\e[m"
	printf '\n# set global GOROOT and add GOROOT/bin to PATH\n' | sudo tee -a /etc/profile > /dev/null
	echo 'export GOROOT=/usr/local/go' | sudo tee -a /etc/profile > /dev/null
	echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a /etc/profile > /dev/null
else 
	
	printf "\e[1;36mGlobal GOPATH already set, ignoring\n\e[m"
fi

mkdir -p $HOME/dev
if ! grep -q 'GOPATH=$HOME/dev/go' "$HOME/.profile"
then
	printf "\e[1;36mSetting GOPATH, adding GOPATH/bin to PATH\n\e[m"
	printf '\n# set GOPATH and add GOPATH/bin to PATH\n' | tee -a "$HOME/.profile" > /dev/null
	echo 'export GOPATH=$HOME/dev/go' | tee -a "$HOME/.profile" > /dev/null
	echo 'export PATH=$PATH:$GOPATH/bin' | tee -a "$HOME/.profile" > /dev/null
else	
	printf "\e[1;36mGOPATH already set, ignoring\n\e[m"
fi

printf "\e[1;36mCleaning up\n\e[m"
rm go$GOVERSION.linux-amd64.tar.gz

printf "\e[1;34mGolang setup successful\n\e[m"
printf "\e[1;93mNOTE: You may need to symlink ~/dev/go to correctly point to the go workspace\n\e[m"
