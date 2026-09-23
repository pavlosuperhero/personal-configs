local harpoon = require("harpoon")
harpoon:setup()

local map = vim.keymap.set

map("n", "<leader>xa", function()
  harpoon:list():add()
end, { desc = "Harpoon: add file" })

map("n", "<leader>xr", function()
  harpoon:list():remove()
end, { desc = "Harpoon: remove file" })

map("n", "<leader>xx", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: toggle menu" })

for i = 1, 4 do
  map("n", "<leader>x" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon: file " .. i })
end
