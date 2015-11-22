#!/usr/bin/bash


set +x


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
	echo '' > ~/.vimrc
fi



# Create a base configuration file
echo -e '" Syntax highlighting' >> ~/.vimrc
echo 'syntax on' >> ~/.vimrc

echo -e '\n" Indentation' >> ~/.vimrc
echo 'set autoindent' >> ~/.vimrc
echo 'set tabstop=2' >> ~/.vimrc
echo 'set shiftwidth=2' >> ~/.vimrc

echo -e '\n" Highlight all search results' >> ~/.vimrc
echo 'set hlsearch' >> ~/.vimrc

echo -e '\n" Remove trailing whitespace character' >> ~/.vimrc
echo 'autocmd BufWritePre * :%s/\s\+$//e' >> ~/.vimrc





# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Pathogen conf
echo -e '\n" Enable pathogen' >> ~/.vimrc
echo 'execute pathogen#infect()' >> ~/.vimrc
echo 'filetype plugin indent on' >> ~/.vimrc




# Install ctrlp
if [[ ! -d ~/.vim/bundle/ctrlp ]]
then
	git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp
fi

# ctrlp conf
echo -e '\n" ctrlp - do not change working directory' >> ~/.vimrc
echo 'let g:ctrlp_working_path_mode = 0' >> ~/.vimrc




# Install vim-javascript
if [[ ! -d ~/.vim/bundle/vim-javascript ]]
then
	git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript
fi
