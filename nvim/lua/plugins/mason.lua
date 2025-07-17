require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "ts_ls",   -- JavaScript/TypeScript
        "lua_ls",     -- Lua
        "html",       -- HTML
        "jsonls",     -- JSON
        "pyright",    -- Python
        -- añade más si usas otros lenguajes
    },
    automatic_installation = true,
})
