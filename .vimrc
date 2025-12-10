set nocompatible
" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'

Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'

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
set statusline=buffer=%n\  " %n=buffer number
set statusline+=%f  " Path to file
set statusline+=%=  " Right Aling the next section
set statusline+=%l  " Line Number
set statusline+=/   " Seperator
set statusline+=%L  " Total Lines

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

" Vimscript file settings 
" ------------------------ {{{{
augroup vim_settings
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Python LSP with vim-lsp
" -------------- {{{
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect

autocmd FileType python setlocal omnifunc=lsp#complete


" }}}

