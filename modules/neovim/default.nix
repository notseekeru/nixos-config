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
      -- Leader key MUST be set before any <leader> keymaps
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

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

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Quick menu" })
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })

      -- mini.files (File System Management)
      require("mini.files").setup({
        windows = {
          preview = true,
          width_preview = 50,
        },
        options = {
          use_as_default_explorer = false,
        },
      })

      vim.keymap.set("n", "<leader>e", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, { desc = "Mini Files: Open explorer" })
      vim.keymap.set("n", "<leader>E", function() require("mini.files").open(vim.loop.cwd(), false) end, { desc = "Mini Files: Open cwd" })

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
