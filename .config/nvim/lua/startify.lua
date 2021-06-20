-- startify fancy header
vim.g.startify_custom_header = {
    "   ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗ ",
    "   ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║ ",
    "   ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║ ",
    "   ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║ ",
    "   ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║ ",
    "   ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝ "
}

-- number of files to be shown for each list
vim.g.startify_files_number = 8

-- various list order
vim.g.startify_lists = {
    {type = "sessions", header = {"   Sessions"}},
    {type = "dir", header = {"   Current Directory " .. vim.fn.getcwd()}},
    {type = "files", header = {"   Recent"}},
    {type = "bookmarks", header = {"   Bookmarks"}},
    {type = "commands", header = {"   Commands"}}
}

-- bookmarks
vim.g.startify_bookmarks = {
    {a = "~/.config/nvim/init.lua"},
    {s = "~/.config/zsh/zshrc"},
    {d = "~/.config/xmonad/xmonad.hs"},
    {f = "~/.config/xmonad/xmobar/xmobarrc"},
    {h = "~/.config/x11/Xresources"}
}

-- shortcut for commands
vim.g.startify_commands = {{pu = "PackerUpdate"}, {ps = "PackerSync"}}

-- fix startify web icons
function _G.webDevIcons(path)
    local filename = vim.fn.fnamemodify(path, ":t")
    local extension = vim.fn.fnamemodify(path, ":e")
    return require "nvim-web-devicons".get_icon(filename, extension, {default = true})
end

vim.cmd(
    [[
function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
]]
)
