syntax enable

set encoding=utf8
set ffs=unix,dos,mac

"Tab Functionality
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set ai "auto indent
set si "smart indent
set wrap "wrap lines

set ruler

"Line Numbering
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave    * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter      * set norelativenumber
augroup end
