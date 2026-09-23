-- native Neovim plugin manager (nvim 0.12+), replaces lazy.nvim
local specs = {
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/coder/claudecode.nvim",
}

-- telescope-fzf-native ships a C extension; build it whenever installed/updated
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name ~= "telescope-fzf-native.nvim" then
      return
    end
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
      return
    end
    local cwd = ev.data.path
    vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" }, { cwd = cwd }):wait()
    vim.system({ "cmake", "--build", "build", "--config", "Release" }, { cwd = cwd }):wait()
    vim.system({ "cmake", "--install", "build", "--prefix", "build" }, { cwd = cwd }):wait()
  end,
})

vim.pack.add(specs, { load = true })

require("plugins.theme")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.nvim-tree")
require("plugins.lazygit")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.claudecode")
