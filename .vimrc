set nocompatible
" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'

call vundle#end()
filetype plugin indent on

" General Options
let mapleader = ","
syntax on
set nu
set rnu
set tabstop=4
set shiftwidth=4
set expandtab

" Status Line
set statusline=buffer=%n\ 
set statusline+=%f
set statusline+=%=
set statusline+=%l
set statusline+=/
set statusline+=%L

" Mappings
nnoremap <space> :
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" NerdTree
nnoremap <F2> :NERDTreeToggle<cr>


"Autocmds
augroup cmds
    au!
    au FileType python :nnoremap <F9> :w<cr>:!python3 "%"<cr>
    au FileType python :nnoremap <F10> :w<cr>:!python3 -m pdb "%"<cr>
    " Yaml
    au FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
augroup end

" Vimscript file settings ----------------------- {{{
augroup vim_settings
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" }}}
