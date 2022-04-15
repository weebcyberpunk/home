" BASIC CONFIG {{{
" minor configs
filetype plugin indent on
set tw=80
set formatoptions+=rc
set path+=**
set foldmethod=marker
set nohidden
set ignorecase
set scrolloff=5
set background=dark
set incsearch
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
set wildignore+=tags,__pycache__/,test.txt,test*.txt,LICENSE,a.out
"}}}

" SPLITS {{{
" more natural splits
set splitbelow
set splitright
" }}}

" KEYBINDS {{{
map <C-t> :term<CR>
nnoremap tn :set rnu!<CR>
nnoremap <C-s> :setlocal spell!<CR>

" split keybinds
" easier navigation without Ctrl+w
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" open v-split with si and h-split with su
nnoremap si :vsp<CR>
nnoremap su :sp<CR>

" snippets keybinds
nnoremap ;c :-1r ~/.vim/snippets/skeleton.c<CR>6j8l :-1r ! date +'\%b \%d, \%Y'<CR>kJ Gdd3k2l :let @a=expand('%t')<CR>"aph2xl
nnoremap ;ds :-1read ~/.vim/snippets/script-doc.sh<CR>2j8l:r ! date +'\%b \%d, \%Y'<CR>kJjdd
nnoremap ;mitc :r ~/.vim/snippets/mit.c<CR>j :r ! date +'\%Y'<CR>kJJ
nnoremap ;mits :-1r ~/.vim/snippets/mit.sh<CR>j :r ! date +'\%Y'<CR>kJJ
nnoremap ;mitt :-1r ~/.vim/snippets/mit.txt<CR>:r ! date +'\%Y'<CR>kJJ

" replace strings (maps two spaces to find the next '++' and replace it)
nnoremap <Space><Space> /++<CR>2xi

" }}}

" FILETYPE SETTINGS {{{
" it file is markdown, html, ms (groff) or txt, sets line wrap without slicing words.
" other files keeps without wrap
function DocSettings()
	set wrap
	set linebreak
endfunction

function GroffSettings()
	call DocSettings()
	set filetype=groff
endfunction

augroup wrap_settings
	autocmd!
	autocmd BufNewFile,BufRead * set nowrap
	autocmd BufNewFile,BufRead *.md call DocSettings()
	autocmd BufNewFile,BufRead *.html call DocSettings()
	autocmd BufNewFile,BufRead *.txt call DocSettings()
	autocmd BufNewFile,BufRead *.ms call DocSettings()
augroup END

augroup groff_settings
	autocmd!
	autocmd BufNewFile,BufRead *.1 call GroffSettings()
	autocmd BufNewFile,BufRead *.2 call GroffSettings()
	autocmd BufNewFile,BufRead *.3 call GroffSettings()
	autocmd BufNewFile,BufRead *.4 call GroffSettings()
	autocmd BufNewFile,BufRead *.5 call GroffSettings()
	autocmd BufNewFile,BufRead *.6 call GroffSettings()
	autocmd BufNewFile,BufRead *.7 call GroffSettings()
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
