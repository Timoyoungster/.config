" ────────────────────────────────
" Phantom Shadow — Vim Colorscheme (16-color terminal)
" Author: ChatGPT
" ────────────────────────────────

set background=dark
let g:colors_name = "phantom-shadow"

" Terminal palette numbers:
" 0=black, 1=red, 2=green, 3=yellow, 4=blue, 5=magenta, 6=cyan, 7=white
" 8=bright_black, 9=bright_red, 10=bright_green, 11=bright_yellow
" 12=bright_blue, 13=bright_magenta, 14=bright_cyan, 15=bright_white

" ────────────────────────────────
" Base UI
" ────────────────────────────────
highlight Normal         ctermfg=7
highlight Cursor         ctermfg=0 ctermbg=7
highlight Visual         ctermbg=8 cterm=reverse
highlight ColorColumn    ctermbg=0
highlight String         ctermfg=2
highlight Constant       ctermfg=5
highlight Function       ctermfg=6
highlight Special        ctermfg=4
highlight Comment        ctermfg=3 cterm=italic
highlight Search         ctermfg=0 ctermbg=13
highlight Underlined     cterm=underline
highlight Todo           ctermfg=0 ctermbg=5
highlight Title          ctermfg=15

" ────────────────────────────────
" Diff
highlight DiffAdd        ctermfg=2
highlight DiffChange     ctermbg=8
highlight DiffDelete     ctermfg=1 cterm=bold
highlight DiffText       ctermfg=0 ctermbg=14
highlight Added          ctermfg=2
highlight Removed        ctermfg=1 cterm=bold
highlight Changed        ctermbg=8

" ────────────────────────────────
" Spell
highlight SpellBad       ctermfg=1 cterm=underline
highlight SpellCap       ctermfg=11 cterm=underline
highlight SpellRare      ctermfg=6 cterm=underline
highlight SpellLocal     ctermfg=2 cterm=underline

highlight QuickFixLine   ctermfg=6
highlight MatchParen     ctermfg=3 cterm=bold,underline

" ────────────────────────────────
" Statusline
highlight StatusLine     ctermfg=5
highlight StatusLineNC   ctermfg=5 cterm=underline

highlight Pmenu          link StatusLine
highlight PmenuSel       link StatusLineNC
highlight PmenuMatch     link Pmenu
highlight PmenuMatchSel  link PmenuSel
highlight PmenuThumb     link Normal

highlight TabLineSel     link TabLine

" ────────────────────────────────
" Diagnostics
highlight Error          ctermfg=9 cterm=bold
highlight DiagnosticError         link Error
highlight DiagnosticUnderlineError link Error
highlight NvimInternalError       link Error
highlight ErrorMsg                link Error

highlight Warn           ctermfg=11 cterm=bold
highlight DiagnosticWarn          link Warn
highlight DiagnosticUnderlineWarn link Warn
highlight NvimInternalWarn        link Warn
highlight WarningMsg              link Warn

highlight Info           ctermfg=14 cterm=bold
highlight DiagnosticInfo          link Info
highlight DiagnosticUnderlineInfo link Info
highlight NvimInternalInfo        link Info

highlight Hint           ctermfg=13 cterm=bold
highlight DiagnosticHint          link Hint
highlight DiagnosticUnderlineHint link Hint
highlight NvimInternalHint        link Hint
highlight MoreMsg                link Hint

highlight Ok             ctermfg=10 cterm=bold
highlight DiagnosticOk           link Ok
highlight DiagnosticUnderlineOk  link Ok
highlight NvimInternalOk         link Ok

highlight DiagnosticDeprecated   link Comment

" ────────────────────────────────
" Markup
highlight @markup.strong        cterm=bold
highlight @markup.italic        cterm=italic
highlight @markup.strikethrough cterm=strikethrough
highlight @markup.underline     cterm=underline
highlight @markup.heading.1.delimiter.vimdoc ctermfg=5 cterm=bold
highlight @markup.heading.2.delimiter.vimdoc ctermfg=5 cterm=underline

" ────────────────────────────────
" Normal links
highlight Statement     link Normal
highlight SpecialKey    link Normal
highlight NonText       link Normal
highlight LineNr        link Normal
highlight CursorLineNr  link Normal
highlight SignColumn    link Normal
highlight Conceal       link Normal
highlight CursorColumn  link Normal
highlight CursorLine    link Normal
highlight NormalNC      link Normal
highlight NormalFloat   link Normal
highlight MsgArea       link Normal
highlight ComplMatchIns link Normal
highlight @variable     link Normal
highlight Identifier    link Normal
highlight @diff         link Normal
highlight @lsp          link Normal
highlight Delimiter     link Normal
highlight Type          link Normal
highlight Operator      link Normal
highlight Method        link Normal
highlight Struct        link Normal

highlight PreProc       link Special
highlight WinBar        link Title
highlight WinBarNC      link Title
highlight Folded        link Comment
highlight Directory     link Function
highlight Question      link Function
highlight CurSearch     link Search
highlight TermCursor    link Cursor
highlight lCursor       link Cursor

highlight RedrawDebugNormal   link Visual
highlight RedrawDebugClear    ctermbg=3
highlight RedrawDebugComposed ctermbg=2
highlight RedrawDebugRecompose ctermbg=1

highlight FloatShadow         ctermbg=0
highlight FloatShadowThrough  ctermbg=0

