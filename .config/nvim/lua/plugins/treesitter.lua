local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

ts_config.setup(
    {
        ensure_installed = {
            "bash",
            "lua",
            "haskell",
	    "jsonc",
            "toml"
        },
        highlight = {
            enable = true,
            use_languagetree = true
        }
    }
)
