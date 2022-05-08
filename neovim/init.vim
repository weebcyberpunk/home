" BASIC CONFIG {{{
" minor configs
filetype plugin indent on
set tw=80
set fo+=r
set fo-=o
set fo-=l
set fo-=t
set path+=**
set foldmethod=marker
set ignorecase
set relativenumber
set number
set scrolloff=5
set termguicolors
set signcolumn=yes
set nowrap
" }}}

" VIM-PLUG {{{
" call the vim-plug vim plugin manager
call plug#begin('~/.vim/plugged')

" i complete with tab
Plug 'ervandew/supertab'
" auto closing things
Plug 'ervandew/matchem'
Plug 'ervandew/sgmlendtag'
" auto wrap documents
Plug 'preservim/vim-pencil'
" the world-famous tpope's vim-commentary
Plug 'tpope/vim-commentary'
" great tree explorer
Plug 'nvim-neo-tree/neo-tree.nvim' |
			\ Plug 'MunifTanjim/nui.nvim' |
			\ Plug 'nvim-lua/plenary.nvim'
" show git status
Plug 'airblade/vim-gitgutter'
" the world-famous tpope's fugitive git wrapper
Plug 'tpope/vim-fugitive'
" the world-famous tpope's *nix helper
Plug 'tpope/vim-eunuch'
" make terminal great again
Plug 'voldikss/vim-floaterm'
" colorscheme
Plug 'catppuccin/nvim'
" indent guides for code indented with spaces (Python and Rust)
Plug 'Yggdroot/indentLine'
" statusline
Plug 'nvim-lualine/lualine.nvim'
" lsp and completion config
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" Finally, the devicons
Plug 'ryanoasis/vim-devicons'

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

" neotree
nnoremap <C-n> :NeoTreeShowToggle<CR>

" }}}

" NEOTREE {{{

lua << EOF
require("neo-tree").setup({
	close_if_last_window = true,
	default_component_configs = {
		indent = {
			indent_size = 1,
			padding = 1,
		},
	},
	window = {
		position = "right",
		padding = 0,
		width = 23,
		mappings = {
			["<space>"] = { "toggle_node", nowait = true, },
			["m"] = { "add" },
			["M"] = "add_directory",
			["b"] = "move",
			},
	},
	filesystem = {
		hide_dotfiles = false,
		follow_current_file = true,
		use_libuv_file_watcher = true,
		window = {
			mappings = {
				["a"] = "toggle_hidden",
				["h"] = "navigate_up",
				["l"] = "set_root",
			},
		},
	},
	buffers = {
		window = {
			mappings = {
				["h"] = "navigate_up",
				["l"] = "set_root",
			},
		},
	},
	
})

EOF

" }}}

" GIT-GUTTER {{{

let g:gitgutter_terminal_reports_focus=0
set updatetime=100
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_signs = 1

" }}}

" TERMINAL {{{

let g:floaterm_keymap_toggle = '<C-t>'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

" }}}

" AUTOCMD SETTINGS {{{
function AutoStart()
	Neotree
	setlocal nonumber
	setlocal norelativenumber
	wincmd p
endfunction

function NeotreeSettings()
	setlocal nonumber
	setlocal norelativenumber
	setlocal signcolumn = no
endfunction

function DocSettings()
	HardPencil
endfunction

function GroffSettings()
	call DocSettings()
	set filetype=groff
endfunction

augroup doc_settings
	autocmd!
	autocmd BufNewFile,BufRead *.md,*.html,*.txt,*.ms call DocSettings()
	autocmd BufNewFile,BufRead *.ms,*.1,*.2,*.3,*.4,*.5,*.6,*.7 call GroffSettings()
augroup END

augroup general
	autocmd!
	autocmd BufNewFile,BufRead Cargo.toml,Cargo.lock,*.rs setlocal makeprg=cargo
augroup END

augroup autostart
	autocmd!
	autocmd VimEnter * call AutoStart()
augroup END
" }}}

" APPEARANCE {{{
lua << EOF
local catppuccin = require("catppuccin")

catppuccin.setup({
	transparent_background = true,
	term_colors = true,
})
EOF
colorscheme catppuccin

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

hi NeoTreeDirectoryName ctermfg=11 guifg='#DDB6F2'
" }}}

" STATUSLINE {{{
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
	theme = 'auto', -- note: I manually changed the normal c bg to match my term bg
	globalstatus = true
	},
extensions = {
	'toggleterm',
	'fugitive'
	},
}
END

hi StatusLine ctermbg=NONE guibg=NONE
hi StatusLineNC ctermbg=NONE guibg=NONE

" }}}

" LSP AND COMPLETION {{{

set completeopt=menu,menuone,noselect

lua <<EOF

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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
      -- elseif luasnip.expand_or_jumpable() then
      --  luasnip.expand_or_jump()
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
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup { capabilities = capabilities }
  require('lspconfig')['rust_analyzer'].setup { capabilities = capabilities }
EOF

" }}}
