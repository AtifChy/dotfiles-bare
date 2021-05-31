local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
    execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- require('packer').init({display = {non_interactive = true}})
require('packer').init({display = {auto_clean = false}})

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'

    -- autocompletion
    use {'hrsh7th/nvim-compe', requires = {'hrsh7th/vim-vsnip'}}

    -- markdown preview
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

    -- formatting
    use 'sbdchd/neoformat'

    -- git
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- ui
    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        config = function() require 'my_statusline' end,
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'mhinz/vim-startify'
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

    -- colorscheme
    -- use 'AtifChy/onedark.vim'
    use 'AtifChy/one-nvim'

    -- utils
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    use 'norcalli/nvim-colorizer.lua'
    use {
        'windwp/nvim-autopairs',
        require = {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
end)
