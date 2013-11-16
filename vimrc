set encoding=utf-8

"set guifont=Consolas:h11:cDEFAULT
highlight Normal guibg=lightyellow

filetype plugin indent on
syntax on
set ai
set bs=2
set ruler
set modeline
set nofoldenable
set shiftround     " When at 3 spaces and I hit >>, go to 4, not 5.
"set showmode
set pastetoggle=<F2> " http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste

" Rails
let mapleader = ","

" From http://github.com/r00k/dotfiles/blob/master/vimrc
map <Leader>c :Rcontroller 
map <Leader>tc :RTcontroller 
map <Leader>vc :RVcontroller 
map <Leader>sc :RScontroller 
map <Leader>vf :RVfunctional 
map <Leader>l :!ruby <C-r>% \| less<CR>
map <Leader>m :Rmodel 
map <Leader>tm :RTmodel 
map <Leader>vm :RVmodel 
map <Leader>sm :RSmodel 
map <Leader>u :Runittest 
map <Leader>vu :RVunittest 
map <Leader>su :RSunittest 
map <Leader>tv :RTview 
map <Leader>vv :RVview 
map <Leader>sv :RSview 

" Use Ack instead of grep
set grepprg=ack
" Map shortcuts to next/prev search result
map <C-n> :cn<CR>
map <C-p> :cp<CR>


