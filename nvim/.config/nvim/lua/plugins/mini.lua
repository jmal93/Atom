require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.completion").setup()
require("mini.icons").setup()
local mini_snippets = require("mini.snippets")
mini_snippets.setup({
	snippets = {
		mini_snippets.gen_loader.from_lang(),
	},
})
require("mini.splitjoin").setup()
require("mini.notify").setup()
