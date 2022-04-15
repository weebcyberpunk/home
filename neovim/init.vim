" BASIC CONFIG {{{
" minor configs
filetype plugin indent on
set tw=80
set formatoptions+=r
set path+=**
set foldmethod=marker
set nohidden
set ignorecase
set relativenumber
set number
set scrolloff=5
set termguicolors
" }}}

" VIM-PLUG {{{
" call the vim-plug vim plugin manager
call plug#begin('~/.vim/plugged')

" autocomplete on i mode with tab
Plug 'ervandew/supertab'
" the world-famous tpope's vim-commentary
Plug 'tpope/vim-commentary'
" the world-famous nerdtree
Plug 'preservim/nerdtree' |
			\ Plug 'Xuyuanp/nerdtree-git-plugin'
" show git status
Plug 'airblade/vim-gitgutter'
" tetris
Plug 'alec-gibson/nvim-tetris'
" colorscheme
Plug 'lifepillar/vim-wwdc16-theme'
" colored icons for bufferline
Plug 'kyazdani42/nvim-web-devicons'
" bufferline
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

call plug#end()

" }}}

" BUFFERLINE {{{

lua << EOF
require("bufferline").setup{}
EOF

" }}}

" WILDMENU {{{
" setting wildmenu and removing some files from it
set wildmode=list:full
set wildignore+=tags,__pycache__/,test.txt,test*.txt,LICENSE,a.out,*.gch,.SRCINFO
"}}}

" SPLITS {{{
" more natural splits
set splitbelow
set splitright
" }}}

" KEYBINDS {{{
" I used to use C-t to open a terminal but terminals in neovim are inusable (in
" vim they aren't)
" I use actually a ST bind open a new instance, outside from neovim
nnoremap tn :set rnu!<CR> :set nu!<CR>
nnoremap <C-s> :setlocal spell!<CR>
nnoremap tg :GitGutterToggle<CR>

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

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" zen mode emulator
map <C-f> :set norelativenumber<CR>:set nonumber<CR>:NERDTreeClose<CR>:GitGutterDisable<CR>:GitGutterSignsDisable<CR>:set showtabline=0<CR>:set laststatus=1<CR>
map <C-u> :set relativenumber<CR>:set number<CR>:NERDTree<CR>:wincmd p<CR>:GitGutterEnable<CR>:GitGutterSignsEnable<CR>:set showtabline=2<CR>:set laststatus=2<CR>

" }}}

" NERDTREE {{{

" start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let NERDTreeChDirMode=3
let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=20
let NERDTreeMinimalUI=1

" maps
let NERDTreeMapChangeRoot='l'
let NERDTreeMapUpdir='h'

" }}}

" GIT-GUTTER {{{

let g:gitgutter_terminal_reports_focus=0
set updatetime=100

" }}}

" FILETYPE SETTINGS {{{
" it file is markdown, html, ms (groff) or txt, sets line wrap without slicing words.
" other files keeps without wrap
function DocSettings()
	setlocal wrap
	setlocal linebreak
endfunction

function GroffSettings()
	call DocSettings()
	set filetype=groff
endfunction

augroup wrap_settings
	autocmd!
	autocmd BufNewFile,BufRead * setlocal nowrap
	autocmd BufNewFile,BufRead * setlocal nolinebreak
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

" APPEARANCE {{{
let g:wwdc16_transp_bg = 1
colorscheme wwdc16

hi SignColumn ctermbg=NONE cterm=NONE guibg=NONE
hi StatusLine ctermbg=NONE cterm=NONE guibg=NONE
set fillchars+=eob:\ 
set list lcs=tab:\|\ 
" }}}
