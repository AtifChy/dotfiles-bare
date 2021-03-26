"set nocompatible 					" be iMproved, required

" Install vim-plug if not found
if empty(glob('/home/atif/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo /home/atif/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source /home/atif/.config/nvim/init.vim
endif

" Plugins
call plug#begin('/home/atif/.cache/nvim/plugged') 	"required

" tools
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
"Plug 'preservim/nerdtree'
"Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'airblade/vim-gitgutter'
"Plug 'itchyny/lightline.vim'
"Plug 'dag/vim-fish'
Plug 'tjdevries/coc-zsh'

" colorschemes
"Plug 'morhetz/gruvbox'
"Plug 'sainnhe/sonokai'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'AtifChy/onedark.vim'
Plug 'ap/vim-css-color'
"Plug 'mhartington/oceanic-next'

call plug#end()						" required

" Brief help
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugUpgrade    - Upgrade vim-plug itself
" :PlugStatus     - Check the status of plugins
" :PlugDiff       - Examine changes from the previous update and the pending changes
" :PlugSnapshot   - Generate script for restoring the current snapshot of the plugins

