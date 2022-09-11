local settings = {
    number = true, -- Numbered lines
    mouse = "a", -- Mouse support
    cmdheight = 1, -- Smaller space bellow statusline, coc recommends 2, 1 is for minimalism and the fact I don't need it
    ea = false, -- Doesn't shift all splits/windows when a new window/split si created/removed
    foldcolumn = '0', -- Set to 1 or more to see fold/unfold buttons + visual folds
    clipboard = "unnamedplus", -- Use System clipboard
    termguicolors = true, -- 24bit color support
    autochdir = true,
    laststatus = 3,

    -- Tab settings
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smarttab = true,

    -- Folds
    foldlevel = 99,
    foldlevelstart = 99,
    foldenable = true,

    -- Coc
    cursorline = true,
    smartcase = true,
    ignorecase = true,
    scrolloff = 6,

    hidden = true,

    backup = false,
    writebackup = false,

    updatetime = 300,

    signcolumn = "yes" -- Always show signcolumns
}

vim.cmd( "source ~/.config/nvim/lua/config/coc.vim" )

vim.opt.shortmess:append("c")

for k, v in pairs(settings) do
	vim.opt[k] = v
end

vim.notify = require('notify')

require('onedark').load()

vim.cmd[[
syntax on
"hi CocMenuSel guibg=SkyBlue3 guifg=DarkSlateGray 
]]
