-- LSP configuration via vim.lsp.config (Neovim 0.11+ / lspconfig 2.x API)
-- All language servers are provided by Nix packages (see binaries.nix)
-- Server definitions are auto-loaded from lspconfig's lsp/ directory.
-- We only need to add our custom settings and enable the servers.

local capabilities = require("blink-cmp").get_lsp_capabilities()

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = { truncate_line = false },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Keymap helper for LSP buffers
local function on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
end

-- Custom server configurations (extend the defaults from lspconfig)
-- Only settings we need to override beyond the defaults from lsp/*.lua files.

--- Nix
vim.lsp.config.nil_ls = vim.tbl_deep_extend("force", vim.lsp.config.nil_ls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ['nil'] = {
      formatting = { command = { "nixpkgs-fmt" } },
    },
  },
})

--- Lua
vim.lsp.config.lua_ls = vim.tbl_deep_extend("force", vim.lsp.config.lua_ls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

--- Python
vim.lsp.config.pyright = vim.tbl_deep_extend("force", vim.lsp.config.pyright or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- TypeScript / JavaScript
vim.lsp.config.vtsls = vim.tbl_deep_extend("force", vim.lsp.config.vtsls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- Go
vim.lsp.config.gopls = vim.tbl_deep_extend("force", vim.lsp.config.gopls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})

--- Rust
vim.lsp.config.rust_analyzer = vim.tbl_deep_extend("force", vim.lsp.config.rust_analyzer or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = { command = "clippy" },
    },
  },
})

--- Bash
vim.lsp.config.bashls = vim.tbl_deep_extend("force", vim.lsp.config.bashls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- JSON
vim.lsp.config.jsonls = vim.tbl_deep_extend("force", vim.lsp.config.jsonls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- YAML
vim.lsp.config.yamlls = vim.tbl_deep_extend("force", vim.lsp.config.yamlls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- Dockerfile
vim.lsp.config.dockerls = vim.tbl_deep_extend("force", vim.lsp.config.dockerls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- Terraform
vim.lsp.config.terraformls = vim.tbl_deep_extend("force", vim.lsp.config.terraformls or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- C/C++
vim.lsp.config.clangd = vim.tbl_deep_extend("force", vim.lsp.config.clangd or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

--- Markdown
vim.lsp.config.marksman = vim.tbl_deep_extend("force", vim.lsp.config.marksman or {}, {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Enable all LSP servers
vim.lsp.enable({
  "nil_ls",
  "lua_ls",
  "dockerls",
  "terraformls",
  "clangd",
  "pyright",
  "vtsls",
  "gopls",
  "rust_analyzer",
  "bashls",
  "jsonls",
  "yamlls",
  "marksman",
})
