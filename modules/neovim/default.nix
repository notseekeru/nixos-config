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
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      vim.keymap.set('n', 's', '<C-^>', { desc = 'Switch to last buffer' })

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

      -- snacks.nvim (utility suite: picker, notifier, scroll, indent, etc.)
      require("snacks").setup({
        bigfile = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true, style = "compact" },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      })

      -- snacks picker keymaps (Search/Find)
      vim.keymap.set("n", "<leader>ff", function() require("snacks").picker.files() end, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", function() require("snacks").picker.grep() end, { desc = "Grep" })
      vim.keymap.set("n", "<leader>fb", function() require("snacks").picker.buffers() end, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", function() require("snacks").picker.help() end, { desc = "Help Pages" })
      vim.keymap.set("n", "<leader>fk", function() require("snacks").picker.keymaps() end, { desc = "Keymaps" })
      vim.keymap.set("n", "<leader>fr", function() require("snacks").picker.recent() end, { desc = "Recent Files" })
      vim.keymap.set("n", "<leader>fs", function() require("snacks").picker.lsp_symbols() end, { desc = "LSP Symbols" })
      vim.keymap.set("n", "<leader>fS", function() require("snacks").picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
      vim.keymap.set("n", "<leader>fw", function() require("snacks").picker.grep_word() end, { desc = "Grep Word" })

      -- harpoon2 (Active Context Management)
      local harpoon = require("harpoon")
      harpoon:setup({})

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
      vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Quick menu" })
      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })

      -- mini.files (File System Management) — toggle based
      local MiniFiles = require("mini.files")
      MiniFiles.setup({
        windows = {
          preview = true,
          width_preview = 50,
        },
        options = {
          use_as_default_explorer = false,
        },
      })

      vim.keymap.set("n", "<leader>e", function()
        if MiniFiles.close() then
          -- was open, now closed
        else
          MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
        end
      end, { desc = "Mini Files: Toggle explorer" })

      -- flash.nvim (Intra-file Motion)
      require("flash").setup({
        modes = {
          search = { enabled = false },
          char = { enabled = true },
          treesitter = { enabled = true },
        },
        jump = {
          autojump = false,
          history = false,
          register = false,
        },
      })

      vim.keymap.set({"n", "x", "o"}, "<leader>j", function() require("flash").jump() end, { desc = "Flash: Jump" })
      vim.keymap.set({"n", "x", "o"}, "<leader>J", function() require("flash").treesitter() end, { desc = "Flash: Treesitter" })

      -- conform.nvim (Formatting)
      require("conform").setup({
        formatters_by_ft = {
          -- LSP-provided formatting (gopls, rust-analyzer, vtsls, etc.)
          go         = { "lsp" },
          rust       = { "lsp" },
          -- Standalone formatters
          nix        = { "nixpkgs-fmt" },
          lua        = { "stylua" },
          python     = { "ruff" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          json       = { "prettierd", "prettier", stop_after_first = true },
          yaml       = { "yamlfmt" },
          bash       = { "shfmt" },
          markdown   = { "prettierd", "prettier", stop_after_first = true },
          -- Fallback: use any LSP that provides formatting
          ["_"] = { "lsp" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 1000,
        },
      })

      -- Format keymap
      vim.keymap.set({"n", "v"}, "<leader>F", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format" })

      -- Smart scroll: <C-d>/<C-e> scroll half page then center cursor
      vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page, cursor center" })
      vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page, cursor center" })
      vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = "Scroll down full page, cursor center" })
      vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Scroll up full page, cursor center" })

      -- Also center after search motions
      vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, cursor center" })
      vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result, cursor center" })

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
    '';
  };
}
