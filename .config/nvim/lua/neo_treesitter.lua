require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "lua",
        "toml"
    },
    autopairs = {
        enable = true
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
