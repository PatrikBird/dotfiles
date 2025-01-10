return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({
						async = true,
						lsp_fallback = true,
					})
				end,
				mode = { "n", "v" },
				desc = "Format file or range (in visual mode)",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				vue = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
			},
		},
	},
}
