local function check_npm()
  if vim.fn.executable("npm") == 0 then
    vim.schedule(function()
      vim.notify(
        "npm not found on PATH: Mason won't be able to install pyright/bashls/lua_ls",
        vim.log.levels.WARN
      )
    end)
  end
end

-- Windows commonly only exposes the "py" launcher, not "python" on PATH.
-- Resolve the real interpreter so pyright can find installed packages.
local function resolve_python_path()
  local candidates = { "python", "py" }
  for _, cmd in ipairs(candidates) do
    if vim.fn.executable(cmd) == 1 then
      local out = vim.fn.system({ cmd, "-c", "import sys; print(sys.executable)" })
      if vim.v.shell_error == 0 then
        return vim.trim(out)
      end
    end
  end
  return nil
end

check_npm()
require("mason").setup()

require("mason-lspconfig").setup({
  -- installs any missing server automatically on startup
  ensure_installed = {
    "pyright", -- python
    "terraformls", -- terraform
    "bashls", -- bash
    "powershell_es", -- powershell
    "lua_ls", -- lua (this config)
  },
  automatic_installation = true,
})

local servers = { "pyright", "terraformls", "bashls", "powershell_es", "lua_ls" }

local python_path = resolve_python_path()
vim.lsp.config("pyright", {
  settings = python_path and {
    python = { pythonPath = python_path },
  } or nil,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.enable(servers)

-- keymaps active only in buffers with an attached LSP client
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>gk", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- auto-show hover documentation after the cursor is idle (updatetime, see options.lua)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.lsp.buf.hover()
  end,
})
