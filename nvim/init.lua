local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

local my_filetype = require("filetype")
vim.api.nvim_create_augroup("init_augroup", {})
vim.api.nvim_create_autocmd("FileType", {
  group = "init_augroup",
  pattern = "*",
  callback = function(args) my_filetype[args.match]() end
})

vim.fn.setcellwidths {
  { 0x2605, 0x2605, 2 },
}
