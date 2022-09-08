set number " numbered lines
set mouse=a " mouse support
set cmdheight=1 " smaller space bellow ligthline, coc recommends 2, 1 is for minimalism and that I don't need it
set noea " doesn't shift all splits/windows when a new window/split is created/removed
set foldcolumn=0 " set it to 1 or more to see fold/unfold buttons like vscode, needs better plugin

set tabstop=4 shiftwidth=4 expandtab
set cursorline
set smartcase
set ignorecase
set scrolloff=6

call plug#begin('~/.vim/plugged')

    Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc? ,':|
    Plug 'tpope/vim-eunuch' " UNIX shell commands :Remove :Move :Chmod ...
    Plug 'joshdick/onedark.vim' " theme
    Plug 'airblade/vim-gitgutter' " see which lines are added/modified etc.
    Plug 'tpope/vim-surround' " surround, alternative nvim surround
    Plug 'tpope/vim-commentary' " comment out stuff `gcc` line, `gc{motion}` (`gcap` - paragraph)
    Plug 'honza/vim-snippets' " collection of a lot of useful snippets
    Plug 'jiangmiao/auto-pairs' " annoying yet useful auto pairs
    Plug 'sheerun/vim-polyglot' " probably coc has it figured out, but just in case
    Plug 'preservim/nerdtree' " file explorer
    Plug 'vimwiki/vimwiki' " vimwiki :)
    Plug 'phaazon/hop.nvim' " hop to char/word etc, see keybinds
    Plug 'kassio/neoterm' " better terminal integration
    Plug 'folke/zen-mode.nvim' " zen-mode :)
    Plug 'norcalli/nvim-colorizer.lua' " the cool colorizer (testing)
    Plug 'mhinz/vim-startify' " simple startup screen
    Plug 'psliwka/vim-smoothie' " smooth scrolling
    Plug 'junegunn/vim-easy-align' " easy alignment `ga{motion}{patern}` - `gaip=` (or use visual)

    " markdown, probably should find something better / coc probably has it
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'

    " lsp stuff am scared to remove, needs testing
    Plug 'neovim/nvim-lspconfig' " Collection of common configurations for the Nvim LSP client
    Plug 'nvim-lua/lsp_extensions.nvim' " Extensions to built-in LSP, for example, providing type inlay hints
    Plug 'nvim-lua/completion-nvim' " Autocompletion framework for built-in LSP

    " telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    
    " lightline
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    "
    " not useful for me plugins:
    " Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }

call plug#end()

" makes sure to have 24bit color
if has("termguicolors")
        set termguicolors
endif

" needs to be looked into, looks bad, can be shortened
lua << EOF
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
EOF


" My stuff --------------------------------------------------------

command Config :vs ~/.config/nvim/init.vim
command ConfigReload :source ~/.config/nvim/init.vim

let mapleader = " "

" to quickly create new lines
nnoremap <C-j> o<Esc>k
nnoremap <C-k> O<Esc>

" needs to be redone
nnoremap <cr> <cmd>HopChar1MW<cr>
nnoremap <leader><cr> <cmd>HopWordMW<cr>

" enter zen-mode
nnoremap <leader>wf <cmd>ZenMode<cr>

" clear searched pattern
nnoremap <leader>wc <cmd>noh<cr>

" press esc to get out of the terminal and switch to your last window
:tnoremap <Esc> <C-\><C-n><C-w>w

" generate a new terminal window (TODO rework to make it spawn at the bottom)
nnoremap <F4> <cmd>sp<cr><cmd>Tnew<cr>

" system clipboard manipulation
nnoremap <leader>v "+p<cr>
nnoremap <leader>c "+y<cr>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" My stuff --------------------------------------------------------

" Lightline
let g:lightline = {
        \ 'component_function': {
        \   'filetype': 'MyFiletype',
        \   'fileformat': 'MyFileformat',
        \   'gitbranch': 'FugitiveHead'
        \ }, 
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'colorscheme': 'onedark', 
        \ 'tabline': {
        \   'left': [ ['buffers'] ],
        \   'right': [ ['close'] ]
        \ },
        \ 'component_expand': {
        \   'buffers': 'lightline#bufferline#buffers'
        \ },
        \ 'component_type': {
        \   'buffers': 'tabsel'
        \ },
  		\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
		\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
        \ }

" themes
syntax on
colorscheme onedark

" Easyalign

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Coc stuff --------------------------------------------------------
" Just copy-pasted stuff from documentation, read through for useful keybinds
" scared to edit this
" USEFUL: useful stuff will be highlighted as such
" TODO probably change how autocompletion keybinds work

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" USEFUL: <C-j> and <C-k> for completion navigation 
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" USEFUL: use Tab for snippet jumping
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'

" USEFUL: Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" USEFUL: Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" USEFUL: Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Show signature help on placeholder jump
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" USEFUL: Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" USEFUL: Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" USEFUL: Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Coc stuff  --------------------------------------------------------

" GUI stuff  --------------------------------------------------------

set guifont=FiraCode\ Nerd\ Font\ Mono:h12
set encoding=UTF-8
let g:neovide_cursor_vfx_mode = "torpedo"
let g:neovide_cursor_animation_length = 0.06
let g:neovide_cursor_trail_lenght = 0.6
let g:neovide_cursor_vgx_particle_density=10.0

" GUI stuff  --------------------------------------------------------
