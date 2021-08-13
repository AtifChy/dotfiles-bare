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
-- opt.shiftwidth = 4

-- disable nvim intro
opt.shortmess:append("sI")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

g.mapleader = " "
g.auto_save = false

-- disable builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end


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
