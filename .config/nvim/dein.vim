"dein Scripts-----------------------------

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/atif/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/atif/.cache/dein')
  call dein#begin('/home/atif/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/atif/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  call dein#add('tpope/vim-fugitive')
  call dein#add('vim-airline/vim-airline')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('mhinz/vim-startify')
  call dein#add('neoclide/coc.nvim', {'branch': 'release'})
  call dein#add('AtifChy/onedark.vim')
  call dein#add('ap/vim-css-color')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
