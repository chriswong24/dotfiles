"
" Indenting
"

set tabstop=4
set shiftwidth=2
set smarttab
set expandtab
set autoindent
set cursorline
retab

"
" Basics
"

colorscheme gruvbox
set term=screen-256color
set number
set nocompatible
syntax enable
set shell=bash
set bs=2
set mouse=a


"
" Other
" 
set viminfo='100,<1000,s100,h

set updatetime=100
let g:gitgutter_max_signs = 1000

autocmd BufNewFile, BufReadPost *.tpp set filetype=cpp
