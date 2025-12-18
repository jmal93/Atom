return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {},
		keys = {
			{ "<leader>fs", "<cmd>Neotree<cr>", desc = "Show file system" },
			{ "<leader>fc", "<cmd>Neotree close<cr>", desc = "Close file system" },
		},
	},
}
