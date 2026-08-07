require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	window = {
		position = "left",
		width = 30,
		mapping_options = { noremap = true, nowait = true },
	},
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = true,
		},
		follow_current_file = { enabled = true },
	},
	buffers = { follow_current_file = { enabled = true } },
})
