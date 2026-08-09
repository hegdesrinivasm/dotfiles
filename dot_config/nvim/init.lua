-- ==========================================================
-- nvim init.lua
-- Managed by chezmoi: dot_config/nvim/init.lua
-- -> ~/.config/nvim/init.lua
-- ==========================================================

-- ==========================================================
-- 1. Options
-- ==========================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- ==========================================================
-- 2. Colorscheme (built-in)
-- ==========================================================
vim.cmd.colorscheme("habamax")
-- Alternatives: vim.cmd.colorscheme("gruvbox") or ("desert")

-- ==========================================================
-- 3. Keymaps
-- ==========================================================
vim.g.mapleader = " "
vim.g.localleader = " "
vim.g.netrw_banner = 0

-- Save
vim.keymap.set("n", "<Space>s", ":write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<C-s>", ":write<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:write<CR>", { desc = "Save file" })

-- Quit
vim.keymap.set("n", "<Space>q", ":quit<CR>", { desc = "Quit nvim" })

-- File explorer (netrw)
vim.keymap.set("n", "<Space>e", ":Explore<CR>", { desc = "Open file explorer" })

-- Toggle relative line numbers
vim.keymap.set("n", "<Space>n", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resize
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ==========================================================
-- 4. Autocmds
-- ==========================================================
local augroup = vim.api.nvim_create_augroup("nvim_init", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- Rebalance splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  command = "wincmd =",
})

-- ==========================================================
-- 5. Built-in LSP (nvim >= 0.11)
-- ----------------------------------------------------------
-- Language servers must be installed separately, e.g.:
--   lua_ls   -> `brew install lua-language-server` (or distro pkg)
--   bashls   -> `npm install -g bash-language-server`
--   pyright  -> `npm install -g pyright`
--   ts_ls    -> `npm install -g typescript-language-server typescript`
--   jsonls   -> `npm install -g vscode-langservers-extracted`
--   yamlls   -> `npm install -g yaml-language-server`
-- Check with `:checkhealth lsp`.
-- ==========================================================
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          documentationFormat = { "markdown", "plaintext" },
          snippetSupport = true,
        },
      },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "bashls",
  "pyright",
  "ts_ls",
  "jsonls",
  "yamlls",
})

-- LSP keymaps, active only while a server is attached
local lsp_group = vim.api.nvim_create_augroup("nvim_lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(event)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("K", vim.lsp.buf.hover, "Hover")
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "References")
    map("<Space>rn", vim.lsp.buf.rename, "Rename")
    map("<Space>ca", vim.lsp.buf.code_action, "Code action")
  end,
})

-- ==========================================================
-- 6. PLUGINS: lazy.nvim goes here (when ready)
-- ----------------------------------------------------------
-- 1. Install lazy.nvim once:
--    git clone --filter=blob:none \
--      https://github.com/folke/lazy.nvim.git \
--      ~/.local/share/nvim/lazy/lazy.nvim
-- 2. Bootstrap and add plugins here, e.g.:
--    require("lazy").setup({
--      { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
--      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
--      -- ...
--    })
-- ==========================================================
