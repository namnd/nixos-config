require('settings')
require('plugins')

vim.cmd('colorscheme PaperColor')

require('setup')
require('bindings')

vim.cmd [[
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup
set hidden
set foldexpr=nvim_treesitter#foldexpr()
set wildmode=longest:full,full

let g:dirvish_mode = ':sort ,^.*[\/],'
let g:test#javascript#runner = 'jest'
let test#strategy = 'neovim'
let g:preview_markdown_parser = 'glow'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = {'down': '~40%'}
let g:fzf_preview_window = []
let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1
let g:fzf_checkout_git_options = '--sort=-committerdate'

imap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
]]
