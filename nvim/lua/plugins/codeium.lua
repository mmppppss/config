vim.g.codeium_disable_bindings = 1
vim.keymap.set('i', '<F1>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<Alt-,>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
vim.keymap.set('i', '<Alt-.>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
vim.keymap.set('i', '<Alt-/>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
