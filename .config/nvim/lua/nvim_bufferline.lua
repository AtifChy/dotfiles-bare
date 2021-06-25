require("bufferline").setup {
    options = {
        numbers = "none",
        -- number_style = "superscript" | "" | {"none", "subscript"}, -- buffer_id at index 1, ordinal at index 2
        mappings = true,
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        indicator_icon = "▎",
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = " ",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 20,
        diagnostics = false, -- "nvim_lsp",
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --     return "(" .. count .. ")"
        -- end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                return true
            end
            -- filter out by buffer name
            if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                return true
            end
            -- filter out based on arbitrary rules
            -- e.g. filter out vim wiki buffer from tabline in your work repo
            if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                return true
            end
        end,
        -- offsets = {
        --     {
        --         filetype = "NvimTree",
        --         text = "File Explorer",
        --         text_align = "center"
        --     }
        -- },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "extension"
    },
    highlights = {
        fill = {
            guibg = "#1e2127"
        },
        background = {
            guibg = "#282c34"
        },
        tab_selected = {
            guibg = "#282c34"
        },
        tab_close = {
            guifg = "#df6c74",
            guibg = "#1e2127"
        },
        close_button_selected = {
            guibg = "#282c34"
        },
        buffer_selected = {
            guibg = "#282c34",
            gui = "bold"
        },
        modified_selected = {
            guibg = "#282c34"
        },
        duplicate_selected = {
            guibg = "#282c34"
        },
        separator_selected = {
            guibg = "#282c34"
        },
        indicator_selected = {
            guibg = "#282c34"
        }
    }
}

local opt = {silent = true}
local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- MAPPINGS
map("n", "<S-t>", [[<Cmd>tabnew<CR>]], opt) -- new tab
map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt) -- close tab

-- move between tabs
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
