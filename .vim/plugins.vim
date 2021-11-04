set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

"Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'leafgarland/typescript-vim'
Plugin 'posva/vim-vue'
Plugin 'neoclide/coc.nvim'
Plugin 'cakebaker/scss-syntax.vim'

call vundle#end()

filetype plugin indent on
