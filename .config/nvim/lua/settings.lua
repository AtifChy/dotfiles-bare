local opt = vim.opt
local g = vim.g

opt.fileencoding = "UTF-8"
opt.autoindent = true
opt.splitbelow = true
opt.splitright = true
opt.mouse = "a"
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.clipboard = "unnamedplus"
opt.inccommand = "nosplit"
opt.updatetime = 250
opt.timeoutlen = 400
opt.termguicolors = true
opt.title = true
opt.number = true
opt.cursorline = true
opt.cursorcolumn = true

-- disable nvim intro
opt.shortmess:append("sI")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

g.mapleader = " "
g.auto_save = false

-- disable builtin vim plugins
g.loaded_gzip = 0
g.loaded_tar = 0
g.loaded_tarPlugin = 0
g.loaded_zipPlugin = 0
g.loaded_2html_plugin = 0
g.loaded_netrw = 0
g.loaded_netrwPlugin = 0
g.loaded_matchit = 0
g.loaded_matchparen = 0
g.loaded_spec = 0

local cmd = vim.cmd

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
cmd([[let &fcs='eob: ']])

-- terminal settings
cmd([[
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber
tnoremap <Esc> <C-\><C-n>
]])

-- autocmd commands
cmd([[
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePost ~/.config/x11/Xresources,~/.config/x11/Xdefaults !xrdb -merge %
]])
