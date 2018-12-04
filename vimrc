set nocompatible
syntax on
set encoding=utf-8
set ruler
set modeline
set nofoldenable
set shiftround     " When at 3 spaces and I hit >>, go to 4, not 5.
set showmode
set pastetoggle=<F2> " http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
imap jk <Esc>

""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'

Plugin 'github:StanAngeloff/php.vim'

"Plugin 'github:derekwyatt/vim-scala'

Plugin 'tpope/vim-cucumber'

" Haml, Sass and SCSS
Plugin 'tpope/vim-haml'

Plugin 'Shougo/unite.vim'
Plugin 'basyura/unite-rails'
Plugin 'Shougo/unite-outline'

Plugin 'majutsushi/tagbar'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'tpope/vim-endwise'

Plugin 'tpope/vim-ragtag'

Plugin 'tpope/vim-surround'

" Angular and other Javascript goodies
" https://github.com/burnettk/vim-angular
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'matthewsimo/angular-vim-snippets'
Plugin 'claco/jasmine.vim'
Plugin 'scrooloose/syntastic.git'
Plugin 'burnettk/vim-angular'

" Go language golang
Plugin 'fatih/vim-go'

" React
Plugin 'mxw/vim-jsx'

" Idris
Plugin 'idris-hackers/idris-vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

""""""""""""""""""""""""""""""""
" Default tab and indent behaviour
""""""""""""""""""""""""""""""""
set ai
set bs=2
set ts=4
set sw=4
set et
" Overrides for Ruby source
au FileType ruby set ts=2 sw=2
" Overrides for javascript
au FileType javascript set ts=2 sw=2

""""""""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""
" Rails
""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""
" StanAngeloff/php.vim
""""""""""""""""""""""""""""""""

function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END


""""""""""""""""""""""""""""""""
" Obsolete
""""""""""""""""""""""""""""""""

"" For Windows GUI

"set guifont=Consolas:h11:cDEFAULT
"highlight Normal guibg=lightyellow

" Use Ack instead of grep
"set grepprg=ack
" Map shortcuts to next/prev search result
"map <C-n> :cn<CR>
"map <C-p> :cp<CR>


