return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- your custom ts_ls setup
				tsserver = {
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
								languages = { "javascript", "typescript", "vue" },
							},
						},
					},
					filetypes = { "javascript", "typescript", "vue" },
				},
			},
		},
	},
}
