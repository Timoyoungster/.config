-- Phantom Shadow — Neovim Colorscheme (Ghostty terminal palette)
-- Author: ChatGPT
-- Follows Tonsky’s minimal highlighting principles
-- Adds Git, Telescope, and NvimTree integrations

local cmd = vim.cmd
local hl = vim.api.nvim_set_hl
vim.o.background = "dark"
vim.g.colors_name = "phantom-shadow"
vim.opt.termguicolors = false

local function H(group, opts) hl(0, group, opts) end

local colors = {
  black   = 0,
  red     = 1,
  green   = 2,
  yellow  = 3,
  blue    = 4,
  magenta = 5,
  cyan    = 6,
  white   = 7,
  bright_black   = 8,
  bright_red     = 9,
  bright_green   = 10,
  bright_yellow  = 11,
  bright_blue    = 12,
  bright_magenta = 13,
  bright_cyan    = 14,
  bright_white   = 15,
}

-- ────────────────────────────────
-- Base UI
-- ────────────────────────────────
H("Cursor",     { ctermfg = bg, ctermbg = fg })
H("Normal",     { ctermfg = colors.white })
H("Visual",     { ctermbg = colors.bright_black, reverse = true})
H("String",     { ctermfg = colors.green })
H("Constant",   { ctermfg = colors.magenta })
H("Function",   { ctermfg = colors.cyan })
H("Special",    { ctermfg = colors.blue })
H("Comment",    { ctermfg = colors.yellow, italic = true})
H("Delimiter",  { ctermfg = colors.bright_black })
H("Search",     { ctermfg = colors.black, ctermbg = colors.bright_magenta })

H("Underlined", { underline = true })

H("Todo",       { ctermfg = colors.black, ctermbg = colors.magenta })

H("ColorColumn", { ctermbg = colors.black })

H("Title",      { ctermfg = colors.bright_white })

H("DiffAdd",    { ctermfg = colors.green })
H("DiffChange", { ctermbg = colors.bright_black })
H("DiffDelete", { ctermfg = colors.red, bold = true })
H("DiffText",   { ctermfg = colors.black, ctermbg = colors.bright_cyan })
H("Added",      { link = "DiffAdd" })
H("Removed",    { link = "DiffDelete" })
H("Changed",    { link = "DiffChange" })

H("SpellBad",   { ctermfg = colors.red, undercurl = true })
H("SpellCap",   { ctermfg = colors.bright_yellow, undercurl = true })
H("SpellRare",  { ctermfg = colors.cyan, undercurl = true })
H("SpellLocal", { ctermfg = colors.green, undercurl = true })

H("QuickFixLine", { ctermfg = colors.cyan })

H("MatchParen", { ctermfg = colors.yellow, bold = true, underline = true })

-- Statusline
H("StatusLine", {
	ctermfg = colors.magenta,
	ctermbg = nil,
	-- reverse = true
})
H("StatusLineNC", {
	ctermfg = colors.magenta,
	ctermbg = nil,
	-- reverse = true,
	underline = true
})

-- Pmenu
H("Pmenu",         { link = 'StatusLine' })
H("PmenuSel",      { link = 'StatusLineNC' })
H("PmenuMatch",    { link = 'Pmenu', bold = true })
H("PmenuMatchSel", { link = 'PmenuSel', bold = true })
H("PmenuThumb",    { link = 'Normal' })

H("TabLineSel",    { link = 'TabLine' })

-- Diagnostics
H("Error",         { ctermfg = colors.bright_red, bold = true})
H("DiagnosticError",          { link = 'Error' })
H("DiagnosticUnderlineError", { link = 'Error' })
H("NvimInternalError",        { link = 'Error' })
H("ErrorMsg",                 { link = 'Error' })

H("Warn",          { ctermfg = colors.bright_yellow, bold = true})
H("DiagnosticWarn",          { link = 'Warn' })
H("DiagnosticUnderlineWarn", { link = 'Warn' })
H("NvimInternalWarn",        { link = 'Warn' })
H("WarningMsg",              { link = 'Warn' })

