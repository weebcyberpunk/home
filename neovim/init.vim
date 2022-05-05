" BASIC CONFIG {{{
" minor configs
filetype plugin indent on
set tw=80
set fo+=r
set fo-=o
set fo-=l
set path+=**
set foldmethod=marker
set ignorecase
set relativenumber
set number
set scrolloff=5
set termguicolors
set signcolumn=yes
" }}}

" VIM-PLUG {{{
" call the vim-plug vim plugin manager
call plug#begin('~/.vim/plugged')

" i complete with tab
Plug 'ervandew/supertab'
" the world-famous tpope's vim-commentary
Plug 'tpope/vim-commentary'
" the world-famous nerdtree
Plug 'preservim/nerdtree' |
			\ Plug 'Xuyuanp/nerdtree-git-plugin'
" show git status
Plug 'airblade/vim-gitgutter'
" the world-famous tpope's fugitive git wrapper
Plug 'tpope/vim-fugitive'
" colorscheme
Plug 'Mofiqul/dracula.nvim'
" indent guides for code indented with spaces (Python and Rust)
Plug 'Yggdroot/indentLine'
" statusline
Plug 'nvim-lualine/lualine.nvim'
" lsp and completion config
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

call plug#end()

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
nnoremap ;c :-1r ~/.vim/snippets/skeleton.c<CR>7j8l :-1r ! date +'\%b \%d, \%Y'<CR>kJ Gdd3k2l :let @a=expand('%t')<CR>"aph2xl
nnoremap ;ds :-1read ~/.vim/snippets/script-doc.sh<CR>2j8l:r ! date +'\%b \%d, \%Y'<CR>kJjdd
nnoremap ;mitc :r ~/.vim/snippets/mit.c<CR>j :r ! date +'\%Y'<CR>kJJ
nnoremap ;mits :-1r ~/.vim/snippets/mit.sh<CR>j :r ! date +'\%Y'<CR>kJJ
nnoremap ;mitt :-1r ~/.vim/snippets/mit.txt<CR>:r ! date +'\%Y'<CR>kJJ

" replace strings (maps two spaces to find the next '++' and replace it)
nnoremap <Space><Space> /++<CR>2xi

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" zen mode emulator
function ZenEnable()
	set norelativenumber
	set nonumber
	NERDTreeClose
	GitGutterDisable
	GitGutterSignsDisable
	set laststatus=1
	set signcolumn=auto
endfunction

function ZenDisable()
	set relativenumber
	set number
	NERDTree
	wincmd p
	GitGutterEnable
	GitGutterSignsEnable
	set laststatus=2
	set signcolumn=yes
endfunction
map <C-f> :call ZenEnable()<CR>
map <C-u> :call ZenDisable()<CR>

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
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_signs = 1

" }}}

" FILETYPE SETTINGS {{{
" it file is markdown, html, ms (groff) or txt, sets line wrap without slicing words.
" other files keeps without wrap
function DocSettings()
	setlocal wrap
	setlocal linebreak
	set formatoptions-=t
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
	autocmd BufNewFile,BufRead *.ms call DocSettings()
	autocmd BufNewFile,BufRead *.1 call GroffSettings()
	autocmd BufNewFile,BufRead *.2 call GroffSettings()
	autocmd BufNewFile,BufRead *.3 call GroffSettings()
	autocmd BufNewFile,BufRead *.4 call GroffSettings()
	autocmd BufNewFile,BufRead *.5 call GroffSettings()
	autocmd BufNewFile,BufRead *.6 call GroffSettings()
	autocmd BufNewFile,BufRead *.7 call GroffSettings()
" }}}

" APPEARANCE {{{
let g:dracula_transparent_bg = v:true
let g:dracula_italic_comment = v:true
colorscheme dracula

" hi StatusLine ctermbg=NONE cterm=NONE guibg=NONE
hi BufferLineFill ctermbg=NONE cterm=NONE guibg=NONE ctermfg=NONE guifg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

set fillchars+=eob:\ 
set list lcs=tab:\|\ 

hi GitGutterAddLineNr ctermfg=Green guifg=Green
hi GitGutterChangeLineNr ctermfg=Yellow guifg=Yellow
hi GitGutterDeleteLineNr ctermfg=Red guifg=Red
hi GitGutterChangeDeleteLineNr ctermfg=Magenta guifg=Magenta

let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char = '|'
" }}}

" LUALINE {{{

lua << END
require('lualine').setup {
sections = {
	lualine_a = {'mode'},
	lualine_b = {'filename'},
	lualine_c = {'diagnostics'},

	lualine_x = {'branch'},
	lualine_y = {'filetype'},
	lualine_z = {'location'}
	},
options = {
	theme = 'dracula-nvim'
	}
}
END

" }}}

" LSP AND COMPLETION {{{

set completeopt=menu,menuone,noselect
set complete+=i,kspell

lua << EOF
-- now the shit starts

local lspconfig = require('lspconfig')

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.clangd.setup{ capabilities = capabilities }
require'lspconfig'.rls.setup{ capabilities = capabilities }

EOF

" }}}
