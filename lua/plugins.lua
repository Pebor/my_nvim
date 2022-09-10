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
    use {'wbthomason/packer.nvim'} -- Packer can manage itself
    use {'neoclide/coc.nvim', branch = 'release'} -- coc? ,':|
    use {'tpope/vim-eunuch'} -- UNIX shell commands :Remove :Move :Chmod ...
    use {'airblade/vim-gitgutter'} -- See which lines are added/modified etc.
    use {'tpope/vim-surround'} -- Surround, alternative nvim surround
    use {'tpope/vim-commentary'} -- Comment out stuff `gcc` line, `gc{motion}` (`gcap` - paragraph)
    use {'honza/vim-snippets'} -- Collection of a lot of useful snippets
    use {'jiangmiao/auto-pairs'} -- Annoying yet useful auto pairs
    use {'sheerun/vim-polyglot'} -- Probably coc has it figured out, but just in case
	use {'vimwiki/vimwiki'} -- vimwiki :)
	use {'kassio/neoterm'} -- better terminal integration
    use {'mhinz/vim-startify'} -- simple startup screen
    use {'psliwka/vim-smoothie'} -- smooth scrolling
    use {'junegunn/vim-easy-align'} -- easy alignment `ga{motion}{patern}` - `gaip=` (or use visual)
    use {'kyazdani42/nvim-web-devicons'}
    use {'dstein64/vim-startuptime', cmd = 'StartupTime'}
	--
	-- Theme
    use {'navarasu/onedark.nvim'}

	-- Hop to char/word etc, see keybinds
	use {'phaazon/hop.nvim',
		config = function()
			require('hop').setup {}
		end
	}

	-- Zen-mode
    use {'folke/zen-mode.nvim',
		config = function()
		    require('zen-mode').setup {}
		end
	}

	-- the cool colorizer (testing)
    use {'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup {}
		end
	}

    -- markdown, probably should find something better / coc probably has it
    use {'godlygeek/tabular'}
    use {'plasticboy/vim-markdown'}

    -- telescope
    use {'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim'}
	}
	-- better fold smth (folds are weird)
    use {'kevinhwang91/nvim-ufo',
		requires = 'kevinhwang91/promise-async',
		config = function()
			require('ufo').setup {}
		end
	}

	-- Statusline
	use { 'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('config.lualine')
		end
	}
	-- File explorer
	use {
	  'kyazdani42/nvim-tree.lua',
	  requires = { 'kyazdani42/nvim-web-devicons' },
	  config = function()
		  require('nvim-tree').setup {}
	  end
	}

	use {'stevearc/dressing.nvim',
		config = function()
			require('dressing').setup {}
		end
	}

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)

