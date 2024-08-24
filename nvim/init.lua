-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('config.macos')
end
if is_win then
  require('config.windows')
end