H("Info",          { ctermfg = colors.bright_cyan, bold = true})
H("DiagnosticInfo",          { link = 'Info' })
H("DiagnosticUnderlineInfo", { link = 'Info' })
H("NvimInternalInfo",        { link = 'Info' })

H("Hint",          { ctermfg = colors.bright_magenta, bold = true})
H("DiagnosticHint",          { link = 'Hint' })
H("DiagnosticUnderlineHint", { link = 'Hint' })
H("NvimInternalHint",        { link = 'Hint' })
H("MoreMsg",    	     { link = 'Hint' })

H("Ok",          { ctermfg = colors.bright_green, bold = true})
H("DiagnosticOk",          { link = 'Ok' })
H("DiagnosticUnderlineOk", { link = 'Ok' })
H("NvimInternalOk",        { link = 'Ok' })

H("DiagnosticDeprecated", { link = 'Comment', strikethrough = true })

-- Markup
H("@markup.strong", { bold = true })
H("@markup.italic", { italic = true })
H("@markup.strikethrough", { strikethrough = true })
H("@markup.underline", { underline = true })
H("@markup.heading.1.delimiter.vimdoc", { 
	underdouble = true, 
	nocombine = true, 
	ctermfg = colors.magenta, 
	ctermbg = nil
})
H("@markup.heading.2.delimiter.vimdoc", {
	underline = true,
	nocombine = true,
	ctermfg = colors.magenta,
	ctermbg = nil
})

-- Normal Links
H("Statement",     { link = 'Normal' })
H("SpecialKey",    { link = 'Normal' })
H("NonText",       { link = 'Normal' })
H("LineNr",        { link = 'Normal' })
H("CursorLineNr",  { link = 'Normal', bold = true })
H("SignColumn",    { link = 'Normal', bold = true })
H("Conceal",       { link = 'Normal', bold = true })
H("CursorColumn",  { link = 'Normal' })
H("CursorLine",    { link = 'Normal' })
H("NormalNC",      { link = 'Normal' })
H("NormalFloat",   { link = 'Normal' })
H("MsgArea",       { link = 'Normal' })
H("ComplMatchIns", { link = 'Normal' })
H("@variable",     { link = 'Normal' })
H("Identifier",    { link = 'Normal' })
H("@diff",         { link = 'Normal' })
H("@lsp",          { link = 'Normal' })
H("Type",          { link = 'Normal' })
H("Operator",      { link = 'Normal' })
H("Method",        { link = 'Normal' })
H("Struct",        { link = 'Normal' })
H("@type.builtin", { link = 'Normal' })
H("@function.call",{ link = 'Normal' })

-- Special Links
H("PreProc",       { link = 'Special' })
H("@definition.var", { link = 'Special' })

-- Constant Links
H("@constant.builtin", { link = 'Constant' })

-- Title Links
H("WinBar",        { link = 'Title' })
H("WinBarNC",      { link = 'Title' })

-- Comment Links
H("Folded",        { link = 'Comment' })

-- Function Links
H("Directory",     { link = 'Function' })
H("Question",      { link = 'Function' })

-- Search Links
H("CurSearch",     { link = 'Search' })

-- Cursor Links
H("TermCursor",    { link = 'Cursor' })
H("lCursor",       { link = 'Cursor' })

-- no idea what those are
H("RedrawDebugNormal", { link = 'Visual' })
H("RedrawDebugClear", { ctermfg = nil, ctermbg = colors.yellow })
H("RedrawDebugComposed", { ctermfg = nil, ctermbg = colors.green })
H("RedrawDebugRecompose", { ctermfg = nil, ctermbg = colors.red })
H("FloatShadow", { ctermbg = colors.black, blend = 80 })
H("FloatShadowThrough", { ctermbg = colors.black, blend = 100 })
