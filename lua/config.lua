require'hop'.setup()
require("zen-mode").setup()
require'colorizer'.setup()

require('packer').startup(function(user)
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'} -- better fold smth (folds are weird)
    use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'} -- I don't know if I can safely get rid of plug coc yet
end)

-- TODO move this to vim for consistency
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Option 1: coc.nvim as LSP client
require('ufo').setup()
