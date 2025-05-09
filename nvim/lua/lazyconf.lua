local plugins = {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	"ellisonleao/gruvbox.nvim",
	{
		"neoclide/coc.nvim", 
		branch= "release"
	},
	{
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate"
	},
	"terrortylor/nvim-comment",
	{
		"lukas-reineke/indent-blankline.nvim", 
		main = "ibl", opts = {} 
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
	},
	'Exafunction/codeium.vim',
	'github/copilot.vim',
	{
		'windwp/nvim-autopairs',
	},
	"puremourning/vimspector",
    {
    	"lukas-reineke/headlines.nvim",
    	dependencies = "nvim-treesitter/nvim-treesitter",
    	config = true, -- or `opts = {}`
    },
	'mattn/emmet-vim',
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		dependencies = "rafamadriz/friendly-snippets"
	},
	'SirVer/ultisnips',
	'honza/vim-snippets',
	{
		"lervag/vimtex",
		lazy = false,     -- we don't want to lazy load VimTeX
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		}
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	}
}
require("lazy").setup(plugins)
