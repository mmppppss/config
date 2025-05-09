require("ibl").setup({
       debounce = 100,
       indent = { char = "│"},
       whitespace = { highlight = {"Whitespace", "NonText", "Function" } },
       scope = { enabled=true, exclude = { language = { "lua" } } },
})
