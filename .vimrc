set nocompatible                             " be iMproved, required

" Plugins
call plug#begin('~/.vim/plugged')   "required
" alternatively, pass a path where VimPlug should install plugins
"call plug#begin('~/some/path/here')

    " Tools
	Plug 'tpope/vim-fugitive'
	Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	Plug 'ryanoasis/vim-devicons'
	"Plug 'Yggdroot/indentLine'
	"Plug 'mhinz/vim-startify'
        "Plug 'airblade/vim-gitgutter'

	" Colorscheme
	Plug 'morhetz/gruvbox'
	Plug 'ap/vim-css-color'
	"Plug 'NLKNguyen/papercolor-theme'
	"Plug 'kristijanhusak/vim-hybrid-material'
        "Plug 'joshdick/onedark.vim'
	"Plug 'norcalli/nvim-colorizer.lua'

" All of your Plugs must be added before the following line
call plug#end()                              " required


" Brief help
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugUpgrade    - Upgrade vim-plug itself
" :PlugStatus     - Check the status of plugins
" :PlugDiff       - Examine changes from the previous update and the pending changes
" :PlugSnapshot   - Generate script for restoring the current snapshot of the plugins
"
" Put your non-Plug stuff after this line

" General Settings
set number                                   " always show line number
set mouse=a	                                 " enable mouse
"set updatetime=100
set splitbelow splitright
set wildmenu                                 " display all matches when tab complete
"set autoindent                               " always set autoindenting on
"set copyindent                               " copy the previous indentation on autoindenting
"set shiftwidth=4                             " number of spaces to use for autoindenting
"set shiftround                               " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                                " set show matching parenthesis
set ignorecase                               " ignore case when searching
set smartcase                                " ignore case if search pattern is all lowercase, 
                                             "    case-sensitive otherwise
set tabstop=4                                " a tab is four spaces
set backspace=indent,eol,start               " allow backspacing over everything in insert mode
"set smarttab                                 " insert tabs on the start of a line according to
                                             "    shiftwidth, not tabstop
set hlsearch                                 " highlight search terms
set incsearch                                " show search matches as you type
set cursorline                               " highlight cursor line

" Color Settings
set t_Co=256
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0           " selected texts are highlighted in white
set background=dark
colorscheme gruvbox
"syntax enable

" Airline Configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Key Bindings
map <C-e> :Lex <bar> vertical resize 30 <CR>
map <C-r> :source ~/.vimrc<CR>

" Vim cursor modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
