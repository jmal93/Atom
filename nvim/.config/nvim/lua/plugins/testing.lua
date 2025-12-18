return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rouge8/neotest-rust",
		},
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Test nearest",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Test file",
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-rust"),
					require("neotest-python"),
				},
			})
		end,
	},
	{
		"andythigpen/nvim-coverage",
		version = "*",
		keys = {
			{
				"<leader>tc",
				function()
					require("coverage").toggle()
				end,
				desc = "Show test coverage",
			},
			{
				"<leader>ts",
				function()
					require("coverage").summary()
				end,
				desc = "Show test coverage summary",
			},
			{
				"<leader>tl",
				function()
					require("coverage").load()
				end,
				desc = "Load test coverage file",
			},
		},
		config = function()
			require("coverage").setup({
				commands = true, -- create commands
				highlights = {
					covered = { fg = "#C3E88D" },
					uncovered = { fg = "#F07178" },
				},
				signs = {
					covered = { hl = "CoverageCovered", text = " >" },
					uncovered = { hl = "CoverageUncovered", text = " >" },
				},
				summary = {
					-- customize the summary pop-up
					min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
				},
			})
		end,
	},
}
