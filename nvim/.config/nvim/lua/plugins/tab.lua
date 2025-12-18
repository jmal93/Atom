return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
    lazy = false,
		keys = {
			-- Move to previous/next
			{ "<leader>,", "<Cmd>BufferPrevious<CR>" },
			{ "<leader>.", "<Cmd>BufferNext<CR>" },

			-- Re-order to previous/next
			{ "<leader><", "<Cmd>BufferMovePrevious<CR>" },
			{ "<leader>>", "<Cmd>BufferMoveNext<CR>" },

			-- Pin/unpin buffer
			{ "<leader>p", "<Cmd>BufferPin<CR>" },

			-- Close buffer
			{ "<leader>C", "<Cmd>BufferClose<CR>" },

			-- Magic buffer-picking mode
			{ "<leader>p", "<Cmd>BufferPick<CR>" },
			{ "<leader>p", "<Cmd>BufferPickDelete<CR>" },

			-- Sort automatically by...
			{ "<leader>ebb", "<Cmd>BufferOrderByBufferNumber<CR>" },
			{ "<leader>ebn", "<Cmd>BufferOrderByName<CR>" },
			{ "<leader>ebd", "<Cmd>BufferOrderByDirectory<CR>" },
			{ "<leader>ebl", "<Cmd>BufferOrderByLanguage<CR>" },
			{ "<leader>ebw", "<Cmd>BufferOrderByWindowNumber<CR>" },

			-- Other:
			-- :BarbarEnable - enables barbar (enabled by default)
			-- :BarbarDisable - very bad command, should never be used
		},
		config = function()
			require("barbar").setup({
				animation = true,
				tabpages = true,
			})
		end,
	},
}
