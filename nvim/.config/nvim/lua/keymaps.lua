vim.g.mapleader = " "

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- mason
vim.keymap.set("n", "<leader>m", ":Mason<CR>", { desc = "Open mason" })

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Format code" })

-- oil
vim.keymap.set("n", "<leader>fs", ":Oil<CR>", { desc = "Open file system" })

-- trouble
vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
