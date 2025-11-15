local M = {}

local function capture(cmd)
  local f = io.popen(cmd)
  if not f then return "" end
  local result = f:read("*a")
  f:close()
  return result or ""
end

local function detect_ipython_pane()
  local panes = capture("tmux list-panes -a -F '#{pane_id}:#{pane_current_command}'")
  if panes == "" then return nil end

  for line in panes:gmatch("[^\r\n]+") do
    local id, cmd = line:match("^(.-):(.*)$")
    if id and cmd and cmd:lower():match("ipython") then
      return id
    end
  end

  for line in panes:gmatch("[^\r\n]+") do
    local id, cmd = line:match("^(.-):(.*)$")
    if id and cmd and cmd:lower():match("python") then
      return id
    end
  end

  return nil
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

  -- Bracketed paste markers
  local start_bp = "\x1b[200~"
  local end_bp   = "\x1b[201~"
  
  -- IMPORTANT: final newline triggers auto-execution
  local wrapped  = start_bp .. cell .. end_bp .. "\n"

  -- Save wrapped cell into tmux buffer
  local tmpfile = os.tmpname()
  local f = io.open(tmpfile, "w")
  f:write(wrapped)
  f:close()

  -- Load + paste as single atomic block
  os.execute(string.format("tmux load-buffer %s", tmpfile))
  os.execute(string.format("tmux paste-buffer -t %s", pane))

  os.remove(tmpfile)

  print("📤 Sent cell → " .. pane)
end

function M.send_all_cells_up_to_current()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_line = cursor[1]

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Determine where the *current* cell starts
  local current_start = cur_line
  while current_start > 1 do
    if lines[current_start]:match("^# %%%%") then break end
    current_start = current_start - 1
  end
  if current_start == 1 and not lines[current_start]:match("^# %%%%") then
    current_start = 1
  end

  -- We want all content *up to* the start of the current cell,
  -- plus the full current cell.
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

  -- Wrap in bracketed-paste markers + trailing newline to auto-execute
  local start_bp = "\x1b[200~"
  local end_bp   = "\x1b[201~"
  local wrapped  = start_bp .. block .. end_bp .. "\n"

  -- Save block into tmux buffer and paste atomically
  local tmpfile = os.tmpname()
  local f = io.open(tmpfile, "w")
  f:write(wrapped)
  f:close()

  os.execute(string.format("tmux load-buffer %s", tmpfile))
  os.execute(string.format("tmux paste-buffer -t %s", pane))

  os.remove(tmpfile)

  print("📤 Sent ALL cells up to current → " .. pane)
end

return M

-- vim:ts=2 sw=2 et:
