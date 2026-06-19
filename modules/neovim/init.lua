vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("nvim-treesitter").setup({})

vim.keymap.set("n", "s", "<C-^>")

vim.keymap.set("n", "gg", "gg0")

vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")

vim.keymap.set("v", "J", "j")

vim.keymap.set("v", "K", "k")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-e>", "<C-u>zz", { noremap = true, silent = true })

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move down" })

vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move up" })

vim.keymap.set("n", "<C-a>", ":<C-u>normal! ggVG<CR>", { silent = true })

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

dofile(vim.fn.stdpath("config") .. "/lsp.lua")

require("codediff").setup({})

vim.keymap.set("n", "<leader>gf", ":CodeDiff HEAD<CR>", { desc = "CodeDiff: Toggle diff against HEAD" })

require("blink-cmp").setup({
	keymap = {
		preset = "default",
		["<C-Space>"] = { "show", "show_documentation" },
		["<C-e>"] = { "hide" },
		["<Tab>"] = { "accept", "fallback" },
		["<CR>"] = { "fallback" },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

require("snacks").setup({
	bigfile = { enabled = true },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true, style = "compact" },
	picker = { enabled = true },
	quickfile = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

vim.keymap.set("n", "<leader>ff", function()
	require("snacks").picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("snacks").picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("snacks").picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("snacks").picker.help()
end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>fk", function()
	require("snacks").picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fr", function()
	require("snacks").picker.recent()
end, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fs", function()
	require("snacks").picker.lsp_symbols()
end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>fS", function()
	require("snacks").picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })
vim.keymap.set("n", "<leader>fw", function()
	require("snacks").picker.grep_word()
end, { desc = "Grep Word" })

local harpoon = require("harpoon")
harpoon:setup({})

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Harpoon: Add file" })
vim.keymap.set("n", "<leader>he", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: Quick menu" })
vim.keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon: File 1" })
vim.keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon: File 2" })
vim.keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon: File 3" })
vim.keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon: File 4" })

vim.keymap.set("n", "<leader>e", function()
	require("snacks").explorer()
end, { desc = "Snacks: Toggle explorer" })

vim.keymap.set("n", "<leader>E", function()
	require("snacks").explorer({
		layout = {
			position = "right",
			width = 40,
		},
	})
end, { desc = "Snacks: Explorer right panel" })

vim.keymap.set("n", "<leader>gg", function()
	require("snacks").terminal("lazygit", { cwd = vim.fn.getcwd() })
end, { desc = "Lazygit" })

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

vim.keymap.set({ "n", "x", "o" }, "<leader>j", function()
	require("flash").jump()
end, { desc = "Flash: Jump" })
vim.keymap.set({ "n", "x", "o" }, "<leader>J", function()
	require("flash").treesitter()
end, { desc = "Flash: Treesitter" })

require("conform").setup({
	formatters_by_ft = {
		go = { "lsp" },
		rust = { "lsp" },
		nix = { "nixpkgs-fmt" },
		lua = { "stylua" },
		python = { "ruff" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "yamlfmt" },
		bash = { "shfmt" },
		dockerfile = { "hadolint" },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		["_"] = { "lsp" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 1000,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>F", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format" })

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

-- Autosave: save automatically on certain events
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedI" }, {
	pattern = "*",
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" then
			vim.cmd.write()
		end
	end,
})
