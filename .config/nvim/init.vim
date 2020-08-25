set nocompatible                             " be iMproved, required

" Plugins
call plug#begin('/home/atif/.vim/plugged')   "required
" alternatively, pass a path where VimPlug should install plugins
"call plug#begin('~/some/path/here')
        
	" Tools
	Plug 'tpope/vim-fugitive'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ryanoasis/vim-devicons'
	"Plug 'preservim/nerdtree'
	"Plug 'Yggdroot/indentLine'
	"Plug 'mhinz/vim-startify'
	"Plug 'airblade/vim-gitgutter'
	
	" Colorscheme
	Plug 'morhetz/gruvbox'
	Plug 'sainnhe/edge'
	Plug 'sainnhe/sonokai'
	"Plug 'gruvbox-community/gruvbox'
	"Plug 'NLKNguyen/papercolor-theme'
	"Plug 'kristijanhusak/vim-hybrid-material'
	"Plug 'joshdick/onedark.vim'
	Plug 'ap/vim-css-color'
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

" Put your non-Plug stuff after this line

" General Settings
set splitbelow splitright
set mouse=a                                  " enable mouse 
set number                                   " always show line number
set showmatch                                " set show matching parenthesis
set ignorecase                               " ignore case when searching
set smartcase                                " ignore case if search pattern is all lowercase, 
                                             "     case-sensitive otherwise
set cursorline                               " highlight cursor line
set clipboard=unnamedplus                    " copy paste between vim and everything else
set inccommand=nosplit                       " required for hlsearch
set updatetime=100

" Color Settings
set t_Co=256
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_invert_selection = 0           " selected texts are highlighted in white
"colorscheme gruvbox
"set background=dark	                      " set background color
"hi Normal ctermbg=NONE guibg=NONE            " transparent background

"edge settings
"set termguicolors
"let g:edge_style = 'aura'
"let g:edge_disable_italic_comment = 1
"colorscheme edge

"sonokai settings
colorscheme sonokai
if has('termguicolors')
  set termguicolors
endif
let g:sonokai_style = 'atlantis'
"let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1

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

" Require for nvim-colorizer
"lua require'colorizer'.setup()

" nvim config
if has('nvim')
    autocmd TermOpen term://* startinsert
endif
