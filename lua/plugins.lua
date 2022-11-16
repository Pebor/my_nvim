local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use 'wbthomason/packer.nvim' -- Packer can manage itself
	-- use {'neoclide/coc.nvim', branch = 'release'} -- coc? ,':|
	use 'tpope/vim-eunuch' -- UNIX shell commands :Remove :Move :Chmod ...
	use 'airblade/vim-gitgutter' -- See which lines are added/modified etc.
	use 'tpope/vim-surround' -- Surround, alternative nvim surround 'ds{' (delete surrounding {})
	use 'tpope/vim-commentary' -- Comment out stuff `gcc` line, `gc{motion}` (`gcap` - paragraph)
	use 'jiangmiao/auto-pairs' -- Annoying yet useful auto pairs
	use 'vimwiki/vimwiki' -- vimwiki :)
	use 'kassio/neoterm' -- better terminal integration
	use 'mhinz/vim-startify' -- simple startup screen
	use 'psliwka/vim-smoothie' -- smooth scrolling
	use 'junegunn/vim-easy-align' -- easy alignment `ga{motion}{patern}` - `gaip=` (or use visual)
	use 'kyazdani42/nvim-web-devicons'
	use {'dstein64/vim-startuptime',
		cmd = 'StartupTime'
	}
    use {'folke/which-key.nvim',
        config = function() require("which-key").setup {} end
    }

	-- LSP
	use	{'williamboman/mason.nvim',
		config = function() require("mason").setup() end
	}
	use	'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
	use 'mfussenegger/nvim-dap'

	-- Autocompletion
	use	'hrsh7th/cmp-nvim-lsp'
	use	'hrsh7th/cmp-nvim-lua'

	use 'L3MON4D3/LuaSnip'
	-- use	{'saadparwaiz1/cmp_luasnip'}
	use 'rafamadriz/friendly-snippets'

	use	'hrsh7th/cmp-buffer'
	use	'hrsh7th/cmp-path'
	use	{'hrsh7th/nvim-cmp',
		config = function() require("plugins.cmp") end
	}
	
	use 'simrat39/rust-tools.nvim'

	use {'nvim-treesitter/nvim-treesitter',
		run = require('nvim-treesitter.install').update({ with_sync = true }),
		config = function() require('nvim-treesitter').setup() end
	}

    use {'lukas-reineke/indent-blankline.nvim',
		config = function() require('indent_blankline').setup {} end
	}

    -- use {'lewis6991/impatient.nvim',
		-- config = require('impatient').enable_profile()
	-- }

	use {'b0o/incline.nvim',
		config = function() require('incline').setup {} end
	}

	use 'rcarriga/nvim-notify'
	-- Theme
	use 'joshdick/onedark.vim'

	-- Hop to char/word etc, see keybinds
	use {'phaazon/hop.nvim',
		config = function() require('hop').setup {} end
	}

	-- Zen-mode
	use {'folke/zen-mode.nvim',
		config = function() require('zen-mode').setup {} end
	}

	-- the cool colorizer (testing)
	use {'norcalli/nvim-colorizer.lua',
		config = function() require('colorizer').setup {} end
	}

	-- markdown, probably should find something better / coc probably has it
	use 'plasticboy/vim-markdown'
    use 'godlygeek/tabular'

	-- telescope
	use {'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim'}
	}
	-- better fold smth (folds are weird)
	use {'kevinhwang91/nvim-ufo',
		requires = 'kevinhwang91/promise-async',
		config = function() require('ufo').setup {} end
	}

	-- Statusline
	use {'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function() require('lualine').setup {} end
	}
	-- File explorer
	use {'kyazdani42/nvim-tree.lua',
	  requires = { 'kyazdani42/nvim-web-devicons' },
	  config = function() require('nvim-tree').setup {} end,
	  cmd = {'NvimTreeOpen', 'NvimTreeToggle', 'NvimTreeFindFile', 'NvimTreeFindFileToggle'}
	}

	use {'stevearc/dressing.nvim',
		config = function() require('dressing').setup {} end
	}

	-- use({
	--   "folke/noice.nvim",
	--   event = "VimEnter",
	--   config = function()
	-- 	  require("noice").setup({
	-- 			  cmdline = {
	-- 				  view = "cmdline"
	-- 			  }
	-- 		  })
	--   end,
	--   requires = {
	-- 	-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 	"MunifTanjim/nui.nvim",
	-- 	"rcarriga/nvim-notify",
	-- 	}
	-- })

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)

