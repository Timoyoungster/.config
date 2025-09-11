-- Set up a path for mini.deps
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.deps'

-- Clone mini.deps if it doesn't exist yet
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.deps',
    mini_path
  })
end

-- Add to runtime
vim.opt.runtimepath:prepend(mini_path)

-- Now require it
require('mini.deps').setup()

-------------
-- PLUGINS --
-------------

local add = MiniDeps.add

-- mini.deps manages itself
add('echasnovski/mini.deps')

-- fuzzy finder
add('nvim-telescope/telescope.nvim')

-- harpoon
add({
  source = 'theprimeagen/harpoon',
  checkout = 'harpoon2',
  monitor = 'harpoon2',
  depends = { 'nvim-lua/plenary.nvim' },
})

-------------
-- CONFIGS --
-------------

-- TELESCOPE
 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- HARPOON

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
