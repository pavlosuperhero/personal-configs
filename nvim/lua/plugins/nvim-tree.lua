require("nvim-tree").setup({
  view = { width = 35 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
