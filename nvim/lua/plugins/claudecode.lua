require("claudecode").setup({
  terminal = {
    provider = "native",
  },
})

vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Claude Code" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude Code" })
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer to Claude" })
vim.keymap.set("x", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude" })
