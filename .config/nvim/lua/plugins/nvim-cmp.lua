---@type NvPluginSpec
-- NOTE: Completion Engine

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  init = function()
    vim.keymap.set("n", "<leader>oa", function()
      vim.g.toggle_cmp = not vim.g.toggle_cmp
      if vim.g.toggle_cmp then
        vim.notify("Toggled On", vim.log.levels.INFO, { title = "Autocomplete" })
      else
        vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Autocomplete" })
      end
    end, { desc = "Options | Toggle Autocomplete" })
  end,
opts = function(_, opts)
    -- table.insert(opts.sources, 2, { name = "codeium" })
    -- table.insert(opts.sources, 1, { name = "supermaven" })

    opts.mapping = vim.tbl_extend("force", {}, opts.mapping, {
      -- Your mapping to accept suggestion with Ctrl+.
      ['<C-.>'] = require("cmp").mapping(function(fallback)
        if require("cmp").visible() then
          require("cmp").confirm({ select = true }) -- Accept the currently selected item
        else
          fallback() -- If no completion is visible, do nothing or perform default behavior
        end
      end, { 'i', 's' }), -- Apply in Insert and Select modes

      -- *** ADD or ENSURE this mapping for Enter exists ***
      -- For Enter, just move to the next line (do NOT accept completion)
      ['<CR>'] = require("cmp").mapping(function(fallback)
        -- If completion menu is visible or not, Enter will just perform a newline.
        -- If you want to close the menu on Enter without selecting, you could add cmp.abort() here.
        fallback()
      end, { 'i', 's' }), -- Apply in Insert and Select modes

      -- Add your other mappings here if needed, e.g., for Tab navigation
      -- ['<Tab>'] = require("cmp").mapping(function(fallback) ... end, { 'i', 's' }),

    })

    opts.completion["completeopt"] = "menu,menuone,noselect" -- disable autoselect

    opts.enabled = function()
      return (vim.g.toggle_cmp and vim.bo.buftype == "")
    end
  
    require("luasnip").filetype_extend("javascriptreact", { "html" })
    require("luasnip").filetype_extend("typescriptreact", { "html" })
    require("luasnip").filetype_extend("svelte", { "html" })
    require("luasnip").filetype_extend("vue", { "html" })
    require("luasnip").filetype_extend("php", { "html" })
    require("luasnip").filetype_extend("javascript", { "javascriptreact" })
    require("luasnip").filetype_extend("typescript", { "typescriptreact" })

    --NOTE: add border for cmp window
    if vim.g.border_enabled then
      opts.window = {
        completion = require("cmp").config.window.bordered(),
        documentation = require("cmp").config.window.bordered(),
      }
    end
  end,
  dependencies = {
    -- For Rust
    {
      "saecki/crates.nvim",
      tag = "v0.4.0",
      opts = {},
    },
    -- Commandline completions
    {
      "hrsh7th/cmp-cmdline",
      config = function()
        local cmdline_mappings = vim.tbl_extend("force", {}, require("cmp").mapping.preset.cmdline(), {
          ["<C-]>"] = { c = require("cmp").mapping.confirm { select = true } },
        })

        require("cmp").setup.cmdline(":", {
          mapping = cmdline_mappings,
          sources = {
            { name = "cmdline" },
          },
        })
      end,
    },
    -- AI Autocomplete
  -- {
  --   "Exafunction/codeium.vim",
  --   lazy = false,
  --   config = function()
  --     vim.keymap.set("i", "<C-Enter>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true })
  --   end,
  -- }, 
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      build = "make install_jsregexp",
    },
  },
}
