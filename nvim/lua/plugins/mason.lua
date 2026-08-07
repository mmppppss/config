require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "ts_ls",   -- JavaScript/TypeScript
        "lua_ls",     -- Lua
        "html",       -- HTML
        "jsonls",     -- JSON
        "pyright",    -- Python
        "kotlin_language_server",    -- Kotlin
        "astro",                     -- Astro
    },
    automatic_installation = true,
    automatic_enable = { exclude = { "ts_ls" } },
})
