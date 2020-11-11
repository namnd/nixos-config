syntax on

set report=0
set clipboard=unnamed
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set cursorline
set mouse=
set ttymouse=

set backspace=indent,eol,start
set foldmethod=indent
set nofoldenable

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim'
Plug 'kshenoy/vim-signature'
Plug 'preservim/nerdtree'
Plug 'alvan/vim-closetag'

call plug#end()

" gruvbox
colorscheme gruvbox
set background=dark

set laststatus=2
set statusline=%F                       " full path to file in the buffer
set statusline+=\ (%n)                  " buffer number
set statusline+=\ %m                    " modified flag in square brackets
set statusline+=%r                      " readonly flag in square brackets
set statusline+=%{FugitiveStatusline()}
set statusline+=%=                      " left/right separator
set statusline+=%h                      " help flag in square brackets
set statusline+=%w
set statusline+=%y                      " syntax in square brackets
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&ff}]              " file format
set statusline+=\ %p%%                  " cursor line/total lines
set statusline+=\ %l                    " cursor lines
set statusline+=:%c                     " cursor column


set splitbelow splitright
nmap <silent> zs :wincmd s<cr>
nmap <silent> zv :wincmd v<cr>
nmap <silent> zx :wincmd x<cr>
nmap <silent> zo :wincmd o<cr>

nmap <silent> zh :wincmd h<cr>
nmap <silent> zj :wincmd j<cr>
nmap <silent> zl :wincmd l<cr>
nmap <silent> zk :wincmd k<cr>

let mapleader=" "

nnoremap <leader>ve :e $MYVIMRC<cr>
nnoremap <leader>vr :source $MYVIMRC<cr>
nnoremap <leader>u :UndotreeToggle<cr>

" fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS='--reverse'
nmap <C-p> :Files<cr>
nmap <C-e> :History<cr>
nmap <C-f> :Rg<cr>
nmap <C-b> :Buffers<cr>


" fzf checkout
nnoremap <leader>gc :GCheckout<cr>

" git
nmap <leader>gh :diffget //3<cr>
nmap <leader>gf :diffget //2<cr>

" coc
set hidden
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)

" NERDTree
let NERDTreeShowHidden=1
nmap <C-n> :NERDTreeToggle<cr>
nmap <C-m> :NERDTreeFind<cr>

" closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
inoremap {<Enter> {<cr>}<C-c>O
