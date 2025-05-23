require "core.globals"

if vim.version().minor >= 11 then
  vim.tbl_add_reverse_lookup = function(tbl)
    for k, v in pairs(tbl) do
      tbl[v] = k
    end
  end
end

vim.g.clipboard = {
  name = 'wl-clipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste',
    ['*'] = 'wl-paste',
  },
  cache_enabled = true,
}

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.runtimepath:prepend(lazypath)

-- NOTE: lazy.nvim options
local lazy_config = require "core.lazy"

-- NOTE: Load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- Load the highlights
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

require "options"
require "nvchad.autocmds"
require "core.commands"

vim.schedule(function()
  require "mappings"
end)

require "myinit"


vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
require("notify").setup({
	background_colour = "#000000",
})
require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets/vscode" } })
