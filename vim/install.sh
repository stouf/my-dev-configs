#!/usr/bin/env bash


set +x




DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"





# Check if vim is installed
if [[ ! -e $(which vim) ]]
then
	echo 'vim seems not to be installed on your system'
	exit 1
fi

# Check if git is installed
if [[ ! -e $(which git) ]]
then
	echo 'git seems not to be installed on your system'
	exit 1
fi






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


# Install Vundle
if [[ ! -d ~/.vim/bundle/Vundle.vim ]]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


# Copy the vimrc file
cp ${DIR}/vimrc ~/.vimrc


# Installing all the plugins
vim +PluginInstall +qall


# Mac OS specific
echo 'Are you using Mac OS? [y/N]'
read is_mac_os
if [[ ${is_mac_os} = 'y' || ${is_mac_os} = 'Y' ]]
then
  cat ${DIR}/vimrc-macos >> ~/.vimrc
fi
