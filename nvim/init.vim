
call plug#begin(stdpath('data') . '/plugged')

" Fancy bar
Plug 'vim-airline/vim-airline'

" Auto-completion
" Next steps after install coc:
"  - install language servers, in particulat ccls (snap install ccls)
"  - CocInstall coc-python
"  - CocInstall coc-json
"  - install Latex support: CocInstall coc-texlab
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Integration linters + make
Plug 'neomake/neomake'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }


" Initialize plugin system
call plug#end()

nmap <c-b> :NERDTreeVCS<cr>

" Configuration completion with coc:
"
" Use tab to navigate completion suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" correct the detection of latex
let g:tex_flavor = "latex"

let g:airline_powerline_fonts = 1

colorscheme molokai

"""""""""""""""""""" FILES SPECIFIC

" Color ROS launch files correctly
au BufRead,BufNewFile *.launch setfiletype xml

au BufRead mutt-*        set ft=mail
au BufRead mutt-*        set invhls
au BufNewFile *.html 0r ~/.vim/templates/html.txt
au BufRead,BufNewFile *.jsm setfiletype javascript
au BufRead,BufNewFile *.xul setfiletype xml
au filetype html,xml set listchars-=tab:>.
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 

" Markdown is now more common than modula2...
augroup markdown
    autocmd!
    autocmd BufNewFile,BufRead *.md  set filetype=markdown
augroup END

autocmd BufNewFile,BufRead *.sk  set filetype=sketch

" CoffeeScript
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!

" Compile RST to PDF on save. Silently fails if no makefile
au BufWritePost *.rst silent! make >/dev/null 2>&1 & | redraw


" Compile markdown to PDF on save. Silently fails if no makefile
au BufWritePost *.md silent! make >/dev/null 2>&1 & | redraw

" Compile TEX to PDF on save. Silently fails if no makefile
au BufWritePost *.tex silent! make >/dev/null 2>&1 & | redraw

map  <F6> :setlocal spell! spelllang=en<CR>
map  <F7> <Esc>iimport pdb;pdb.set_trace()<CR><Esc>

set encoding=utf-8
set hidden
set showcmd
"set nowrap
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set shiftround
set ignorecase
set smartcase
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set title
"set visualbell
set noerrorbells
set list
set listchars=tab:→·,trail:·,extends:→,precedes:→,nbsp:␣
set ttyfast
set mouse=
set nocompatible
set backup
set backupdir=~/.vim_backup
set noswapfile
set fileformats=unix,dos,mac
set laststatus=2
set expandtab
set softtabstop=4 tabstop=4 shiftwidth=4
set ruler
set wildignore=*.swp,*.bak
set wildmode=longest,list

