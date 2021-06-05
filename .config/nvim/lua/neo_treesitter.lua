require("nvim-treesitter.configs").setup {
    ensure_installed = {"bash", "lua", "toml"},
    highlight = {enable = true, use_languagetree = true}
}
