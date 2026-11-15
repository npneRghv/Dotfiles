-- Neovim configuration (Lua equivalent of legacy .vimrc)
-- Reference: ~/.config/nvim/legacy.vim

-- ============================================
-- Basic options
-- ============================================
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- ============================================
-- Mouse support
-- ============================================
vim.opt.mouse = "a"

-- ============================================
-- Backup / swap
-- ============================================
vim.opt.backup = true
vim.opt.swapfile = true
vim.opt.backupdir = vim.fn.expand("~/.vim/backup") .. "," .. "."
vim.opt.directory = vim.fn.expand("~/.vim/swap")

-- ============================================
-- Search
-- ============================================
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ============================================
-- Indentation
-- ============================================
vim.opt.autoindent = true
vim.opt.smartindent = true

-- ============================================
-- Scroll
-- ============================================
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 10

-- ============================================
-- Colors
-- ============================================
vim.opt.termguicolors = true
vim.cmd("syntax on")

-- ============================================
-- GUI / Neovide settings
-- ============================================
if vim.g.neovide then
  -- Font
  vim.o.guifont = "Noto Sans Mono :h9"

  -- Window size (approximate equivalent of lines=50 columns=95)
  -- Neovide sets these via command-line args, not config vars

  -- Hide menu bar, toolbar, scrollbar
  vim.g.neovide_hide_menu = true
  vim.g.neovide_hide_toolbar = true
  vim.g.neovide_opacity = 1.0

  -- Cursor
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.3
end

-- ============================================
-- Leader / Local leader
-- ============================================
vim.g.mapleader = " "
vim.g.localleader = "\\"

-- ============================================
-- Pane navigation (leader + h/j/k/l)
-- ============================================
vim.api.nvim_set_keymap("n", "<Leader>h", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>j", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>k", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>l", "<C-w>l", { noremap = true })

-- ============================================
-- Tab navigation (leader + comma/period)
-- ============================================
vim.api.nvim_set_keymap("n", "<Leader>,", "gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>.", "gT", { noremap = true })

-- ============================================
-- Pane resize (leader + p + h/j/k/l)
-- ============================================
vim.api.nvim_set_keymap("n", "<LocalLeader>h", "<C-w><", { noremap = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>j", "<C-w>+", { noremap = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>k", "<C-w>-", { noremap = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>l", "<C-w>>", { noremap = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>=", "<C-w>=", { noremap = true })

-- ============================================
-- Pane swap (leader + H/J/K/L)
-- ============================================
vim.api.nvim_set_keymap("n", "<Leader>H", "<C-w>H", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>J", "<C-w>J", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>K", "<C-w>K", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>L", "<C-w>L", { noremap = true })

-- ============================================
-- Maximize/unmaximize (leader + > / <)
-- ============================================
vim.api.nvim_set_keymap("n", "<Leader>>", "<C-w_F>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader><", "<C-w_R>", { noremap = true })

-- ============================================
-- Terminal mode toggle
-- ============================================
vim.api.nvim_set_keymap("t", "<C-o>", "<C-\\><C-n>", { noremap = true })

-- ============================================
-- Status / wrap
-- ============================================
vim.opt.laststatus = 2
vim.opt.wrap = false
