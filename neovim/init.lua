-- GREAT DEFAULTS {{{
vim.opt.textwidth = 80
vim.opt.foldmethod = "marker"
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.path = vim.opt.path + "**"
vim.opt.ignorecase = true
vim.opt.scrolloff = 10
vim.opt.wildmode = "list:full"
vim.opt.wildignore = { "__pycache__/", "test.txt", "test*.txt", "LICENSE", "a.out", "*.gch", ".SRCINFO", ".git" }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 100
vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.laststatus = 3
vim.opt.spelllang = "en,pt" -- I'm brazilian so eventually I write portuguese
-- }}}

-- PLUGINS {{{
require "paq" {
	"savq/paq-nvim";
	-- i complete with tab
	'ervandew/supertab',
	-- auto closing things
	'ervandew/matchem',
	'ervandew/sgmlendtag',
	-- auto wrap documents
	'preservim/vim-pencil',
	-- the world-famous tpope's vim-commentary
	'tpope/vim-commentary',
	-- file filer
	'nvim-telescope/telescope.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
	-- show git status
	'airblade/vim-gitgutter',
	-- the world-famous tpope's *nix helper
	'tpope/vim-eunuch',
	-- make terminal great again
	'voldikss/vim-floaterm',
	-- colorscheme
	'catppuccin/nvim',
	-- indent guides for code indented with spaces (Python and Rust)
	'Yggdroot/indentLine',
	-- statusline
	'nvim-lualine/lualine.nvim',
	-- make highlighting great again
	{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
	-- lsp and completion config
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip',
	-- Finally, the devicons
	'ryanoasis/vim-devicons'
}
-- }}}

-- KEYBINDS {{{
vim.keymap.set("n", "tn", ":set rnu!<CR>:set nu!<CR>")
vim.keymap.set("n", "<C-s>", ":setlocal spell!<CR>")
vim.keymap.set("n", "<Space><Space>", "/++<CR>2xi")

-- navigation and splits
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "si", ":vsp<CR>")
vim.keymap.set("n", "su", ":sp<CR>")

-- snippets
vim.keymap.set("n", ";c", ":-1r ~/.local/share/nvim/snippets/skeleton.c<CR>7j8l :-1r ! date +'\\%b \\%d, \\%Y'<CR>kJ Gdd3k2l :let @a=expand('%t')<CR>\"aph2xl")
vim.keymap.set("n", ";ds", ":-1r ~/.local/share/nvim/snippets/script-doc.sh<CR>2j8l:r ! date +'\\%b \\%d, \\%Y'<CR>kJjdd")
vim.keymap.set("n", ";mitc", ":r ~/.local/share/nvim/snippets/mit.c<CR>j :r ! date +'\\%Y'<CR>kJJ")
vim.keymap.set("n", ";mits", ":-1r ~/.local/share/nvim/snippets/mit.sh<CR>j :r ! date +'\\%Y'<CR>kJJ")
vim.keymap.set("n", ";mitt", ":-1r ~/.local/share/nvim/snippets/mit.txt<CR>:r ! date +'\\%Y'<CR>kJJ")

-- telescope
vim.keymap.set("n", "<C-n>", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<C-d>", ":Telescope diagnostics<CR>")
vim.keymap.set("n", "<C-r>", ":Telescope lsp_references<CR>")
vim.keymap.set("n", "<C-f>", ":Telescope git_files<CR>")
-- }}}

-- GIT GUTTER {{{
vim.g.gitgutter_terminal_reports_focus = 0
vim.g.gitgutter_highlight_linenrs = 1
vim.g.gitgutter_signs = 1
-- }}}

-- TERMINAL {{{
vim.g.floaterm_keymap_toggle = "<C-t>"
vim.g.floaterm_width = 0.99
vim.g.floaterm_height = 0.5
vim.g.floaterm_position = "bottom"
vim.g.floaterm_title = "terminal"
-- vim.g.floaterm_borderchars = ""
-- }}}

-- TELESCOPE {{{
local fb_actions = require "telescope".extensions.file_browser.actions
local actions = require("telescope.actions")
require('telescope').setup({
	defaults = {
		prompt_prefix = ': ',
		selection_caret = ' ',
		border = false,
		preview = { hide_on_startup = true, },
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<Tab>"] = actions.move_selection_next,
				["<S-Tab>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		lsp_references = { theme = 'ivy', layout_config = { height = 0.4, }, },
		diagnostics = { theme = 'ivy', layout_config = { height = 0.4, }, },
		git_files = { theme = 'ivy', layout_config = { height = 0.4, }, },
	},
	extensions = {
		file_browser = {
			theme = 'ivy',
			layout_config = { height = 0.4, },
			hidden = true,
			mappings = {
				["i"] = {
					["<C-a>"] = fb_actions.toggle_hidden,
					["<Space>"] = fb_actions.change_cwd,
					["<C-h>"] = fb_actions.goto_parent_dir,
					["<C-l>"] = fb_actions.change_cwd,
				},
			},
		},
	},
})

require('telescope').load_extension('file_browser')
-- }}}

-- AUTOCMD {{{
local buf_settings = vim.api.nvim_create_augroup('buf_settings', {clear = true})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
	pattern = {
		'*.md',
		'*.html',
		'*.txt',
	},
	group = buf_settings,
	desc = 'Docs auto setting',
	callback = function()
		vim.cmd('HardPencil')
	end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
	pattern = {
		'*.ms',
		'*.1',
		'*.2',
		'*.3',
		'*.4',
		'*.5',
		'*.6',
		'*.7',
	},
	group = buf_settings,
	desc = 'Groff auto setting',
	callback = function()
		vim.bo.filetype = "groff"
		vim.cmd('HardPencil')
	end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
	pattern = {
		'Cargo.toml',
		'Cargo.lock',
		'*.rs',
	},
	group = buf_settings,
	desc = 'Rust make settings',
	callback = function()
		vim.bo.makeprg = 'cargo'
	end
})
-- }}}

-- TREESITTER {{{
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "python", "rust", "bash", "lua" },
	highlight = { enable = true, },
}
-- }}}

-- APPEARANCE {{{
local catppuccin = require('catppuccin')
catppuccin.setup({
	transparent_background = true,
	term_colors = true,
	integrations = {
		gitgutter = true,
	},
})
vim.cmd('colorscheme catppuccin')

vim.api.nvim_set_hl(0, 'SignColumn',                  {bg = 'NONE'})

vim.opt.fillchars = vim.opt.fillchars + { eob = ' ' }
vim.opt.listchars = { tab = '| ' }
vim.opt.list = true

vim.g.indentLine_setColors = 0
vim.g.indentLine_char = '|'
-- }}}

-- STATUSLINE {{{
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
-- }}}

-- LSP AND COMPLETION {{{
local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	}),
})

cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['clangd'].setup { capabilities = capabilities }
require('lspconfig')['rust_analyzer'].setup { capabilities = capabilities }
require('lspconfig')['pylsp'].setup { capabilities = capabilities }
-- }}}
