local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

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

require "packer".init(
    {
        git = {
            clone_timeout = 600
        },
        display = {
            open_fn = function()
                return require("packer.util").float({border = "single"})
            end
        }
    }
)

local use = require("packer").use
require("packer").startup(
    function()
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter"
        }

        -- color
        use {
            "AtifChy/nvim-base16.lua",
            after = "packer.nvim",
            config = function()
                require "theme"
            end
        }

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("plugins.utils").colorizer()
            end
        }

        -- lsp
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require("plugins.treesitter")
            end
        }

        use {
            "kabouzeid/nvim-lspinstall",
            event = "BufRead"
        }

        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function()
                require("plugins.lspconfig")
            end
        }

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("plugins.utils").lspkind()
            end
        }

        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("plugins.compe")
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    event = "InsertCharPre",
                    config = function()
                        require("plugins.luasnip")
                    end
                }
            }
        }

        -- file manager
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require("plugins.nvimtree")
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            after = "nvim-base16.lua"
        }

        -- utils
        use {
		"sbdchd/neoformat",
		cmd = "Neoformat",
		config = function()
			require("plugins.utils").neoformat()
		end
	}

        use {"andymass/vim-matchup", event = "CursorMoved"}

        use {
            "windwp/nvim-autopairs",
            after = "nvim-compe",
            config = function()
                require("plugins.autopairs")
            end
        }

        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function()
                require("plugins.utils").blankline()
            end
        }

        use {"nvim-lua/plenary.nvim", event = "BufRead"}

        use {
            "lewis6991/gitsigns.nvim",
            after = "plenary.nvim",
            config = function()
                require("plugins.utils").gitsigns()
            end
        }

        -- extra
        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}
    end
)
