vim.opt.clipboard:append('unnamedplus,unnamed')
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.scrolloff = 3
vim.opt.whichwrap = 'b,s,h,l,<,>,[,],~'

require('user_command')

-- augroup for this config file
local augroup = vim.api.nvim_create_augroup('init.lua', {})

-- wrapper function to use internal augroup
local function create_autocmd(event, opts)
  vim.api.nvim_create_autocmd(event, vim.tbl_extend('force', {
    group = augroup,
  }, opts))
end

-- https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(event)
    local dir = vim.fs.dirname(event.file)
    local force = vim.v.cmdbang == 1
    if vim.fn.isdirectory(dir) == 0
        and (force or vim.fn.confirm('"' .. dir .. '" does not exist. Create?', "&Yes\n&No") == 1) then
      vim.fn.mkdir(vim.fn.iconv(dir, vim.opt.encoding:get(), vim.opt.termencoding:get()), 'p')
    end
  end,
  desc = 'Auto mkdir to save file'
})

-- keymap
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = ","

map("n", "<Leader>c", ":bd<CR>", opts)
map("n", "<Leader>C", ":bd!<CR>", opts)
map("n", "U", "<C-r>", opts)
map("n", "J", "10j", opts)
map("n", "K", "10k", opts)
map("n", "<C-q>", ":qa<CR>", opts)
map("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<tab>", ">>", opts)
map("n", "<S-tab>", "<<", opts)
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)
map("i", "<tab>", "<C-t>", opts)
map("i", "<S-tab>", "<C-d>", opts)
map("v", "<tab>", ">", opts)
map("v", "<S-tab>", "<", opts)
map("n", "<Leader>y", "<cmd>CopyRelativePath<CR>", opts)

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require('mini.icons').setup()
end)

now(function()
  require('mini.basics').setup()
end)

later(function()
  add('https://github.com/vim-jp/vimdoc-ja')
  -- Prefer Japanese as the help language
  vim.opt.helplang:prepend('ja')
end)

now(function()
  require('mini.statusline').setup()
  vim.opt.laststatus = 3
  vim.opt.cmdheight = 0

  create_autocmd({ 'RecordingEnter', 'CmdlineEnter' }, {
    pattern = '*',
    callback = function()
      vim.opt.cmdheight = 1
    end,
  })
  create_autocmd('RecordingLeave', {
    pattern = '*',
    callback = function()
      vim.opt.cmdheight = 0
    end,
  })
  create_autocmd('CmdlineLeave', {
    pattern = '*',
    callback = function()
      if vim.fn.reg_recording() == '' then
        vim.opt.cmdheight = 0
      end
    end,
  })
end)

now(function ()
  require('mini.misc').setup()
  MiniMisc.setup_restore_cursor()
  vim.api.nvim_create_user_command('Zoom', function()
    MiniMisc.zoom(0, {})
  end, { desc = 'Zoom current buffer' })
end)

now(function()
  require('mini.notify').setup()

  vim.notify = require('mini.notify').make_notify({})
end)

now(function()
  add({ source = "catppuccin/nvim", name = "catppuccin" })
  vim.cmd.colorscheme('catppuccin-macchiato')
end)

later(function()
  require('mini.cursorword').setup()
end)

later(function()
  require('mini.indentscope').setup()
end)

later(function()
  require('mini.trailspace').setup()
end)

now(function()
  require('mini.starter').setup()
end)

later(function()
  require('mini.pairs').setup()
end)

now(function()
  require('lsp')
end)

later (function()
  require('mini.fuzzy').setup()
  require('mini.completion').setup({
    lsp_completion = {
      process_items = MiniFuzzy.process_lsp_items,
    }
  })

  -- improve fallback completion
  vim.opt.complete = { '.', 'w', 'k', 'b', 'u' }
  vim.opt.completeopt:append('fuzzy')
  vim.opt.dictionary:append('/usr/share/dict/words')
  -- define keycodes
  local keys = {
    cn = vim.keycode('<c-n>'),
    cp = vim.keycode('<c-p>'),
    ct = vim.keycode('<c-t>'),
    cd = vim.keycode('<c-d>'),
    cr = vim.keycode('<cr>'),
    cy = vim.keycode('<c-y>'),
  }

  -- select by <tab>/<s-tab>
  vim.keymap.set('i', '<tab>', function()
    -- popup is visible -> next item
    -- popup is NOT visible -> add indent
    return vim.fn.pumvisible() == 1 and keys.cn or keys.ct
  end, { expr = true, desc = 'Select next item if popup is visible' })
  vim.keymap.set('i', '<s-tab>', function()
    -- popup is visible -> previous item
    -- popup is NOT visible -> remove indent
    return vim.fn.pumvisible() == 1 and keys.cp or keys.cd
  end, { expr = true, desc = 'Select previous item if popup is visible' })

  -- complete by <cr>
  vim.keymap.set('i', '<cr>', function()
    if vim.fn.pumvisible() == 0 then
      -- popup is NOT visible -> insert newline
      return require('mini.pairs').cr() -- 注意2
    end
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    if item_selected then
      -- popup is visible and item is selected -> complete item
      return keys.cy
    end
    -- popup is visible but item is NOT selected -> hide popup and insert newline
    return keys.cy .. keys.cr
  end, { expr = true, desc = 'Complete current item if item is selected' })
end)

