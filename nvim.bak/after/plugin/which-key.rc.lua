local status, whichkey = pcall(require, 'which-key')
if not status then return end

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
    expr = false, -- use `expr` when creating keymaps
  }

whichkey.setup {
    window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}

whichkey.register({
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["s"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },

    f = {
      name = "File",
      f = {'<cmd>lua require("telescope.builtin").find_files({ path = "%:p:h", cwd = telescope_buffer_dir(), respect_git_ignore = true, hidden = true, grouped = true, previewer = true, initial_mode = "normal", layout_config = { height = 40 } })<cr>',"Find file"},
      b = {'<cmd>lua require("telescope.builtin").buffers()<cr>', "Buffers"},
      g = {'<cmd>lua require("telescope.builtin").live_grep()<cr>', 'Live grep'},
      s = {':Telescope file_browser path=%:p:h select_buffer=true<CR>', 'File browser'},
    },

    t = {
      name = "Test",
      s = {'<cmd>lua require("neotest").summary.toggle()<cr>', 'test Summary'},
      w = {'<cmd>lua require("neotest").run.run({ jestCommand = "npm run test -- --watch " })<cr>', 'test Run'},
      S = {'<cmd>lua require("neotest").run.stop()<cr>','test Stop'},
      n = {'<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>','test All'},
    }
  },opts)

vim.api.nvim_set_keymap("", "<Space><Space>", ":WhichKey", { noremap = true, silent = true })

