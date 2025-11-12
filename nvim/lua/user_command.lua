vim.api.nvim_create_user_command(
  'InitLua',
  function()
    vim.cmd.edit(vim.fn.stdpath('config') .. '/init.lua')
  end,
  { desc = 'Open init.lua' }
)

vim.api.nvim_create_user_command(
  'CopyRelativePath',
  function()
    local relative_path = vim.fn.expand("%:~:.")
    vim.fn.setreg("+", relative_path)
    vim.notify("Copy: " .. relative_path)
  end,
  { desc = 'Copy current buffer relative path' }
)
