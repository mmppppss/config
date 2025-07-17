local lspconfig = require("lspconfig")

-- Configuración básica para varios servidores
local servers = { "ts_ls", "lua_ls", "html", "jsonls", "pyright" }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({})
end
