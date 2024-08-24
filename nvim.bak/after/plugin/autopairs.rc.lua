local status, autopaires = pcall(require, 'nvim-autopaires')
local autotag = require('nvim-ts-autotag')
if (not status) then return end

autopaires.setup {
  disable_filetype = { "TelescopePrompt" , "vim" },
  check_ts = true,
}

autotag.setup {
  enable = true
}
