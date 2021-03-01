
" ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗
" ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║
" ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║
" ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║
" ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║
" ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝

"======================> VIM-PLUG <=======================

" Plugins
call plug#begin('/home/atif/.cache/nvim/plugged') 	"required

" tools
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
"Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'airblade/vim-gitgutter'
"Plug 'itchyny/lightline.vim'
"Plug 'dag/vim-fish'
Plug 'tjdevries/coc-zsh'

" colorschemes
Plug 'AtifChy/onedark.vim'
"Plug 'ap/vim-css-color'

call plug#end()						" required

" Brief help
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugUpgrade    - Upgrade vim-plug itself
" :PlugStatus     - Check the status of plugins
" :PlugDiff       - Examine changes from the previous update and the pending changes
" :PlugSnapshot   - Generate script for restoring the current snapshot of the plugins

"======================> VIM-PLUG <=======================

" General Settings
set t_Co=256						" color support
set encoding=UTF-8					" uses UTF-8 as the default encoding
set splitbelow splitright				" fix vim window split
set mouse=a						" enable mouse
set number						" always show line number
"set number relativenumber 				" show number relativenumber
set showmatch						" set show matching parenthesis
set ignorecase						" ignore case when searching
set smartcase						" ignore case if search pattern is all lowercase, case-sensitive otherwise
set cursorline						" highlight cursor line
set cursorcolumn 					" highlight cursor column
set clipboard+=unnamedplus				" copy paste between vim and everything else
set inccommand=nosplit					" required for hlsearch
set updatetime=100
filetype plugin indent on
set expandtab
set shiftwidth=4
set tabstop=4

"autocmd InsertEnter * norm zz 				" vertically center document in insert mode
autocmd BufWritePre * %s/\s\+$//e			" remove trailing whitespace on save
autocmd BufWritePost ~/.config/X11/Xresources,~/.config/X11/Xdefaults !xrdb -merge %
							" run xrdb on ~/.Xresources & ~/.Xdefaults when I edit them

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
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 0
let g:onedark_termcolors = 256

colorscheme onedark

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" Air-line configuration
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline_extensions = ['branch', 'tabline', 'coc']

" indent plugin settings
let g:indentLine_char_list = ['|']

" Key Bindings
nnoremap <Space> <Nop>
let mapleader = " "
map <C-e> :CocCommand explorer<CR>
map <M-s> :setlocal spell! spelllang=en_US<CR>
"map <C-e> :NERDTree<CR>
map <C-s> :source /home/atif/.config/nvim/init.vim<CR>
"map <C-e> :Lex<bar>vertical resize 30<CR>

" neovim terminal config
map <leader>t :sp term://zsh<bar>resize 18<CR>
tnoremap <Esc> <C-\><C-n>
if has('nvim')
    autocmd TermOpen term://* startinsert
endif

"" Cursor fix
"augroup RestoreCursorShapeOnExit
"    autocmd!
"    autocmd VimLeave * set guicursor=a:hor20
"augroup END

" coc plugin/s
let g:coc_global_extensions = [
	\ 'coc-clangd',
	\ 'coc-pairs',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ 'coc-json',
	\ 'coc-explorer',
	\ 'coc-rls',
	\ 'coc-html',
	\ 'coc-prettier',
	\ 'coc-sh',
	\ 'coc-highlight'
	\ ]

" coc-prettier config
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" source plugin config
"source /home/atif/.config/nvim/coc.vim
"source $HOME/.config/nvim/lightline.vim

" startify config
let g:startify_custom_header = [
	\'   ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗ ',
	\'   ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║ ',
	\'   ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║ ',
	\'   ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║ ',
	\'   ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║ ',
	\'   ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝ ',
	\]
let g:startify_lists = [
	\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
	\ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'commands',  'header': ['   Commands']       },
    \ ]
let g:startify_bookmarks = [
	\ { 'a': '~/.config/nvim/init.vim' } ,
	\ { 's': '~/.config/zsh/.zshrc' },
	\ { 'd': '~/.config/alacritty/alacritty.yml' },
	\ { 'f': '~/.config/X11/Xresources' },
	\ { 'g': '~/.config/fish/config.fish' },
	\ ]
