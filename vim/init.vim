" neovim rc file


set nocompatible            " disable compatibility to old-time vi

set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set incsearch               " search as you type

set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " expand tabs to white space
set shiftwidth=4            " width for auto indents in normal mode
set autoindent              " indent a new line the same amount as the line just typed

set nowrap                  " disable line wrap-up
set cursorline              " hight current line
set nostartofline           " don't reset cursor to start of line
set ruler                   " show where you are

set number                  " show line numbers
set relativenumber          " show relative line number from current line
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allows auto-indenting depending on file type
syntax enable               " syntax highlighting

set noswapfile              " turn off swap files"
set autoread                " reload files when changed on disk
set backspace=2             " Fix broken backspace in some setups
set backupcopy=yes          " see :help crontab
set clipboard=unnamedplus   " yank and paste with the system clipboard
set directory-=.            " don't store swapfiles in current directory
set encoding=utf-8

set laststatus=2            " always show statusline
set list                    " show trailing whitespace
set scrolloff=3             " show context above/below cursorline
set ttyfast                 " Speed up scrolling in Vim
set smartcase               " case-sensitive search if any caps
set wildmenu                " show a navigable menu for tab completion
set tags=./tags,tags;$HOME
set lazyredraw
set showcmd
set noshowmode
set visualbell

set foldmethod=indent
set foldmethod=syntax
set nofoldenable
set termguicolors
set timeoutlen=500

" disable Python2 support
let g:loaded_python_provider = 0
" disable Ruby support
let g:loaded_ruby_provider = 0
" disable Perl support
let g:loaded_perl_provider = 0
" disable Node.js support
let g:loaded_node_provider = 0




call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'overcache/NeoSolarized'
    Plug 'itchyny/lightline.vim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'ojroques/vim-oscyank'
    Plug 'easymotion/vim-easymotion'
call plug#end()

let mapleader = ","

" copy to local clipboard if connectted remotely
vnoremap <leader>y :'<,'>OSCYank<cr>

set background=dark
let g:lightline = {'colorscheme': 'solarized',}
let g:neosolarized_vertSplitBgTrans = 1
