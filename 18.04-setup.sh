#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt install \
  apt-transport-https \
  awscli \
  bc \
  bison \
  ca-certificates \
  curl \
  exuberant-ctags \
  flex \
  gcc \
  git \
  gnupg-agent \
  keepassx \
  libncurses5-dev \
  libssl-dev \
  libelf-dev \
  make \
  manpages \
  manpages-dev \
  manpages-posix \
  manpages-posix-dev \
  #python3-pip \
  ntp \
  synapse \
  software-properties-common \
  tree \
  vim-gui-common \
  vim-runtime \
  xclip

# aws cli
#pip3 install awscli --upgrade --user

# docker
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli docker-compose containerd.io

sudo groupadd docker
sudo usermod -aG docker $USER

# kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl/
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# keybase
# https://keybase.io/docs/the_app/install_linux
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
# if you see an error about missing `libappindicator1` from the next
# command, you can ignore it, as the subsequent command corrects it
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
run_keybase

# set timezone
timedatectl set-timezone America/Toronto

# setup git
git config --global user.name "Ed Tan"
git config --global user.email edtan@users.noreply.github.com

# get autostart files
mkdir -p ~/.config/autostart
cp synapse.desktop ~/.config/autostart/synapse.desktop

# get keyboard shortcut mappings
# https://askubuntu.com/a/306172 -> window tiling
# TODO: merge keybindings.xml into lubuntu-rc.xml

# https://askubuntu.com/a/80237 -> lock screen
# but lubuntu 18.04 uses light-locker instead of xscreensaver, and the default install command is wrong
# TODO: change the command from (lxsession-default lock) to:  light-locker-command -l

# install vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle
git clone https://github.com/mbbill/undotree.git
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/tpope/vim-fugitive.git

# get vimrc files
# note: if manually set up, need to use set nocompatible first (add link to stackoverflow about this)
mkdir -p ~/.bootstrap-lubuntu
cd ~/.bootstrap-lubuntu
git clone https://github.com/edtan/vimrc.git
ln -s ~/.bootstrap-lubuntu/vimrc/vimrc ~/.vimrc
