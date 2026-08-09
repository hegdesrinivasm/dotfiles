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
