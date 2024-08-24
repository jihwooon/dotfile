local status, telescope = pcall(require, 'telescope')
if (not status) then return end
local actions = require('telescope.actions')

function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
  defaults = {
   mappings = {
      n = {
        ['q'] = actions.close
      }
    }
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      hijack_netrw = true,
      mappings = {
        ['i'] = {
          ['<C-w>'] = function() vim.cmd('normal vbd') end,
        },
        ['n'] = {
          ['N'] = fb_actions.create,
          ['h'] = fb_actions.goto_parent_dir,
          ['/'] = function()
            vim.cmd('startinsert')
          end
        }
      }
    }
  }
}

telescope.load_extension ('file_browser')

--[[ local opts = { noremap = true, silent = true } ]]
-- vim.keymap.set('n','<S-f>', '<cmd>lua require("telescope.builtin").find_files({ path = "%:p:h", cwd = telescope_buffer_dir(), respect_git_ignore = true, hidden = true, grouped = true, previewer = true, initial_mode = "normal", layout_config = { height = 40 } })<cr>', opts) -- shift + f
-- vim.keymap.set('n','<C-S-f>', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
-- -- vim.keymap.set('n','', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
-- vim.keymap.set('n',';t', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
-- vim.keymap.set('n',';;', '<cmd>lua require("telescope.builtin").resume()<cr>', opts)
-- vim.keymap.set('n',';e', '<cmd>lua require("telescope.builtin").diagnostics()<cr>', opts)
-- vim.api.nvim_set_keymap('n', 'sf', ':Telescope file_browser path=%:p:h select_buffer=true<CR>',{ noremap = true} )
