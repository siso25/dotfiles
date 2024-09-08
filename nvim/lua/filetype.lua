local M = {}

local function set_indent(tab_length, is_soft_tab)
  vim.bo.expandtab = is_soft_tab
  vim.bo.shiftwidth = tab_length
  vim.bo.softtabstop = tab_length
  vim.bo.tabstop = tab_length
end

M.help = function()
  vim.api.nvim_buf_set_keymap(0, "n", "q", "ZZ", { noremap = true })
end

M.markdown = function()
  set_indent(4, true)
end

M.text = function()
  set_indent(4, false)
end

return setmetatable(M, {
  __index = function()
    return function()
      set_indent(2, true)
    end
  end
})
