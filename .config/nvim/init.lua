require('plugins')
require('settings')
require('nvim_tree')
require('nvim_autopair')
require('nvim_bufferline')
require('nvim_colorizer')
-- require('nvim_galaxyline')
require('servers')
require('nvim_compe')
require('neo_gitsigns')
require('neo_format')
require('startify')
require('statusline')
require('file_icons')
require('neo_lspconfig')
require('neo_lspkind')

-- local cmd = vim.cmd
-- cmd('source ~/.config/nvim/vimscript/lsp-config.vim')

vim.api.nvim_set_keymap('n', '<C-m>', ':MarkdownPreviewToggle<CR>',
                        {noremap = true})
