My vim
======


Simple script doing the following:

* Install [pathogen](https://github.com/tpope/vim-pathogen)
* Install [ctrlp](https://github.com/kien/ctrlp.vim)
* Install [vim-javascript](https://github.com/pangloss/vim-javascript)
* Generate a configuration file as below


```
" Syntax highlighting
syntax on

" Indentation
set autoindent
set tabstop=2
set shiftwidth=2

" Highlight all search results
set hlsearch

" Remove trailing whitespace character
autocmd BufWritePre * :%s/\s\+$//e

" Enable pathogen
execute pathogen#infect()
filetype plugin indent on

" ctrlp - do not change working directory
let g:ctrlp_working_path_mode = 0
```
