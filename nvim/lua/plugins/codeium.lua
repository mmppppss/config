vim.g.codeium_disable_bindings = 1
vim.keymap.set('i', '<s-Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-.>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-/>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
