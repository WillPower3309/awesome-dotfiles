""""""""""""""""""""""""""""""""""
"   Usability
""""""""""""""""""""""""""""""""""


set expandtab
set smarttab
set shiftwidth=4
set tabstop=4


""""""""""""""""""""""""""""""""""
"   Interface
""""""""""""""""""""""""""""""""""


set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave    * set relativenumber
    autocmd BufEnter,FocusLost,InsertEnter      * set norelativenumber
augroup end


""""""""""""""""""""""""""""""""""
"   Plugins
""""""""""""""""""""""""""""""""""


call plug#begin()
Plug 'ayu-theme/ayu-vim'
call plug#end()


set termguicolors
let ayucolor="mirage"
colorscheme ayu
