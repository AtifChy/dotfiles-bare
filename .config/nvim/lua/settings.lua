local opt = vim.opt

local function list(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({value, str}, sep) or value
end

opt.fileencoding = "UTF-8"
opt.autoindent = true
-- opt.shiftwidth = 4
-- opt.tabstop = 4
opt.expandtab = true
opt.splitbelow = true
opt.splitright = true
opt.mouse = "a"
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.clipboard = "unnamedplus"
opt.inccommand = "nosplit"
opt.updatetime = 250
opt.termguicolors = true
opt.backspace = list {"indent", "eol", "start"}
opt.title = true
opt.number = true
opt.cursorline = true
opt.cursorcolumn = true
opt.swapfile = true
opt.list = true
opt.listchars = list {
  "tab: ──",
  -- "space:·",
  "nbsp:␣",
  "trail:•",
  "eol:↵",
  "precedes:«",
  "extends:»"
}
opt.showbreak = "⤷ "

vim.go.t_Co = "256"

-- colorscheme
vim.cmd("colorscheme one-nvim")
-- local base16 = require "base16"
-- base16(base16.themes["onedark"], true)
-- require('custom_highlights')

-- vim.g.one_nvim_transparent_bg = false

-- indent
vim.g.indent_blankline_char = "│"
-- vim.g.indent_blankline_char_list = {'▏', '┆', '┊'}
-- vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {
    "help",
    "startify",
    "packer"
}
vim.g.indent_blackline_buftype_exclude = {
    "terminal",
    "nofile"
}
vim.g.indent_blackline_char_highlight = "LineNr"

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {silent = true}

map("n", "<C-x>", [[<Cmd> split term://$SHELL | resize 16 <CR>]], opt) -- bottom
map("n", "<C-l>", [[<Cmd> vnew term://$SHELL <CR>]], opt) -- over right

local cmd = vim.cmd
-- terminal settings
cmd([[
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber
tnoremap <Esc> <C-\><C-n>
]])

-- autocmd commands
cmd(
    [[
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePost ~/.config/x11/Xresources,~/.config/x11/Xdefaults !xrdb -merge %
]]
)

-- auto neoformat
-- cmd([[
-- augroup fmt
--   autocmd!
--   autocmd BufWritePre * undojoin | Neoformat
-- augroup END
-- ]])
