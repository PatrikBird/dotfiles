return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- always use latest git commit
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional dependencies
			"nvim-tree/nvim-web-devicons", -- nice to have
			-- file browser extension
			{ "nvim-telescope/telescope-file-browser.nvim" },
			-- native sorter (optional)
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			-- add your keymaps
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		},
		config = function()
			require("telescope").setup({
				-- your telescope configuration here
			})
			-- load extensions if you want
			require("telescope").load_extension("file_browser")
			if vim.fn.executable("fzf") == 1 then
				require("telescope").load_extension("fzf")
			end
		end,
	},
}
