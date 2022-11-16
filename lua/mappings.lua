-- import our vim objects
local vim, api, fn, g = vim, vim.api, vim.fn, vim.g

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local function term()
    return [[:sp
    :Tnew
    <C-w>J
    :resize 10
    ]]
end

g.mapleader = " "

vim.api.nvim_create_user_command('Config', ':vs ~/.config/nvim/init.lua', {})
vim.api.nvim_create_user_command('ConfigReload', ':luafile ~/.config/nvim/init.lua', {})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

map('n', '<C-j>', 'o<Esc>k')
map('n', '<C-k>', 'O<Esc>')

map('n', '<cr>', ':HopChar1MW<CR>')
map('n', '<leader><cr>', ':HopWordMW<CR>')

map('n', '<leader>wf', ':ZenMode<CR>')

map('n', '<leader>wc', ':noh<CR>')

map('t', '<Esc>', '<C-\\><C-n><C-w>w')

map('n', '<F4>', term())

map('n', '<leader>e', ':lua vim.diagnostic.open_float(nil, {focus=false})')

map('n', '<leader>tn', '<cmd>tabnew<CR>')

map('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>')

map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
