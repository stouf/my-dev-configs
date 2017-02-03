" ##############
" Vundle options
" ##############

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" Plugins
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'pangloss/vim-javascript'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




" #################
" Personal settings
" #################

" Show line numbers
set number

" Enable syntax highlighting
syntax on
filetype plugin on
filetype indent on

" Line length limiter
set colorcolumn=120

" Highlight all search results
set hlsearch

" Highlight TODO, FIXME, etc.. and trailing white space characters
match Todo /\s\+$/

" Indent settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent

" ctrlp related options
let g:ctrlp_working_path_mode = 0

" Enable the markdown syntax highlight for .md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
