#!/bin/bash
#Script to provision a new WSL2 instance of Ubuntu

# upgrade the system
sudo apt-get update
sudo apt-get -y upgrade

# install tool to change file endings
sudo apt-get install -y dos2unix

# install file archiving/extraction tools
sudo apt-get install -y unace rar unrar p7zip-rar p7zip zip unzip sharutils uudeview mpack lha arj cabextract file-roller

# install c++ tools
sudo apt-get install -y build-essential 

# install git tools 
sudo apt-get install -y git gitk
git config --global user.name "Ryan Bottoms"
git config --global user.email "rkbottoms@users.noreply.github.com"

# install python tools
sudo apt-get install -y python3 python3-pip
sudo apt-get install -y python3-venv
# VS Code complains if Pylint is unavailable as it cannot do some code checking:
pip3 install pylint
pip3 install virtualenvwrapper

# install json tools 
sudo apt-get -y install jq

# productivity tools
sudo apt-get install -y fzf fd-find httpie ripgrep htop
pip3 install glances 

# install dotfiles
git clone git@github.com:rkbottoms/dotfiles.git
cd dotfiles/
bash install-dotfiles.sh
cd ../
rm -rf dotfiles/

#create folder to projects
if [ ! -d /mnt/c/Users/ryanb/'My Documents'/Development ]; 
	then mkdir -p /mnt/c/Users/ryanb/'My Documents'/Development; 
fi

#link folder to WSL 
if [ ! -h ~/Development ]; 
	then ln -s /mnt/c/Users/ryanb/My Documents/Development
fi

#add ssh key to github
#copy ssh key from wsl to windows 

#clean up
sudo apt-get -y autoclean
sudo apt-get -y autoremove