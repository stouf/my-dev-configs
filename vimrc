" vim-pathogen
execute pathogen#infect()
filetype plugin indent on


" Show line numbers
set number

" Enable syntax highlighting
syntax on

" Line length limiter
set colorcolumn=120

" Highlight all search results
set hlsearch

" Highlight TODO, FIXME, etc.. and trailing white space characters
match Todo /\s\+$/

" Auto-indentation
set autoindent
set tabstop=2
set shiftwidth=2

" ctrlp related options
let g:ctrlp_working_path_mode = 0

" Enable the markdown syntax highlight for .md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
