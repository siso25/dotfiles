return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    vim.keymap.set({"n", "t"}, "<f7>", "<Cmd>ToggleTerm<CR>", {}),
    direction = "float",
    float_opts = { border = "rounded" }
  },
}
