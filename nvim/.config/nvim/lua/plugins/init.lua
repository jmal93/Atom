vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/windwp/nvim-ts-autotag",
})

require("mason").setup()
require("mason-lspconfig").setup()

require("plugins.mini")

require("oil").setup()

require("gitsigns").setup()

require("trouble").setup()

require("nvim-treesitter").setup()

require("nvim-ts-autotag").setup()

vim.cmd.colorscheme("gruvbox-material")
