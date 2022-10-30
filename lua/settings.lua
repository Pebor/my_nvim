local settings = {
    number = true, -- Numbered lines
    mouse = "nvi", -- Mouse support
    cmdheight = 0, -- Smaller space bellow statusline, coc recommends 2, 1 is for minimalism and the fact I don't need it
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

-- vim.cmd( "source ~/.config/nvim/lua/config/coc.vim" )

vim.opt.shortmess:append("c")

for k, v in pairs(settings) do
	vim.opt[k] = v
end

vim.notify = require('notify')

require('mason.settings').set({
  ui = {
    border = 'rounded'
  }
})

local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

local rt = require("rust-tools")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_attach = function(client, buf)
	-- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, "n", <lhs>, <rhs>, { desc = <desc> })
	-- or a plugin like which-key.nvim
	-- <lhs>        <rhs>                        <desc>
	-- "K"          vim.lsp.buf.hover            "Hover Info"
	-- "<leader>qf" vim.diagnostic.setqflist     "Quickfix Diagnostics"
	-- "[d"         vim.diagnostic.goto_prev     "Previous Diagnostic"
	-- "]d"         vim.diagnostic.goto_next     "Next Diagnostic"
	-- "<leader>e"  vim.diagnostic.open_float    "Explain Diagnostic"
	-- "<leader>ca" vim.lsp.buf.code_action      "Code Action"
	-- "<leader>cr" vim.lsp.buf.rename           "Rename Symbol"
	-- "<leader>fs" vim.lsp.buf.document_symbol  "Document Symbols"
	-- "<leader>fS" vim.lsp.buf.workspace_symbol "Workspace Symbols"
	-- "<leader>gq" vim.lsp.buf.formatting_sync  "Format File"

	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
    -- Hover actions
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    -- Code action groups
    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
end

rt.setup({
  server = {
    capabilities = capabilities,
    on_attach = lsp_attach,
  },
})

local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

-- require('onedark').load()

vim.cmd[[
syntax on
colorscheme onedark
"hi CocMenuSel guibg=SkyBlue3 guifg=DarkSlateGray
hi CocInlayHint guifg=#307CBB
]]
