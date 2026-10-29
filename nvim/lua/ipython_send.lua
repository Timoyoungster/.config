local M = {}

local CELL_MARKER = "^# %%%%"

local function tmux(args)
  local result = vim.system(vim.list_extend({ "tmux" }, args), { text = true }):wait()
  return result.code == 0, vim.trim(result.stdout or "")
end

-- Find a pane in the current window running (i)python, preferring a
-- non-active one (the active pane is usually neovim itself).
local function detect_ipython_pane()
  local ok, out = tmux({ "list-panes", "-F", "#{pane_id} #{pane_active} #{pane_current_command}" })
  if not ok then return nil end

  local fallback
  for _, line in ipairs(vim.split(out, "\n", { trimempty = true })) do
    local id, active, cmd = line:match("^(%S+) (%d) (.*)$")
    if cmd and cmd:match("python") then
      if active == "0" then return id end
      fallback = fallback or id
    end
  end
  return fallback
end

-- Write the code to a temp file and let IPython execute it via run_cell.
-- Only a single short line is typed into the pane, so there are no issues
-- with paste modes, autoindent or prompt_toolkit swallowing typeahead.
local function send_block(lines, label)
  local code = table.concat(lines, "\n")
  if vim.trim(code) == "" then
    vim.notify("Nothing to send", vim.log.levels.WARN)
    return
  end

  if not vim.env.TMUX then
    vim.notify("Not running inside tmux", vim.log.levels.ERROR)
    return
  end

  local pane = detect_ipython_pane()
  if not pane then
    vim.notify("No IPython pane detected", vim.log.levels.ERROR)
    return
  end

  local file = vim.fn.tempname() .. ".py"
  vim.fn.writefile(vim.split(code, "\n"), file)

  -- "and None" hides the ExecutionResult so only the cell's own Out[] shows;
  -- store_history makes _ / Out[n] refer to the cell's result.
  local cmd = string.format("get_ipython().run_cell(open(%q).read(), store_history=True) and None", file)

  -- Leave copy mode if the pane is scrolled back, otherwise keys go nowhere.
  local _, in_mode = tmux({ "display-message", "-p", "-t", pane, "#{pane_in_mode}" })
  if in_mode == "1" then
    tmux({ "send-keys", "-t", pane, "-X", "cancel" })
  end

  local ok = tmux({ "send-keys", "-t", pane, "-l", cmd })
    and tmux({ "send-keys", "-t", pane, "Enter" })
  if not ok then
    vim.notify("Could not send code to tmux pane " .. pane, vim.log.levels.ERROR)
    return
  end

  vim.notify("📤 Sent " .. label .. " → " .. pane)
end

-- Return the last line (1-based) of the cell containing `line`.
local function cell_end(lines, line)
  for i = line + 1, #lines do
    if lines[i]:match(CELL_MARKER) then return i - 1 end
  end
  return #lines
end

-- Return the first line (1-based) of the cell containing `line`.
local function cell_start(lines, line)
  for i = line, 1, -1 do
    if lines[i]:match(CELL_MARKER) then return i end
  end
  return 1
end

local function strip_markers(lines)
  return vim.tbl_filter(function(l) return not l:match(CELL_MARKER) end, lines)
end

function M.send_current_cell()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cur = vim.api.nvim_win_get_cursor(0)[1]
  local block = vim.list_slice(lines, cell_start(lines, cur), cell_end(lines, cur))
  send_block(strip_markers(block), "cell")
end

function M.send_all_cells_up_to_current()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cur = vim.api.nvim_win_get_cursor(0)[1]
  local block = vim.list_slice(lines, 1, cell_end(lines, cur))
  send_block(strip_markers(block), "all cells up to current")
end

return M

-- vim:ts=2 sw=2 et:
