syntax on

set notermguicolors
set laststatus=0
silent! colorscheme vim

set ignorecase
set wildignorecase
set smartcase
set wildoptions=fuzzy,tagfile
set wildchar=<C-n>

set completeopt=fuzzy

set guicursor=

nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = " "

if has('nvim')
	source ~/.config/nvim/plugins.lua
endif
