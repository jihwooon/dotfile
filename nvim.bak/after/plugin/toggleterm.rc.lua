local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
 return
end

toggleterm.setup({
 size = 20,
 open_mapping = [[<c-\>]],
 hide_numbers = true,
 shade_filetypes = {},
 shade_terminals = false,
 shading_factor = 2,
 start_in_insert = true,
 insert_mappings = true,
 persist_size = true,
 direction = "horizontal",
 close_on_exit = true,
 float_opts = {
  border = "curved",
  winblend = 0,
  highlights = {
   border = "normal",
   background = "normal",
  },
 },
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<c-\><c-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-h>', [[<c-\><c-n><c-w>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-j>', [[<c-\><c-n><c-w>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-k>', [[<c-\><c-n><c-w>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-l>', [[<c-\><c-n><c-w>l]], opts)
end

vim.cmd('autocmd! Termopen term://* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

