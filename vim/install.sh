#!/usr/bin/env bash

set -e
set -u

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

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the vimrc file
cp ${DIR}/vimrc ~/.vimrc

# Copy the Language-client configuration file
cp ${DIR}/language-client-settings.json ${HOME}/.vim/settings.json

# Install floskell
current_dir=$(pwd)
cd /tmp && \
  git clone https://github.com/ennocramer/floskell && \
  cd floskell && \
  stack install && \
  cd ${current_dir} && \
  rm -rf /tmp/floskell

cp -r ${DIR}/ftplugin ~/.vim

# Installing all the plugins
vim +PlugInstall +qall