later(function()
  require('mini.tabline').setup()
end)

later(function()
  require('mini.bufremove').setup()

  vim.api.nvim_create_user_command(
    'Bufdelete',
    function()
      MiniBufremove.delete()
    end,
    { desc = 'Remove buffer' }
  )
end)

now(function()
  require('mini.files').setup()

  vim.api.nvim_create_user_command(
    'Files',
    function()
      MiniFiles.open()
    end,
    { desc = 'Open file exproler' }
  )

  vim.keymap.set('n', '<leader>e', '<cmd>Files<cr>', { desc = 'Open file exproler' })
end)

later(function()
  require('mini.pick').setup()

  vim.ui.select = MiniPick.ui_select

  vim.keymap.set('n', '<leader>ff', function ()
    MiniPick.builtin.files({ tool = 'git' })
  end, { desc = 'mini.pick.files' })

  vim.keymap.set('n', '<space>fb', function()
    local wipeout_cur = function()
      vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
    end
    local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }
    MiniPick.builtin.buffers({ include_current = false }, { mappings = buffer_mappings })
  end, { desc = 'mini.pick.buffers' })

  vim.keymap.set('n', '<leader>fw', function()
    MiniPick.builtin.grep({ tool = 'git' })
  end, { desc = 'mini.pick.grep' })

  require('mini.visits').setup()
  vim.keymap.set('n', '<space>h', function()
    require('mini.extra').pickers.visit_paths()
  end, { desc = 'mini.extra.visit_paths' })

  vim.keymap.set('c', 'h', function()
    if vim.fn.getcmdtype() .. vim.fn.getcmdline() == ':h' then
      return '<c-u>Pick help<cr>'
    end
    return 'h'
  end, { expr = true, desc = 'mini.pick.help' })
end)

later(function()
  require('mini.diff').setup()
end)

later(function ()
  require('mini.jump').setup({
    delay = {
      idle_stop = 10,
    },
  })
end)

later(function()
  require('mini.move').setup()
end)

later(function()
  add({ source = 'https://github.com/zbirenbaum/copilot.lua' })

  ---@diagnostic disable-next-line: undefined-field
  require('copilot').setup({
    suggestion = {
      auto_trigger = true,
      hide_during_completion = false,
    },
    filetypes = {
      markdown = false,
      gitcommit = true,
      ['*'] = function()
        -- disable for files with specific names
        local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        local disable_patterns = { 'env', 'conf', 'local', 'private' }
        return vim.iter(disable_patterns):all(function(pattern)
          return not string.match(fname, pattern)
        end)
      end,
    },
  })

  -- set CopilotSuggestion as underlined comment
  local hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
  vim.api.nvim_set_hl(0, 'CopilotSuggestion', vim.tbl_extend('force', hl, { underline = true }))
end)

later(function()
  add({
    source = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
    depends = {
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/zbirenbaum/copilot.lua'
    },
  })

  local default_prompts = require('CopilotChat.config.prompts')
  local in_japanese = 'なお、説明は日本語でお願いします。'
  require('CopilotChat').setup({
    prompts = vim.tbl_deep_extend('force', default_prompts, {
      -- ビルトインのプロンプトを日本語化
      Explain = { prompt = default_prompts.Explain.prompt .. in_japanese },
      Review = { prompt = default_prompts.Review.prompt .. in_japanese },
      Fix = { prompt = default_prompts.Fix.prompt .. in_japanese },
      Optimize = { prompt = default_prompts.Optimize.prompt .. in_japanese },
      -- 日英翻訳のプロンプトを独自に追加
      TranslateJE = {
        prompt = 'Translate the selected text from English to Japanese if it is in English, or from Japanese to English if it is in Japanese. Please do not include unnecessary line breaks, line numbers, comments, etc. in the result.',
        system_prompt = 'You are an excellent Japanese-English translator. You can translate the original text correctly without losing its meaning. You also have deep knowledge of system engineering and are good at translating technical documents.',
        description = 'Translate text from Japanese to English or vice versa',
      },
    }),
  })
  vim.keymap.set('ca', 'chat', 'CopilotChat', { desc = 'Ask CopilotChat' })
  vim.keymap.set(
    { 'n', 'x' },
    '<leader>p',
    '<cmd>CopilotChatPrompt<cr>',
    { desc = 'CopilotChat predefined prompts' }
  )
end)

now(function()
  add({ source = 'https://github.com/slim-template/vim-slim.git' })
end)

