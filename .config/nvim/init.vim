" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Initialize plugin system
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim' "
Plug 'tpope/vim-commentary' "gcc - comment a line - gc comment selection in visualmode
Plug 'terryma/vim-expand-region' "+ expand _ shrink
Plug 'chr4/nginx.vim'
call plug#end()
"don't show insert mode on status bar
set noshowmode
" show lines numbers
set nu!
" change tabs for spaces
set expandtab
" new lines keeps last level of indentation
set autoindent
" adds new indentation based on context
set smartindent
" tabs width
set shiftwidth=2
set softtabstop=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
