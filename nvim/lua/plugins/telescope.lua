local telescope = require("telescope")

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },
})
pcall(telescope.load_extension, "fzf")

local map = vim.keymap.set
map("n", "<leader>.", "<cmd>Telescope live_grep<cr>", { desc = "Search text (live grep)" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
