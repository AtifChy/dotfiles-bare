"augrp fmt
"  autocmd!
"  autocmd BufWritePre * undojoin | Neoformat
"augroup END

autocmd BufWritePre * %s/\s\+$//e			" remove trailing whitespace on save
autocmd BufWritePost ~/.config/X11/Xresources,~/.config/X11/Xdefaults !xrdb -merge %
"autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
