" BASIC CONFIG {{{
" minor configs
filetype plugin indent on
set formatoptions+=r
set path+=**
set foldmethod=marker
set nohidden
set background=dark
set incsearch
set ignorecase
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
" map <C-t> :term<CR> 		terminal map is commented out because nowadays
" 				I'm using an st keybind
nnoremap tn :set rnu!<CR>

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
nnoremap ;c :-1r ~/.vim/snippets/skeleton.c<CR>6j8l :-1r ! date +'\%b \%d, \%Y'<CR>kJ Gdd3k2l :let @a=expand('%t')<CR>"aph2xl
nnoremap ;ds :-1read ~/.vim/snippets/script-doc.sh<CR>2j8l:r ! date +'\%b \%d, \%Y'<CR>kJjdd
nnoremap ;gplc :-1read ~/.vim/snippets/gpl.c<CR>
nnoremap ;gpls :-1read ~/.vim/snippets/gpl.sh<CR>

" replace strings (maps two spaces to find the next '++' and replace it)
nnoremap <Space><Space> /++<CR>2xi

" }}}

" WRAP AND LINEBREAK {{{
" it file is markdown, html, ms (groff) or txt, sets line wrap without slicing words.
" other files keeps without wrap
augroup markdown_settings
	autocmd!
	autocmd BufNewFile,BufRead * set nowrap
	autocmd BufNewFile,BufRead *.md set wrap
	autocmd BufNewFile,BufRead *.md set linebreak
	autocmd BufNewFile,BufRead *.html set wrap
	autocmd BufNewFile,BufRead *.html set linebreak
	autocmd BufNewFile,BufRead *.txt set wrap
	autocmd BufNewFile,BufRead *.ms set wrap
	autocmd BufNewFile,BufRead *.ms set linebreak
augroup END
" }}}

" HI {{{
" makes numbers darkgray because it's almost invisible
hi LineNr ctermfg=DarkGray
" vertsplits
hi VertSplit ctermbg=NONE cterm=NONE
" statusline
hi StatusLine ctermbg=NONE cterm=NONE
hi StatusLineNC ctermbg=NONE cterm=NONE
" }}}
