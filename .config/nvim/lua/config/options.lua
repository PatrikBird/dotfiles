vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Editor UI
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.o.showmode = false
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i:ver25-Cursor/lCursor"

-- Indentation and Formatting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Search Behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- File Management
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Editor Behavior
vim.opt.virtualedit = "block"
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Userful converts
vim.keymap.set(
	"n",
	"<leader>kc",
	"viw:s/\\([a-z]\\)\\([A-Z]\\)/\\1-\\l\\2/g<CR>",
	{ desc = "Convert camelCase to kebab-case for current word" }
)

-- Remaps
vim.keymap.set("n", "<leader>r", "<cmd>source $MYVIMRC<CR>", { desc = "Reload nvim cfg" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "quit file" })

-- Better yanking
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Better deletion
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "<leader>D", [["_D]], { desc = "Delete to end without yanking" })
