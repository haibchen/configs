set nocompatible
syntax enable

set shell=/bin/bash

"******************** setting up vundle *********************************
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif
call vundle#end()

filetype plugin on
filetype plugin indent on
"******************** setting up vundle *********************************



set noswapfile                     " turn off swap files"

set autoread                       " reload files when changed on disk
set backspace=2                    " Fix broken backspace in some setups
set backupcopy=yes                 " see :help crontab
set clipboard=unnamed              " yank and paste with the system clipboard
set directory-=.                   " don't store swapfiles in current directory
set encoding=utf-8
set paste

set expandtab                      " expand tabs to spaces
set hlsearch
set incsearch                      " search as you type
set laststatus=2                   " always show statusline
set nocursorline
set list                           " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                         " show line numbers
set ruler                          " show where you are
set nowrap                         " Disable line wrap-up
set scrolloff=3                    " show context above/below cursorline
set shiftwidth=4                   " normal mode indentation use 2 spaces
set showcmd
set noshowmode
set visualbell
set smartcase                      " case-sensitive search if any caps
set softtabstop=4                  " insert mode tab and backspace use 2 spaces
set tabstop=4                      " actual tabs occupy 8 characters
set wildmenu                       " show a navigable menu for tab completion
set wildmode=longest,list,full
set tags=./tags,tags;$HOME
set lazyredraw

set nostartofline                  " Don't reset cursor to start of line
set cursorline                     " hight current line

set showmatch                      " Show matching brackets"
set relativenumber

"************************ Set options available in GUI mode *************
if has("gui_running")
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif
"************************ Set options available in GUI mode *************





set foldmethod=indent
set foldmethod=syntax
set nofoldenable

set tabstop=4
set expandtab
set shiftwidth=4





"************** setting up key mappings *********************************
let mapleader = ','

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" yank text from vim to system clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation when paste from the OSX clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>"
"************** setting up key mappings *********************************


" nerdtree settings
" close vim if the last open window is nerdtree 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>




"******************** setting up color scheme ***************************
syntax enable
set background=dark
"let g:solarized_visibility="high"
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_termcolors=16
colorscheme solarized
"call togglebg#map("<F5>")
"******************** setting up color scheme ***************************




"******************** tmux support on vim *******************************
" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
    set ttymouse=xterm2
endif"
"
" Fix Cursor in TMUX
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"******************** tmux support on vim *******************************




" Ignore compiled files
set wildignore=log/**,target/**,tmp/**,*DS_Store*,*.o,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif



" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Replace()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Replace()




" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <leader>y y:<C-U>call Yank(@0)<CR>
