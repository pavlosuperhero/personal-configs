-- Neovim startup banner
-- Pure Lua, no external plugins required. Fires only when nvim opens with no files.

local M = {}

local art = {
  "                                                              ",
  "   █████╗ ██╗                                                ",
  "  ██╔══██╗██║                                                ",
  "  ███████║██║   is a tool for experts                        ",
  "  ██╔══██║██║                                                ",
  "  ██║  ██║██║                                                ",
  "  ╚═╝  ╚═╝╚═╝                                                ",
  "                                                              ",
  "                  pavlosuperhero                              ",
  "             Senior DevOps Engineer                           ",
  "          github.com/pavlosuperhero                           ",
  "                                                              ",
  "       [ q ] quit         [ <CR> ] new file                   ",
  "                                                              ",
}

local function pad_center(line, total_width)
  local line_width = vim.fn.strdisplaywidth(line)
  local pad = math.max(0, math.floor((total_width - line_width) / 2))
  return string.rep(" ", pad) .. line
end

local function create_banner()
  local buf = vim.api.nvim_create_buf(false, true)

  vim.bo[buf].buftype    = "nofile"
  vim.bo[buf].bufhidden  = "wipe"
  vim.bo[buf].swapfile   = false
  vim.bo[buf].modifiable = true
  vim.bo[buf].filetype   = "alpha"

  local cols  = vim.o.columns
  local rows  = vim.o.lines
  local n_art = #art

  local v_pad = math.max(0, math.floor((rows - n_art) / 2) - 1)
  local v_lines = {}
  for _ = 1, v_pad do
    v_lines[#v_lines + 1] = ""
  end

  local centered = {}
  for _, line in ipairs(art) do
    centered[#centered + 1] = pad_center(line, cols)
  end

  local all_lines = {}
  for _, l in ipairs(v_lines)  do all_lines[#all_lines + 1] = l end
  for _, l in ipairs(centered) do all_lines[#all_lines + 1] = l end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)
  vim.bo[buf].modifiable = false

  -- "AI" big letters  (art lines 1-6, 0-indexed = v_pad .. v_pad+6)
  for i = v_pad, v_pad + 6 do
    vim.api.nvim_buf_add_highlight(buf, -1, "Title", i, 0, -1)
  end
  -- name
  vim.api.nvim_buf_add_highlight(buf, -1, "Title",   v_pad + 8,  0, -1)
  -- job title
  vim.api.nvim_buf_add_highlight(buf, -1, "Comment", v_pad + 9,  0, -1)
  -- github
  vim.api.nvim_buf_add_highlight(buf, -1, "Special", v_pad + 10, 0, -1)
  -- hint
  vim.api.nvim_buf_add_highlight(buf, -1, "Comment", v_pad + 12, 0, -1)

  vim.api.nvim_win_set_buf(0, buf)

  local opts = { noremap = true, silent = true, buffer = buf }
  vim.keymap.set("n", "q",    "<Cmd>bd!<CR>",  opts)
  vim.keymap.set("n", "<CR>", "<Cmd>enew<CR>", opts)

  vim.wo.cursorline     = false
  vim.wo.signcolumn     = "no"
  vim.wo.number         = false
  vim.wo.relativenumber = false
end

M.setup = function()
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
      if vim.fn.argc() == 0 then
        vim.schedule(create_banner)
      end
    end,
  })
end

M.setup()

return M
