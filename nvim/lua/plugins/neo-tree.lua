return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
    require("neo-tree").setup({
      window = {
        position = "left",
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node"
        }
      }
    })
  end
}
