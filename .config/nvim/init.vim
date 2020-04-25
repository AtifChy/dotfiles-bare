"set nocompatible              " be iMproved, required
"filetype off                  " required

call plug#begin('~/.vim/plugged')
" alternatively, pass a path where vim-plug should install plugins
"call plug#begin('~/some/path/here')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
"Plug 'airblade/vim-gitgutter'

" All of your Plugs must be added before the following line
call plug#end()

" Brief help
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugUpgrade    - Upgrade vim-plug itself
" :PlugStatus     - Check the status of plugins
" :PlugDiff       - Examine changes from the previous update and the pending changes 
" :PlugSnapshot   - Generate script for restoring the current snapshot of the plugins
"
" Put your non-Plug stuff after this line

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

colorscheme gruvbox
set background=dark

set mouse=a                      " enable mouse 
"set updatetime=100
set number                       " always show line number
set ignorecase                   " ignore case when searching
set smartcase                    " ignore case if search pattern is all lowercase, case-sensitive otherwise
set cursorline
