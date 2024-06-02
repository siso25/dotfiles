return {
  "tpope/vim-commentary",
  config = function()
    vim.keymap.set("n", "<Leader>/", "<Plug>CommentaryLine", {})
    vim.keymap.set("v", "<Leader>/", "<Plug>Commentary", {})
  end
}
