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
      -- Treesitter (nvim-treesitter v0.10 — parser management only)
      -- Highlight/indent handled by Neovim built-in vim.treesitter
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

      -- gitsigns
      require("gitsigns").setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
          end
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
          map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true })
          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true })
        end,
      })

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
