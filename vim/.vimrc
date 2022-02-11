" BASIC CONFIG {{{
filetype plugin indent on
set formatoptions+=r
set path+=**
set foldmethod=marker
set nohidden
set background=dark
" }}}

" VIM-PLUG {{{
call plug#begin('~/.vim/plugged')

Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'

call plug#end()
" }}}

" WILDMENU {{{
set wildmenu
set wildignore+=tags,__pycache__/,test.txt,test*.txt,LICENSE
"}}}

" SPLITS {{{
set splitbelow
set splitright
" }}}

" KEYBINDS {{{
map <C-t> :term<CR>
nnoremap tn :set rnu!<CR>

" split keybinds
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

map <C-w><C-i> :vsp<CR>
map <C-w><C-u> :sp<CR>

noremap <C-Left> :vertical resize +3<CR>
noremap <C-Right> :vertical resize -3<CR>
noremap <C-Up> :resize +3<CR>
noremap <C-Down> :resize -3<CR>

" snippets keybinds
nnoremap ,java :-1read ~/.vim/snippets/skeleton.java<CR>2j$
nnoremap ,c :-1read ~/.vim/snippets/skeleton.c<CR>3j
" }}}

" WRAP AND LINEBREAK {{{
" adapted this from reddit ;)
augroup markdown_settings
	autocmd!
	autocmd BufNewFile,BufRead * set nowrap
	autocmd BufNewFile,BufRead *.md set wrap
	autocmd BufNewFile,BufRead *.md set linebreak
	autocmd BufNewFile,BufRead *.html set wrap
	autocmd BufNewFile,BufRead *.html set linebreak
	autocmd BufNewFile,BufRead *.txt set wrap
	autocmd BufNewFile,BufRead *.txt set linebreak
augroup END
" }}}

" HI {{{
hi LineNr ctermfg=DarkGray
" }}}
