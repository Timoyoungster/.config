syntax on

set notermguicolors
set laststatus=0
silent! colorscheme phantom-shadow

set ignorecase
set wildignorecase
set smartcase
set wildoptions=fuzzy,tagfile
set wildchar=<C-n>

set colorcolumn=80

set completeopt=fuzzy

set guicursor=

nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = " "

nnoremap <leader>cd :Ex<cr>

if has('nvim')
	source ~/.config/nvim/plugins.lua
endif

" SECTION: errorformats for 

" Reset baseline
set errorformat=

" Python multi-line tracebacks
set errorformat+=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" JS/TS (tsc / eslint)
set errorformat+=%f\ %#(%l\\,%c):\ %trror\ %m
set errorformat+=%f\ %#(%l\\,%c):\ %tarning\ %m
set errorformat+=%f:%l:%c\ -\ %trror\ %m
set errorformat+=%f:%l:%c\ -\ %tarning\ %m
set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %m

" C/C++ (GCC/Clang)
set errorformat+=%f:%l:%c:\ %trror:\ %m
set errorformat+=%f:%l:%c:\ %tarning:\ %m

" Makefile (either include or ignore)
"set errorformat+=make:\ ***\ [%f:%l:\ %o]\ %m " include makefile errors
set errorformat+=%-Gmake:\ ***\ [%f:%l:\ %o]\ %m " ignore makefile errors

" Generic fallbacks (Go, Rust short, simple C, flake8)
set errorformat+=%f:%l:%c:\ %m
set errorformat+=%f:%l:\ %m

" Uncomment to ignore any lines that don't match the rules above
set errorformat+=%-G%.%#
