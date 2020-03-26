
call plug#begin(expand('~/.local/share/nvim/plugged'))

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


""" BEGINING OF COC CONFIGURATION

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


""" END OF COC CONFIGURATION



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

