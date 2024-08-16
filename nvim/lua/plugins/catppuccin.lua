return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      no_italic = true,
      styles = {
        comments = {},
        conditionals = {},
      }
    })
    vim.cmd.colorscheme "catppuccin-macchiato"
  end
}
