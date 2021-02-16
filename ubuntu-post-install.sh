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
	then ln -s /mnt/c/Users/ryanb/'My Documents'/Development
fi

#add ssh key to github
#copy ssh key from wsl to windows 

#set up pip autocompletion
pip completion --bash >> ~/.bashrc
#set up virtualenv
echo "#activate virtualenvwrapper on startup" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "export WORKON_HOME= /mnt/c/Users/ryanb/My\ Documents/Development/python"  >> ~/.bashrc
echo "source ~/.local/bin/virtualenvwrapper.sh" >> ~/.bashrc

source ~/.bashrc

#install conda
wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh -O ~/anaconda.sh
bash ~/anaconda.sh -b -p $HOME/anaconda
conda init
conda config --set auto_activate_base false
conda update --all
echo "export BROWSER='/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'" >> ~/.bashrc
conda activate
conda install -c conda-forge jupyterlab -y 
jupyter lab --generate-config
conda deactivate

# install .net core sdk and runtime
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get update 
sudo apt-get install -y dotnet-sdk-5.0
dotnet tool install -g dotnet-runtimeinfo

# install math tools
sudo apt-get install pandoc texlive-full textlive-latex-extra wkhmtmltopdf -y

# install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb -y 

# install hugo
wget https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_extended_0.80.0_Linux-64bit.deb
sudo dpkg -i hugo_extended_0.80.0_Linux-64bit.deb
curl -fsSL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install postcss-cli

#clean up
sudo apt-get -y autoclean
sudo apt-get -y autoremove
echo "Remember to uncomment 'c.NotebookApp.use_redirect_file = False' in the jupyter lab config file"
