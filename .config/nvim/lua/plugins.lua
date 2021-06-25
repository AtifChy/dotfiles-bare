local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system(
        {
            "git",
            "clone",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )
    execute "packadd packer.nvim"
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

require("packer").init(
    {
        git = {clone_timeout = 120},
        display = {
            open_fn = function()
                return require("packer.util").float({border = "single"})
            end
        }
    }
)

return require("packer").startup(
    function(use)
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- lsp
        use "neovim/nvim-lspconfig"

        -- autocompletion
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("nvim_compe").config()
            end,
            requires = {
                {
                    "hrsh7th/vim-vsnip",
                    event = "InsertCharPre"
                },
                {
                    "onsails/lspkind-nvim",
                    event = "BufRead",
                    config = function()
                        require("neo_lspkind").config()
                    end
                }
            }
        }

        -- markdown preview
        use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}

        -- formatting
        use "sbdchd/neoformat"

        -- git
        use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}}

        -- ui
        use {
            "akinsho/nvim-bufferline.lua",
            requires = "kyazdani42/nvim-web-devicons"
        }
        use {
            "glepnir/galaxyline.nvim",
            branch = "main",
            requires = "kyazdani42/nvim-web-devicons"
        }
        use "mhinz/vim-startify"
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}

        -- colorscheme
        use "AtifChy/one-nvim"
        -- use 'norcalli/nvim-base16.lua'

        -- utils
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons"
        }
        use "norcalli/nvim-colorizer.lua"
        use "windwp/nvim-autopairs"
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }
        use "tweekmonster/startuptime.vim"
        -- use {
        --     'nvim-telescope/telescope.nvim',
        --     requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        -- }
        -- use {
        --     'nvim-telescope/telescope-media-files.nvim',
        --     requires = 'nvim-telescope/telescope.nvim'
        -- }
    end
)
