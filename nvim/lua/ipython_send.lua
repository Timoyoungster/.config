local M = {}

local function capture(cmd)
  local f = io.popen(cmd)
  if not f then return "" end
  local result = f:read("*a")
  f:close()
  return result or ""
end

local function detect_ipython_pane()
  local ids = capture("tmux list-panes -F '#{pane_id}:#{pane_current_command}:#{pane_active}' | grep 'python:0' | sed 's/:.*:.*//'")
  if ids == "" then return nil end

  for _, id in ipairs(vim.split(ids, "\n", { trimempty = true })) do
    return id
  end

  return nil
end

local function send_block(pane, block)
  -- %cpaste handles multiline Python without relying on the terminal's
  -- bracketed-paste mode.  The latter may be disabled by IPython/readline,
  -- causing its escape sequences to be inserted as literal source text.
  local result = vim.system(
    { "tmux", "load-buffer", "-" },
    { stdin = block }
  ):wait()
  if result.code ~= 0 then
    vim.notify("Could not load the tmux paste buffer", vim.log.levels.ERROR)
    return false
  end

  vim.fn.system({ "tmux", "send-keys", "-t", pane, "-l", "%cpaste -q" })
  vim.fn.system({ "tmux", "send-keys", "-t", pane, "Enter" })
  vim.fn.system({ "tmux", "paste-buffer", "-t", pane })
  vim.fn.system({ "tmux", "send-keys", "-t", pane, "Enter" })
  -- The first "--" ends tmux option parsing; the second is the literal
  -- %cpaste terminator sent to IPython.
  vim.fn.system({ "tmux", "send-keys", "-t", pane, "-l", "--", "--" })
  vim.fn.system({ "tmux", "send-keys", "-t", pane, "Enter" })

  if vim.v.shell_error ~= 0 then
    vim.notify("Could not send code to tmux pane " .. pane, vim.log.levels.ERROR)
    return false
  end

  return true
end

function M.send_current_cell()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_line = cursor[1]

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Find cell start
  local start = cur_line
  while start > 1 do
    if lines[start]:match("^# %%%%") then break end
    start = start - 1
  end
  if start == 1 and not lines[start]:match("^# %%%%") then start = 1 end

  -- Find cell end
  local finish = cur_line
  while finish <= #lines do
    if finish ~= cur_line and lines[finish]:match("^# %%%%") then
      finish = finish - 1
      break
    end
    finish = finish + 1
  end
  if finish > #lines then finish = #lines end

  -- Extract cell lines, STRIP the "# %%" header
  local cell_lines = vim.list_slice(lines, start, finish)
  if cell_lines[1] and cell_lines[1]:match("^# %%%%") then
    table.remove(cell_lines, 1)
  end

  local cell = table.concat(cell_lines, "\n")

  -- Detect pane
  local pane = detect_ipython_pane()
  if not pane then
    print("No IPython pane detected")
    return
  end

  if send_block(pane, cell) then
    print("📤 Sent cell → " .. pane)
  end
end

function M.send_all_cells_up_to_current()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_line = cursor[1]

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Include everything from the start of the file through the current cell.
  local cells_end = cur_line

  -- Find where the current cell ends
  while cells_end <= #lines do
    if cells_end ~= cur_line and lines[cells_end]:match("^# %%%%") then
      cells_end = cells_end - 1
      break
    end
    cells_end = cells_end + 1
  end
  if cells_end > #lines then cells_end = #lines end

  -- Extract everything from the beginning of the file up to end of current cell
  local block_lines = vim.list_slice(lines, 1, cells_end)

  -- Strip all "# %%" lines (for all earlier cells too)
  local cleaned = {}
  for _, l in ipairs(block_lines) do
    if not l:match("^# %%%%") then
      table.insert(cleaned, l)
    end
  end

  local block = table.concat(cleaned, "\n")

  -- Detect tmux pane running IPython
  local pane = detect_ipython_pane()
  if not pane then
    print("No IPython pane detected")
    return
  end

  if send_block(pane, block) then
    print("📤 Sent ALL cells up to current → " .. pane)
  end
end

return M

-- vim:ts=2 sw=2 et:
