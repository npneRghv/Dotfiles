-- ~/AppData/Local/nvim/init.lua
-- Minimal, plugin-free Neovim + Neovide config with sane defaults.
-- Preferred config language for modern Neovim is Lua (this file). Vimscript still
-- works, but Lua is the native, faster, better-supported path going forward.

--------------------------------------------------------------------------------
-- Leader (must be set before any mappings). Space, to match your IDE vim setup.
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- General options
--------------------------------------------------------------------------------
local o = vim.opt

-- Line numbers (relative + absolute, like your .vimrc)
o.number = true
o.relativenumber = true

-- Indentation: spaces, 4 wide (matches your .vimrc)
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.autoindent = true
o.smartindent = true

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Mouse
o.mouse = "a"

-- Scrolling context
o.scrolloff = 5
o.sidescrolloff = 10

-- Wrapping off (matches your .vimrc)
o.wrap = false

-- Splits open where you'd expect
o.splitright = true
o.splitbelow = true

-- UI niceties
o.termguicolors = true        -- 24-bit color (essential for good themes)
o.cursorline = true           -- highlight the current line
o.signcolumn = "yes"          -- reserve gutter so text doesn't jump
o.laststatus = 3              -- single global statusline
o.showmode = false            -- mode already shown; keep the cmdline clean
o.confirm = true              -- ask to save instead of erroring on :q
o.updatetime = 250
o.timeoutlen = 400

-- System clipboard so yank/paste crosses into Windows apps
o.clipboard = "unnamedplus"

-- Persistent undo instead of littering backup/swap files everywhere
o.swapfile = false
o.backup = false
o.undofile = true

--------------------------------------------------------------------------------
-- Colorscheme (catppuccin ships built-in with nvim 0.12; no plugin needed)
--------------------------------------------------------------------------------
-- The bundled catppuccin picks its flavour from 'background':
--   light -> Latte (chosen here),  dark -> Mocha.
vim.o.background = "light"
pcall(vim.cmd.colorscheme, "catppuccin")

--------------------------------------------------------------------------------
-- Neovide-only settings (ignored by terminal nvim)
--------------------------------------------------------------------------------
if vim.g.neovide then
  -- Font. Cascadia Code has ligatures, which Neovide renders automatically.
  vim.o.guifont = "Cascadia Code:h9"
  vim.o.linespace = 2

  -- Breathing room around the edges
  vim.g.neovide_padding_top = 8
  vim.g.neovide_padding_bottom = 8
  vim.g.neovide_padding_left = 8
  vim.g.neovide_padding_right = 8

  -- Smooth, snappy feel
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_cursor_animation_length = 0.06
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_hide_mouse_when_typing = true

  -- Remember window size/position between launches
  vim.g.neovide_remember_window_size = true

  -- A hint of floating-window blur (kept subtle; text stays fully opaque)
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_normal_opacity = 1.0

  -- Zoom with Ctrl +/-/0
  vim.g.neovide_scale_factor = 1.0
  local function scale(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function() scale(1.1) end, { desc = "Neovide zoom in" })
  vim.keymap.set("n", "<C-->", function() scale(1 / 1.1) end, { desc = "Neovide zoom out" })
  vim.keymap.set("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { desc = "Neovide zoom reset" })
end

--------------------------------------------------------------------------------
-- A few sane keymaps (leader = Space)
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Move visual selection up/down and keep it selected
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

--------------------------------------------------------------------------------
-- Highlight yanked text briefly (nice built-in feedback, no plugin)
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})
