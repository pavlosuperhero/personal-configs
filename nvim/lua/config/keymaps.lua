local map = vim.keymap.set

-- window splits
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
map("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split window horizontally" })

-- window navigation between splits
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>w<Left>", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>w<Down>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<leader>w<Up>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<leader>w<Right>", "<C-w>l", { desc = "Go to right window" })

-- terminal
map("n", "<leader>t", function()
    vim.cmd("botright 12split")
    vim.cmd("terminal")
    vim.cmd("startinsert")
end, { desc = "Open terminal at bottom" })
map("t", "<C-t>n", [[<C-\><C-n>]], { desc = "Terminal normal mode" })

-- open netrw at the current file's directory (like ":e .")
map("n", "<leader>b", "<cmd>e .<cr>", { desc = "Browse current directory" })
