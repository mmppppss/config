local map=function(mode, key, action)
	vim.api.nvim_set_keymap(mode, key, action, {noremap = true, silent= false})
end

vim.g.mapleader = " "

map('n', 'w', ':w<CR>')
map('n', 'q', ':q<CR>')
map('n', '<F2>', ':Explore <CR>')
map('n', '<F2>f', ':NERDTreeToggle <CR>')
map('n', '<F3>t', ':tabnew <CR>')
map('n', '<F3>c', ':tabclose <CR>')
map('n', '<F3><LEFT>', ':tabprev <CR>')
map('n', '<F3><RIGHT>', ':tabnext <CR>')
map('n', '<F3>v', ':vsplit <CR>')
map('n', '<F3>h', ':split <CR>')
map('n', '<F4>f', ':Telescope find_files<CR>')
map('n', '<F4>b', ':Telescope buffers<CR>')
map('n', '<F5>c',':vsp |set nonu | set nornu | terminal gcc % -o %.out; ./%.out<CR>')
map('n', '<F5>n',':vsp |set nonu | set nornu | terminal node % <CR>')
map('n', '<F5>p',':vsp |set nonu | set nornu | terminal python % <CR>i')
map('n', '<F5>s',':sp |set nonu | set nornu | terminal swipl % <CR>i')
map('n', '<F5>f',':!firefox % & > /dev/null <CR>')
map('n', '<F5>u',':vsp | set nonu | set nornu | terminal cat % | plantuml -tutxt -pipe <CR>')
map('n', '<F5>j',':vsp |set nonu | set nornu | terminal javac %; java % <CR>i')
map('n', '<F5>g',':vsp |set nonu | set nornu | terminal lazygit <CR>i  <CR>')
map('n', '<F5>l',':vsp |set nonu | set nornu | terminal fpc %; ./$(echo % | sed \'s/.pas//\'); rm *.ppu; rm *.o; <CR>')
map('n', '<F5>t',':VimtexCompile<CR>')
map('n', '<F5>ph',':vsp | terminal php % <CR>i')



-- LSP: navegación y acciones
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')         -- Ir a definición
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')         -- Referencias
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')     -- Implementación
map('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')              -- Documentación flotante
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')     -- Renombrar símbolo
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')-- Acciones de código
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')       -- Diagnóstico anterior
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')       -- Diagnóstico siguiente
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>') -- Formatear
