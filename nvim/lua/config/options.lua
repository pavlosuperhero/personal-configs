vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt

o.number = true
o.relativenumber = true
o.termguicolors = true
o.signcolumn = "yes"
o.cursorline = true

o.mouse = "a"
o.clipboard = "unnamedplus"

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

o.ignorecase = true
o.smartcase = true

o.splitright = true
o.splitbelow = true

o.updatetime = 4000 -- hover doc popup delay (CursorHold)

o.undofile = true
o.scrolloff = 8
