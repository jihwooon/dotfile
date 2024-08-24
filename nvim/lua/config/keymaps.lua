local map = vim.api.nvim_set_keymap
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- 숫자 증가/감소 : +, -
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- terminal
map('n', '<C-w>V', ':split term://zsh<Return>', opts)

map('n', '<C-w>>', ':vertical resize +5<CR>', opts)
map('n', '<C-w><', ':vertical resize -5<CR>', opts)
map('n', '<C-w>+', ':resize +5<CR>', opts)
map('n', '<C-w>-', ':resize -5<CR>', opts)
map('t', '<Esc>', '<C-\\><C-n>', opts)

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "sb", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- LSP(Language Server Portoco)
keymap.set('n', '<s-b>', vim.lsp.buf.definition, { desc = "Go to Definition" })
keymap.set('n', '<s-k>', vim.lsp.buf.hover, { desc = "show code hover" })
keymap.set('n', '<s-r>', vim.lsp.buf.references, { desc = "show refrence" })
keymap.set('n', '<s-l>', function() vim.lsp.buf.format { async = true } end)
keymap.set('n', '<s-Enter>', vim.lsp.buf.code_action, { desc = "code action" })

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- NeoAI
keymap.set("n", "<Leader>at", ":NeoAIToggle<Return>", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
