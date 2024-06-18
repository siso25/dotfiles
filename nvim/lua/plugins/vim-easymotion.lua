return {
  "easymotion/vim-easymotion",
  config = function()
    vim.g.EasyMotion_use_migemo = 1
    vim.keymap.set("n", "f", "<Plug>(easymotion-f)", {})
    vim.keymap.set("n", "F", "<Plug>(easymotion-F)", {})
  end
}
