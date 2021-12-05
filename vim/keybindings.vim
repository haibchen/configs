"neovim keybindings


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
