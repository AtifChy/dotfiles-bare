local M = {}

M.colorizer = function()
    local present, colorizer = pcall(require, "colorizer")
    if present then
        colorizer.setup()
        vim.cmd("ColorizerReloadAllBuffers")
    end
end

M.lspkind = function()
    local present, lspkind = pcall(require, "lspkind")
    if present then
        lspkind.init()
    end
end

M.blankline = function()
    vim.g.indent_blankline_char = "│"
    -- vim.g.indent_blankline_char_list = {'▏', '┆', '┊'}
    -- vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_filetype_exclude = {
        "help",
        "startify",
        "packer",
	"lspinfo"
    }
    vim.g.indent_blackline_buftype_exclude = {
        "terminal",
        "nofile"
    }
end

M.gitsigns = function()
    local present, gitsigns = pcall(require, "gitsigns")
    if not present then
        return
    end

    gitsigns.setup(
        {
            signs = {
                add = {
                    hl = "DiffAdd",
                    text = "│"
                },
                change = {
                    hl = "DiffChange",
                    text = "│"
                },
                delete = {
                    hl = "DiffDelete",
                    text = "_"
                },
                topdelete = {
                    hl = "DiffDelete",
                    text = "‾"
                },
                changedelete = {
                    hl = "DiffChange",
                    text = "~"
                }
            },
            numhl = false,
            keymaps = {
                -- Default keymap options
                noremap = true,
                buffer = true,
                ["n ]c"] = {
                    expr = true,
                    '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''
                },
                ["n [c"] = {
                    expr = true,
                    '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''
                },
                ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
            },
            watch_index = {
                interval = 100
            },
            sign_priority = 5,
            status_formatter = nil -- Use default
        }
    )
end

return M
