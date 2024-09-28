return {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>ff", function() builtin.find_files({ hidden = false }) end, {})
    vim.keymap.set("n", "<Leader>fF", function() builtin.find_files({ hidden = true }) end, {})
    vim.keymap.set("n", "<Leader>fw", function() builtin.live_grep() end, {})
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = { require("telescope.actions").move_selection_next, type = "action", opts = { nowait = true, silent = true } },
            ["<C-k>"] = { require("telescope.actions").move_selection_previous, type = "action", opts = { nowait = true, silent = true } },
          }
        }
      }
    })
  end
}
