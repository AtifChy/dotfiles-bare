-- Default
-- local pairs_map = {
--     ["'"] = "'",
--     ['"'] = '"',
--     ['('] = ')',
--     ['['] = ']',
--     ['{'] = '}',
--     ['`'] = '`',
-- }
-- local disable_filetype = { "TelescopePrompt" }
-- local break_line_filetype = nil -- mean all file type
-- local html_break_line_filetype = {'html' , 'vue' , 'typescriptreact' , 'svelte' , 'javascriptreact'}
-- local ignored_next_char = "%w"
-- Example
-- require('nvim-autopairs').setup({
--   disable_filetype = { "TelescopePrompt" , "vim" },
-- })
local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

npairs.setup(
    {
        check_ts = true,
        ts_config = {
            lua = {"string"},
             -- it will not add pair on that treesitter node
            javascript = {"template_string"},
            java = false
         -- don't check treesitter on java
        }
    }
)

-- require("nvim-treesitter.configs").setup {
--     autopairs = {enable = true}
-- }

local ts_conds = require("nvim-autopairs.ts-conds")

-- press % => %% is only inside comment or string
npairs.add_rules(
    {
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({"string", "comment"})),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({"function"}))
    }
)
