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

-- tree-sitter (needs tree-sitter-cli installed)
add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  monitor = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

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

-- TREESITTER
local availiable_langs = require('nvim-treesitter.parsers')
local availiable_parsers = {}
for key, _ in pairs(availiable_langs) do
  table.insert(availiable_parsers, key)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = availiable_parsers,
  callback = function(args)
    local lang = vim.bo[args.buf].filetype
    require('nvim-treesitter').install({ lang }):wait(1000 * 60 * 5) -- wait max 5 mins
    vim.treesitter.start()
  end,
})

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

-- Modern Treesitter-aware highlight inspector for Neovim main branch
function ShowTSHighlight()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local parser = vim.treesitter.get_parser(bufnr)
  if not parser then
    print("No Treesitter parser found for this buffer.")
    return
  end

  local lang_tree = parser:language_for_range({ row, col, row, col })
  local query = vim.treesitter.query.get(lang_tree:lang(), "highlights")
  if not query then
    print("No highlight query found for this language.")
    return
  end

  local root = lang_tree:parse()[1]:root()
  local results = {}

  for id, node, _ in query:iter_captures(root, bufnr, row, row + 1) do
    local s_row, s_col, e_row, e_col = node:range()
    if row >= s_row and row <= e_row and col >= s_col and col <= e_col then
      local capture_name = query.captures[id] or "unknown"
      table.insert(results, capture_name)
    end
  end

  if #results == 0 then
    print("No Treesitter highlight capture found under cursor.")
  else
    print("Treesitter captures: " .. table.concat(results, ", "))
  end
end

vim.keymap.set('n', '<leader>t', ShowTSHighlight, { desc = "Show Treesitter highlight under cursor" })


-- vim:ts=2 sw=2 et:
