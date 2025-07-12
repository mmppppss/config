local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazyconf")
--END LAZY:wq
require("keymap")
require("settings")



vim.g.python3_host_prog = '/usr/bin/python3'


--vim.keymap.set('i', '<C-Tab>', 'copilot#Accept("\\<CR>")', {
--	expr = true,
--	replace_keycodes = false
--})
--vim.g.copilot_no_tab_map = true
