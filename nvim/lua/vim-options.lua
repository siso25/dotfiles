local opt = vim.opt

--------------------
---
--- 一般的な設定
---
--------------------
opt.backup = false
opt.swapfile = false
opt.undofile = false
opt.autoread = true
opt.showcmd = true
opt.autoindent = true
opt.errorbells = false
opt.fileformats = 'unix','dos','mac'
opt.fixeol = false
opt.mouse = a
opt.clipboard:append{ "unnamedplus" }
opt.cp = false
opt.wrap = false

--------------------
---
--- 見た目の調整
---
--------------------
opt.number = true
opt.cursorline = true
opt.showmatch = true
opt.laststatus = 2
opt.title = true
opt.list = true
opt.listchars = { space = "･", tab = ">･" }
opt.guifont = "HackGen Console NF:h12"
opt.guifontwide = "HackGen Console NF:h12"
opt.termguicolors = true
opt.winblend = 0
opt.pumblend = 0

--------------------
---
--- 検索系
---
--------------------
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

--------------------
---
--- キーマップ
---
--------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = ","

map("n", "<Leader>c", ":bd<CR>", opts)
map("n", "<Leader>C", ":bd!<CR>", opts)
map("n", "U", "<C-r>", opts)
map("n", "J", "10j", opts)
map("n", "K", "10k", opts)
map("n", "<C-q>", ":qa<CR>", opts)
map("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)
map("n", "<tab>", ">>", opts)
map("n", "<S-tab>", "<<", opts)
map("n", "]b", ":bn<CR>", opts)
map("n", "[b", ":bp<CR>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<ESC>:w<CR>", opts)
map("i", "<tab>", "<C-t>", opts)
map("i", "<S-tab>", "<C-d>", opts)
map("i", "jj", "<ESC>", opts)
map("v", "<tab>", ">", opts)
map("v", "<S-tab>", "<", opts)
