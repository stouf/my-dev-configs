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


# Install pathogen
if [[ ! -d ~/.vim/bundle ]]
then
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi



# Installing all the plugins
cpt=0
for i in $(cat ${DIR}/pathogen_plugins.txt)
do
	if [[ $cpt -eq 0 ]]
	then
		name=$i
		cpt=$(($cpt + 1))
	else
		url=$i
		if [[ -d ~/.vim/bundle/${name} ]]
		then
			echo "${name} already exists in your ~/.vim/bundle directory. Skipping..."
		else
			git clone $url ~/.vim/bundle/${name}
		fi
		cpt=0
	fi
done



# Copy the vimrc file
cp ${DIR}/vimrc ~/.vimrc
