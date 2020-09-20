set nocompatible				" be iMproved, required

" Plugins
call plug#begin('~/.vim/plugged')		"required

	" Tools
	Plug 'tpope/vim-fugitive'
	Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	Plug 'ryanoasis/vim-devicons'
	"Plug 'preservim/nerdtree'
	"Plug 'Yggdroot/indentLine'
	"Plug 'mhinz/vim-startify'
	"Plug 'airblade/vim-gitgutter'
	"Plug 'itchyny/lightline.vim'

	" Colorscheme
	Plug 'morhetz/gruvbox'
	Plug 'sainnhe/sonokai'
	"Plug 'NLKNguyen/papercolor-theme'
	"Plug 'kristijanhusak/vim-hybrid-material'
	"Plug 'joshdick/onedark.vim'
	Plug 'ap/vim-css-color'

call plug#end()					" required

" Brief help
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugUpgrade    - Upgrade vim-plug itself
" :PlugStatus     - Check the status of plugins
" :PlugDiff       - Examine changes from the previous update and the pending changes
" :PlugSnapshot   - Generate script for restoring the current snapshot of the plugins

" General Settings
set splitbelow splitright			" fix vim window split
set mouse=a					" enable mouse
set number					" always show line number
set showmatch					" set show matching parenthesis
set ignorecase					" ignore case when searching
set smartcase					" ignore case if search pattern is all lowercase, case-sensitive otherwise
set cursorline					" highlight cursor line
set clipboard+=unnamedplus			" copy paste between vim and everything else
set inccommand=nosplit				" required for hlsearch
"set updatetime=300

autocmd BufWritePre * %s/\s\+$//e		" remove trailing whitespace on save

"" Color Settings
set t_Co=256

" gruvbox settings
colorscheme gruvbox
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0		" selected texts are highlighted in white
"set background=dark				" set background color
"hi Normal ctermbg=NONE guibg=NONE		" transparent background

" sonokai settings
"colorscheme sonokai
"if has('termguicolors')
"  set termguicolors
"endif
"let g:sonokai_style = 'atlantis'
"let g:sonokai_style = 'andromeda'
"let g:sonokai_enable_italic = 1

" NERDTree Config
"let g:NERDTreeDirArrowExpandable = '►'
"let g:NERDTreeDirArrowCollapsible = '▼'
"let NERDTreeShowLineNumbers=1
"let NERDTreeShowHidden=1
"let NERDTreeMinimalUI = 1

" Air-line configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Key Bindings
"map <C-e> :NERDTree<CR>
map <C-r> :source /home/atif/.config/nvim/init.vim<CR>
map <C-e> :Lex<bar>vertical resize 30<CR>
map <C-t> :term<CR>

" nvim config
if has('nvim')
    autocmd TermOpen term://* startinsert
endif

