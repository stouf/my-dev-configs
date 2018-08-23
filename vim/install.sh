#!/usr/bin/env bash

set +x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Already existing configuration file ?
if [[ -e ~/.vimrc ]]
then
	echo 'A ~/.vimrc file already exists on the filesystem. Do you want to override it and continue ? [y/N]'
	read override
	if [[ $override = 'N' || $override = 'n' || -z $override ]]
	then
		echo 'Aborting.'
		exit 0
	fi
fi

# Platform detection
platform='linux'
echo 'Are you using Mac OS? [y/N]'
read is_mac_os
if [[ ${is_mac_os} = 'y' || ${is_mac_os} = 'Y' ]]
then
  platform='mac'
fi

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the vimrc file
cp ${DIR}/vimrc ~/.vimrc

# Installing all the plugins
vim +PlugInstall +qall

# Install the dependencies of some plugins
sudo npm install -g flow-language-server ocaml-language-server prettier
go get -u github.com/zmb3/gogetdoc
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm reason-cli@latest-linux bs-platform@latest

echo "Please do not forget to install fzf (https://github.com/junegunn/fzf) if you haven't already done it"
