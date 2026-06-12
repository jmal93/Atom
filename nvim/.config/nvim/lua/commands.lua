vim.api.nvim_create_user_command("PackDel", function(opts)
	vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2 ...)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	vim.pack.update(opts.fargs)
end, { desc = "Update plugins" })
