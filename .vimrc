" === General Settings ===
set nocompatible            " Disable compatibility with legacy Vi
filetype plugin indent on   " Enable filetype detection, plugins, and indentation
syntax on                   " Enable syntax highlighting
set encoding=utf-8          " Set encoding to UTF-8
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set cursorline              " Highlight the current line
set tabstop=4               " Number of spaces a tab counts for
set shiftwidth=4            " Number of spaces for autoindent
set expandtab               " Use spaces instead of tabs
set autoindent              " Autoindent new lines
set smartindent             " Smart autoindenting
set nowrap                  " Disable line wrapping
set hlsearch                " Highlight search results
set incsearch               " Incremental search (search as you type)
set ignorecase              " Ignore case in searches
set smartcase               " Case-sensitive search if uppercase is used
set mouse=a                 " Enable mouse support
set clipboard=unnamedplus   " Use system clipboard for yanking and pasting
set backspace=indent,eol,start " Make backspace work like most other apps
set splitbelow              " Open new splits below
set splitright              " Open new splits to the right
set hidden                  " Allow switching buffers without saving
set updatetime=300          " Faster completion and better UX for plugins
set termguicolors           " Enable true color support

" === Keybindings ===
let mapleader = ","         " Set leader key to comma

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlights
nnoremap <leader>h :nohlsearch<CR>

" Save and quit shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" === Plugin Management (Using vim-plug) ===
" Install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Essential Plugins
Plug 'tpope/vim-sensible'           " Sensible defaults
Plug 'tpope/vim-commentary'         " Easy commenting (gc to comment lines)
Plug 'tpope/vim-surround'           " Easily change surroundings (quotes, brackets, etc.)
Plug 'jiangmiao/auto-pairs'         " Automatically close brackets, quotes, etc.
Plug 'preservim/nerdtree'           " File explorer
Plug 'vim-airline/vim-airline'      " Status bar
Plug 'vim-airline/vim-airline-themes' " Themes for airline
Plug 'airblade/vim-gitgutter'       " Git diff in the gutter
Plug 'sheerun/vim-polyglot'         " Better syntax highlighting for many languages
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine (LSP support)
Plug 'rust-lang/rust.vim'           " Rust language: :RustFmt, :Cargo, format-on-save

" Colorschemes
Plug 'morhetz/gruvbox'              " Gruvbox theme
Plug 'joshdick/onedark.vim'         " One Dark theme
Plug 'sainnhe/sonokai'              " Sonokai theme

call plug#end()

" === Plugin Settings ===
" NERDTree settings
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1             " Show hidden files

" Airline settings
let g:airline#extensions#tabline#enabled = 1 " Enable tabline
let g:airline_theme = 'sonokai'      " Set theme

" CoC (Intellisense) settings
" Auto-install these CoC extensions on first launch
let g:coc_global_extensions = ['coc-rust-analyzer', 'coc-json']

" Goto navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Diagnostics: jump to prev/next error
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Show docs / type info under cursor (Rust: hover types, see signatures)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Refactor / fix
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>f  <Plug>(coc-format)

" Completion: Tab / Shift-Tab to navigate, Enter to confirm
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ "\<Tab>"
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" === Rust ===
let g:rustfmt_autosave = 1          " Auto-run rustfmt on save

" Gruvbox colorscheme settings
colorscheme gruvbox
set background=dark                  " Use dark mode

" === Custom Commands ===
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
