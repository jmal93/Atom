return {
	{
		"mason-org/mason.nvim",
		opts = {},
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Open Mason" },
			{ "<leader>l", "<cmd>Lazy<cr>", desc = "Open Lazy" },
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			vim.lsp.config("html", {
				filetypes = { "htmldjango", "html" },
			})

			vim.lsp.config("qmlls", {
				cmd = { "/usr/lib/qt6/bin/qmlls", "-E" },
				filetypes = { "qml" },
			})
			vim.lsp.enable("qmlls")
		end,
		opts = {},
		keys = {
			{
				"<leader>ca",
				function()
					vim.lsp.buf.code_action()
				end,
				desc = "Code actions",
			},
		},
	},
}
