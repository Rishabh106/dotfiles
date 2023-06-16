local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "hrsh7th/nvim-cmp",
    commit = "950d0e3a93ba61c13b031c086d11eacf4bd48d24",
    opts = function()
      return require "custom.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({})
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = "~/.config/nvim/lua/custom/snippets",
      })
    end,
  },

  -- Install a plugin
  {
    "p00f/cphelper.nvim",
    lazy = false,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "typescriptreact" },
    opts = {},
  },

  {
    "andweeb/presence.nvim",
    lazy = false,
    opts = {},
    config = function (_, opts)
      require("presence").setup(opts)
    end,
  },

  -- To make a plugin not be loaded
  {
    "NvChad/nvterm",
    enabled = false,
  },

  {
    "folke/which-key.nvim",
    enabled = false,
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
