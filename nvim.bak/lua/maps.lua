local keymap = vim.keymap

-- 현재 커서가 위치한 문자 삭제 : x
keymap.set('n', 'x', '"_x')

-- 숫자 증가/감소 : +, -
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- 단어 삭제 : dw
keymap.set('n', 'dw', 'vb"_d')

-- 모두 선택 : ^a
keymap.set('n', '<C-a>', 'gg<S-v>G')

--- 새 탭 : tb
keymap.set('n', 'tb', ':tabedit<Return>', { silent = true})

-- 화면 가로 분할 : sb
keymap.set('n', 'sb', ':split<Return><C-w>w', { silent = true})

-- 화면 세로 분할 : sv
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true})

-- 분할 화면 커서 이동 : sh, sk, sj sl 
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- 화면 리사이즈 ^W + 커서방향
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Tab Close
keymap.set("n", "<S-w>","<cmd>bd<CR>", { desc = 'Close Tab'})

-- LSP(Language Server Portoco) 
vim.keymap.set('n', '<s-b>', vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set('n', '<s-k>', vim.lsp.buf.hover, {desc = "show code hover"})
vim.keymap.set('n', '<s-r>', vim.lsp.buf.references, {desc = "show refrence"})
vim.keymap.set('n', '<s-l>', function() vim.lsp.buf.format { async = true } end)
vim.keymap.set('n', '<s-Enter>',vim.lsp.buf.code_action, {desc = "code action"})
