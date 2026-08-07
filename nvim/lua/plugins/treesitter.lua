
---treesitter
--
require('nvim-treesitter.configs').setup {
	ensure_installed = { "c", "lua", "cpp", "javascript", "astro", "html", "css", "typescript" },
	sync_install = false,
	auto_install = true,
--  ignore_install = { "javascript" },
	highlight = {
	    enable = true
	},
    disable = { "markdown" },
--    disable = { "c", "rust" },
--  },
}
