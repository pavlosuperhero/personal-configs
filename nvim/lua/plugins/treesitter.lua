local ts = require("nvim-treesitter")
ts.setup()

local ensure_installed = {
  "lua",
  "vim",
  "vimdoc",
  "query",
  "python",
  "bash",
  "hcl",
  "terraform",
  "markdown",
  "markdown_inline",
  "json",
  "yaml",
}

-- install any parser that isn't already on disk, then enable highlighting for it
ts.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  pattern = ensure_installed,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
