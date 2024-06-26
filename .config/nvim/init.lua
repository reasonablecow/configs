-- Set Options
-- Show line numbers: vim.fandom.com/wiki/Display_line_numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Keeps at least this number of lines above or below while scrolling.
vim.opt.scrolloff = 8

-- Searching case sensitivity: vim.fandom.com/wiki/Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Show invisible characters: vim.fandom.com/wiki/Highlight_unwanted_spaces
vim.opt.list = true
vim.opt.listchars = 'eol:$,trail:?,tab:\\t'

-- Line and column highlighting: vim.fandom.com/wiki/Highlight_current_line
vim.opt.cursorline = true
vim.opt.colorcolumn = {72, 80, 100}

-- Indentation: vim.fandom.com/wiki/Indenting_source_code
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 8
vim.opt.smarttab = true

-- Folding: https://neovim.io/doc/user/fold.html
vim.opt.foldmethod = 'indent'

vim.opt.spell = true

vim.g.mapleader = ' '


-- Remaps
vim.keymap.set({'n', 'v'}, '<Space>', '<NOP>')
vim.keymap.set('n', '<leader>n', ':tab split<CR>:Ex<CR>')
vim.keymap.set({'n', 'v'}, '<leader>p', '\"_c<Esc>p')
vim.keymap.set('n', '<leader>d', '3G5|"+yE')

-- Automatic commands
-- Keep clipboard data after leave
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "call system('xclip -selection c', getreg('+'))",
})

-- https://stackoverflow.com/a/77415842/17709794
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler,
-- for a commit or rebase message
-- (likely a different one than last time), and when using xxd(1) to filter
-- and edit binary files (it transforms input files back and forth, causing
-- them to have dual nature, so to speak)
function RestoreCursorPosition()
  local line = vim.fn.line("'\"")
  if line > 1 and line <= vim.fn.line("$") and vim.bo.filetype ~= 'commit' and vim.fn.index({'xxd', 'gitrebase'}, vim.bo.filetype) == -1 then
    vim.cmd('normal! g`"')
  end
end

if vim.fn.has("autocmd") then
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    command = "lua RestoreCursorPosition()",
  })
end

-- Plugins
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'morhetz/gruvbox'
  -- Waits for neovim 0.8+
  -- use({
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("oil").setup()
  --   end,
  -- })
end)
