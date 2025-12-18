local tabsize = 2
vim.o.tabstop = tabsize
vim.o.softtabstop = tabsize
vim.o.shiftwidth = tabsize
vim.o.expandtab = true

vim.wo.relativenumber = true
vim.wo.number = true

vim.o.scrolloff = 8

vim.opt.clipboard = "unnamedplus"

require("config.lazy")

