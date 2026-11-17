-- Dimlight — low-contrast Neovim colorscheme
-- Uses the terminal palette (cterm 0-15) from ghostty/themes/dimlight.conf.
-- Same minimal approach as phantom-shadow: only strings, constants, functions,
-- comments and specials get color; everything else is plain text.
-- No bold diagnostics, no reverse-video blocks, soft surfaces for selections.

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "dimlight"
vim.opt.termguicolors = false

local function H(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local c = {
  surface = 0,  -- slightly lighter than background
  red     = 1,
  green   = 2,
  yellow  = 3,
  blue    = 4,
  magenta = 5,
  cyan    = 6,
  text    = 7,
  dim     = 8,
  bright_red    = 9,
  bright_green  = 10,
  bright_yellow = 11,
  bright_blue   = 12,
  bright_magenta= 13,
  bright_cyan   = 14,
  bright        = 15,
}

-- ────────────────────────────────
-- Base
-- ────────────────────────────────
H("Normal",      { ctermfg = c.text })
H("Cursor",      { reverse = true })
H("Visual",      { ctermbg = c.surface })
H("String",      { ctermfg = c.green })
H("Constant",    { ctermfg = c.magenta })
H("Function",    { ctermfg = c.blue })
H("Special",     { ctermfg = c.cyan })
H("Comment",     { ctermfg = c.yellow, italic = true })
H("Delimiter",   { ctermfg = c.dim })
H("Search",      { ctermfg = c.bright, ctermbg = c.dim })
H("CurSearch",   { ctermfg = c.surface, ctermbg = c.yellow })
H("IncSearch",   { link = "CurSearch" })
H("Underlined",  { underline = true })
H("Todo",        { ctermfg = c.yellow, underline = true })
H("Title",       { ctermfg = c.bright })
H("ColorColumn", { ctermbg = c.surface })
H("MatchParen",  { ctermbg = c.surface, underline = true })
H("QuickFixLine",{ ctermbg = c.surface })

-- Quiet UI chrome
H("LineNr",       { ctermfg = c.dim })
H("CursorLineNr", { ctermfg = c.text })
H("CursorLine",   { ctermbg = c.surface })
H("CursorColumn", { link = "CursorLine" })
H("SignColumn",   {})
H("NonText",      { ctermfg = c.dim })
H("SpecialKey",   { ctermfg = c.dim })
H("Whitespace",   { ctermfg = c.surface })
H("WinSeparator", { ctermfg = c.surface })
H("VertSplit",    { link = "WinSeparator" })
H("Folded",       { ctermfg = c.dim, italic = true })
H("FoldColumn",   { ctermfg = c.dim })
H("EndOfBuffer",  { ctermfg = c.surface })
H("Conceal",      { ctermfg = c.dim })

-- Statusline / tabline / winbar
H("StatusLine",   { ctermfg = c.text, ctermbg = c.surface })
H("StatusLineNC", { ctermfg = c.dim,  ctermbg = c.surface })
H("TabLine",      { ctermfg = c.dim,  ctermbg = c.surface })
H("TabLineSel",   { ctermfg = c.text })
H("TabLineFill",  { ctermbg = c.surface })
H("WinBar",       { ctermfg = c.text })
H("WinBarNC",     { ctermfg = c.dim })

-- Floats / popup menu
H("NormalFloat",   { ctermfg = c.text, ctermbg = c.surface })
H("FloatBorder",   { ctermfg = c.dim,  ctermbg = c.surface })
H("FloatTitle",    { ctermfg = c.text, ctermbg = c.surface })
H("Pmenu",         { ctermfg = c.text, ctermbg = c.surface })
H("PmenuSel",      { ctermfg = c.bright, ctermbg = c.dim })
H("PmenuMatch",    { ctermfg = c.blue, ctermbg = c.surface })
H("PmenuMatchSel", { ctermfg = c.bright, ctermbg = c.dim, underline = true })
H("PmenuSbar",     { ctermbg = c.surface })
H("PmenuThumb",    { ctermbg = c.dim })
H("FloatShadow",        { ctermbg = 0, blend = 80 })
H("FloatShadowThrough", { ctermbg = 0, blend = 100 })

-- Messages
H("ErrorMsg",   { ctermfg = c.red })
H("WarningMsg", { ctermfg = c.yellow })
H("MoreMsg",    { ctermfg = c.cyan })
H("ModeMsg",    { ctermfg = c.text })
H("Question",   { ctermfg = c.blue })
H("Directory",  { ctermfg = c.blue })
H("NvimInternalError", { link = "ErrorMsg" })

-- ────────────────────────────────
-- Diagnostics (no bold, underlines instead of loud colors)
-- ────────────────────────────────
H("Error",           { ctermfg = c.red })
H("DiagnosticError", { ctermfg = c.red })
H("DiagnosticWarn",  { ctermfg = c.yellow })
H("DiagnosticInfo",  { ctermfg = c.blue })
H("DiagnosticHint",  { ctermfg = c.dim })
H("DiagnosticOk",    { ctermfg = c.green })
H("DiagnosticUnderlineError", { underline = true })
H("DiagnosticUnderlineWarn",  { underline = true })
H("DiagnosticUnderlineInfo",  {})
H("DiagnosticUnderlineHint",  {})
H("DiagnosticUnderlineOk",    {})
H("DiagnosticDeprecated",     { strikethrough = true })
H("DiagnosticUnnecessary",    { ctermfg = c.dim })

-- Spelling
H("SpellBad",   { undercurl = true })
H("SpellCap",   { undercurl = true })
H("SpellRare",  { undercurl = true })
H("SpellLocal", { undercurl = true })

-- ────────────────────────────────
-- Diff / git
-- ────────────────────────────────
H("DiffAdd",    { ctermfg = c.green })
H("DiffChange", { ctermbg = c.surface })
H("DiffDelete", { ctermfg = c.red })
H("DiffText",   { ctermfg = c.bright, ctermbg = c.dim })
H("Added",      { ctermfg = c.green })
H("Removed",    { ctermfg = c.red })
H("Changed",    { ctermfg = c.yellow })

-- ────────────────────────────────
-- Markup
-- ────────────────────────────────
H("@markup.strong",        { bold = true })
H("@markup.italic",        { italic = true })
H("@markup.strikethrough", { strikethrough = true })
H("@markup.underline",     { underline = true })
H("@markup.heading",       { ctermfg = c.bright })
H("@markup.link.url",      { ctermfg = c.cyan, underline = true })
H("@markup.raw",           { ctermfg = c.green })

-- ────────────────────────────────
-- Plain text links (minimal highlighting)
-- ────────────────────────────────
for _, g in ipairs({
  "Statement", "Identifier", "Type", "Operator", "Keyword",
  "@variable", "@lsp", "@diff", "@type.builtin",
  "@function.builtin", "@function.call", "@function.method.call",
  "NormalNC", "MsgArea", "ComplMatchIns",
}) do
  H(g, { link = "Normal" })
end

H("PreProc",           { link = "Special" })
H("@constant.builtin", { link = "Constant" })
H("TermCursor",        { link = "Cursor" })
H("lCursor",           { link = "Cursor" })
