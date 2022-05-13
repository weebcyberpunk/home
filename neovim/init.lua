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
	-- great tree explorer
	'kyazdani42/nvim-tree.lua',
	-- show git status
	'airblade/vim-gitgutter',
	-- the world-famous tpope's fugitive git wrapper
	'tpope/vim-fugitive',
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
vim.keymap.set("n", ";c", ":-1r ~/.vim/snippets/skeleton.c<CR>7j8l :-1r ! date +'\\%b \\%d, \\%Y'<CR>kJ Gdd3k2l :let @a=expand('%t')<CR>\"aph2xl")
vim.keymap.set("n", ";ds", ":-1r ~/.vim/snippets/script-doc.sh<CR>2j8l:r ! date +'\\%b \\%d, \\%Y'<CR>kJjdd")
vim.keymap.set("n", ";mitc", ":r ~/.vim/snippets/mit.c<CR>j :r ! date +'\\%Y'<CR>kJJ")
vim.keymap.set("n", ";mits", ":-1r ~/.vim/snippets/mit.sh<CR>j :r ! date +'\\%Y'<CR>kJJ")
vim.keymap.set("n", ";mitt", ":-1r ~/.vim/snippets/mit.txt<CR>:r ! date +'\\%Y'<CR>kJJ")

-- nvim tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
-- }}}

-- GIT GUTTER {{{
vim.g.gitgutter_terminal_reports_focus = 0
vim.g.gitgutter_highlight_linenrs = 1
vim.g.gitgutter_signs = 1
-- }}}

-- TERMINAL {{{
vim.g.floaterm_keymap_toggle = "<C-t>"
vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.9
-- }}}

-- NVIM TREE {{{
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_show_icons = { 
	git = 1, 
	folders = 1, 
	files = 1, 
	folder_arrows = 1, 
}

require'nvim-tree'.setup {
	hijack_cursor = false,
	open_on_setup = false,
	open_on_tab = true,
	update_cwd = true,
	view = {
		width = 20,
		height = 20,
		side = "right",
		preserve_window_proportions = true,
		signcolumn = "yes",
		mappings = {
			custom_only = true,
			list = {
				{ key = {"<CR>"}, action = "edit" },
				{ key = {"l"}, action = "cd" },
				{ key = {"<Space>"}, action = "preview" },
				{ key = {"g"}, action = "first_sibling" },
				{ key = {"G"}, action = "last_sibling" },
				{ key = {"a"}, action = "toggle_dotfiles" },
				{ key = {"R"}, action = "refresh" },
				{ key = {"m"}, action = "create" },
				{ key = {"<BS>"}, action = "remove" },
				{ key = {"r"}, action = "full_rename" },
				{ key = {"h"}, action = "dir_up" },
				{ key = {"q"}, action = "close" },
				{ key = {"/"}, action = "search_node" },
				{ key = {"$"}, action = "run_file_command" },
				{ key = {"s"}, action = "vsplit" },
				{ key = {"u"}, action = "split" },
			},
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	actions = {
		change_dir = {
			enable = true,
			global = true,
		},
	},
}
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

-- APPEARANCE {{{
local catppuccin = require('catppuccin')
catppuccin.setup({
	transparent_background = true,
	term_colors = true,
})
vim.cmd('colorscheme catppuccin')

vim.api.nvim_set_hl(0, 'SignColumn',                  {bg = 'NONE'})
vim.api.nvim_set_hl(0, 'NvimTreeNormal',              {bg = 'NONE'})
vim.api.nvim_set_hl(0, 'NvimTreeNormalNC',            {bg = 'NONE'})
vim.api.nvim_set_hl(0, 'GitGutterAddLineNr',          {fg = 'Green'})
vim.api.nvim_set_hl(0, 'GitGutterChangeLineNr',       {fg = 'Yellow'})
vim.api.nvim_set_hl(0, 'GitGutterDeleteLineNr',       {fg = 'Red'})
vim.api.nvim_set_hl(0, 'GitGutterChangeDeleteLineNr', {fg = 'Magenta'})

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
