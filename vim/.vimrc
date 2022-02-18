" BASIC CONFIG {{{
" minor configs
filetype plugin indent on
set formatoptions+=r
set path+=**
set foldmethod=marker
set nohidden
set background=dark
" }}}

" VIM-PLUG {{{
" call the vim-plug vim plugin manager
call plug#begin('~/.vim/plugged')

" autocomplete on i mode with tab
Plug 'ervandew/supertab'
" the world-famous tpope's vim-commentary
Plug 'tpope/vim-commentary'

call plug#end()
" }}}

" WILDMENU {{{
" setting wildmenu and removing some files from it
set wildmenu
set wildignore+=tags,__pycache__/,test.txt,test*.txt,LICENSE
"}}}

" SPLITS {{{
" more natural splits
set splitbelow
set splitright
" }}}

" KEYBINDS {{{
" mapping Ctrl+t to open terminal and tn to toggle relative numbers
map <C-t> :term<CR>
nnoremap tn :set rnu!<CR>

" remapping jj to ESC in i mode
"
" most people remaps CAPS to it, but it needs sys-wide config, and sometimes
" CAPS is usefull
"
" and about CAPS, I have this problem where I do not disable CAPS when exiting
" i mode. you should pay attention to that too!
inoremap jj <Esc>

" split keybinds
" easier navigation without Ctrl+w
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" open v-split with Ctrl+w and Ctrl+i and h-split with Ctrl+w and Ctrl+u
map <C-w><C-i> :vsp<CR>
map <C-w><C-u> :sp<CR>

" resize splits with Ctrl+arrow keys
noremap <C-Left> :vertical resize +3<CR>
noremap <C-Right> :vertical resize -3<CR>
noremap <C-Up> :resize +3<CR>
noremap <C-Down> :resize -3<CR>

" snippets keybinds
nnoremap ,java :-1read ~/.vim/snippets/skeleton.java<CR>2j$
nnoremap ,c :-1read ~/.vim/snippets/skeleton.c<CR>3j
" }}}

" WRAP AND LINEBREAK {{{
" it file is markdown, html or txt, sets line wrap without slicing words.
" other files keeps without wrap
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
" just makes the line numbers dark gray so they're more discrete
hi LineNr ctermfg=DarkGray
" }}}
