set nocompatible				" be iMproved, required

" Plugins
call plug#begin('/home/atif/.cache/nvim/plugged')
						"required

	" Tools
	Plug 'tpope/vim-fugitive'
	Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	Plug 'ryanoasis/vim-devicons'
	Plug 'preservim/nerdtree'
	"Plug 'Yggdroot/indentLine'
	"Plug 'mhinz/vim-startify'
	"Plug 'airblade/vim-gitgutter'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'airblade/vim-gitgutter'

	" Colorscheme
	Plug 'morhetz/gruvbox'
	Plug 'sainnhe/sonokai'
	"Plug 'NLKNguyen/papercolor-theme'
	Plug 'AtifChy/onedark.vim'
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
set t_Co=256					" color support
set encoding=UTF-8				" uses UTF-8 as the default encoding
set splitbelow splitright			" fix vim window split
set mouse=a					" enable mouse
set number					" always show line number
set showmatch					" set show matching parenthesis
set ignorecase					" ignore case when searching
set smartcase					" ignore case if search pattern is all lowercase, case-sensitive otherwise
set cursorline					" highlight cursor line
set clipboard+=unnamedplus			" copy paste between vim and everything else
set inccommand=nosplit				" required for hlsearch
"set updatetime=100

autocmd BufWritePre * %s/\s\+$//e		" remove trailing whitespace on save

" onedark settings
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
" `bg` will not be styled since there is no `bg` setting
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
  augroup END
endif

hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

syntax on
colorscheme onedark

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" gruvbox settings
"colorscheme gruvbox
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_invert_selection = 0		" selected texts are highlighted in white
"set background=dark				" set background color
"hi Normal ctermbg=NONE guibg=NONE		" transparent background

" sonokai settings
"colorscheme sonokai
"set termguicolors
"let g:sonokai_style = 'atlantis'
"let g:sonokai_style = 'andromeda'
"let g:sonokai_enable_italic = 1

" NERDTree Config
let g:NERDTreeDirArrowExpandable='►'
let g:NERDTreeDirArrowCollapsible='▼'
"let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" Air-line configuration
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" Key Bindings
map <C-e> :NERDTree<CR>
"map <C-r> :source /home/atif/.config/nvim/init.vim<CR>
"map <C-e> :Lex<bar>vertical resize 30<CR>
map <C-t> :term<CR>

" nvim config
if has('nvim')
    autocmd TermOpen term://* startinsert
endif

" source coc config
let g:coc_global_extensions = [
	\ 'coc-clangd',
	\ 'coc-pairs',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ 'coc-json',
	\ ]
source $HOME/.config/nvim/coc.vim
