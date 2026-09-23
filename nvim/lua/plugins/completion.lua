-- blink.cmp v1.x — LSP-powered completion
-- Docs: https://cmp.saghen.dev

require("blink.cmp").setup({
  -- Keymap: Tab/S-Tab to navigate, Enter to confirm, Esc to close
  keymap = { preset = "enter" },

  -- Sources
  sources = {
    default = { "lsp", "path", "buffer" },
  },

  -- Completion menu
  completion = {
    -- Always show menu while typing (don't wait for explicit trigger)
    trigger = {
      show_on_keyword = true,
      show_on_trigger_character = true,
    },
    menu = {
      border = "rounded",
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" },
        },
      },
    },
    -- Show docs alongside the menu — large enough for full docstrings + examples
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = {
        border = "rounded",
        min_width = 60,
        max_width = 120,
        max_height = 30,
      },
    },
  },
})

-- Wire blink's extended capabilities into every LSP server.
-- This is required with nvim 0.12 native vim.lsp.config so that
-- servers (e.g. pyright) know to send completion items.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
