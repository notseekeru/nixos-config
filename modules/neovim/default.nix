{ config, pkgs, ... }:

{
  imports = [
    ./binaries.nix
    ./plugins.nix
    ./lsp.nix
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      require("nvim-treesitter").setup({})

      -- Enable tree-sitter highlighting for all supported filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"*"},
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- LSP setup
      dofile(vim.fn.stdpath("config") .. "/lsp.lua")

      -- blink-cmp
      require("blink-cmp").setup({
        keymap = {
          preset = "default",
          ["<C-Space>"] = { "show", "show_documentation" },
          ["<C-e>"] = { "hide" },
          ["<CR>"] = { "accept", "fallback" },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      })

      -- snacks.nvim
      require("snacks").setup({
        bigfile = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true, style = "compact" },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      })

      -- harpoon2
      local harpoon = require("harpoon")
      harpoon:setup({})

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

      -- General settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.mouse = "a"
      vim.opt.clipboard = "unnamedplus"
      vim.opt.undofile = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.updatetime = 250

      -- Leader key
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
    '';
  };
}
