if empty(glob('~/.config/nvim/autoload/plug.vim'))
	echo "Installing Plug..."
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

set nocompatible

call plug#begin()

" UI:
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
" Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

" Git:
" Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Other:
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'

" Langs:
Plug 'ap/vim-css-color'

" LaTeX
" Plug 'lervag/vimtex'

call plug#end()

nnoremap c "_c
let mapleader=","
filetype plugin on
syntax on

set laststatus=2
set encoding=utf-8
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
" set number relativenumber
set conceallevel=0
set foldmethod=syntax
set nofoldenable
set nowrap
set magic
set laststatus=0 ruler
set scrolloff=4

set ttyfast
set lazyredraw

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev W w
cnoreabbrev Q q

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

command! FixWhitespace :%s/\s\+$//e

noremap <Leader>g :Goyo<CR>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

"" Close buffer
noremap <leader>s :bd<CR>

"" Switching windows
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l
noremap <leader>h <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Terminal
" Change <C-\><C-n> to something better.
tnoremap <Esc> <C-\><C-n>

"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!

autocmd FileType go set noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

au BufNewFile,BufRead /dev/shm/gopass.*,/dev/shm/pass.?*/?*.txt,$TMPDIR/pass.?*/?*.txt,/tmp/pass.?*/?*.txt setlocal nobackup nowritebackup noswapfile noundofile

" Treat *.md as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType markdown setlocal spell expandtab tabstop=2 shiftwidth=2 textwidth=80 conceallevel=0
autocmd FileType xml setlocal expandtab tabstop=2 shiftwidth=2
