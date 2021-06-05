require("lspkind").init(
    {
        -- enables text annotations
        --
        -- default: true
        with_text = true,
        -- default symbol map
        -- can be either 'default' or
        -- 'codicons' for codicon preset (requires vscode-codicons font installed)
        --
        -- default: 'default'
        preset = "codicons",
        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
            Text = "",
            Method = "{}",
            Function = "",
            Constructor = "",
            Variable = "",
            Class = "",
            Interface = "ﰮ",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "練",
            Keyword = "",
            Snippet = "﬌",
            Color = "",
            File = "",
            Folder = "",
            EnumMember = "",
            Constant = "ﲀ",
            Struct = "ﳤ",
            Field = "ﴲ"
        }
    }
)
