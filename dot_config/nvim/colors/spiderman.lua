-- ==========================================================
-- spiderman colorscheme
-- Managed by chezmoi: dot_config/nvim/colors/spiderman.lua
-- -> ~/.config/nvim/colors/spiderman.lua
--
-- Built from the Spiderman palette (see dot_config/starship.toml
-- and dot_config/ghostty/themes/Spiderman*).
--
-- Follows the terminal's light/dark mode: reads vim.o.background
-- (auto-maintained by nvim via OSC 11) and never sets it itself,
-- so nvim re-detects live theme switches. Setting g:colors_name
-- makes nvim reload this file whenever background changes.
-- ==========================================================

local palette = {
  fg = "#e3e3e3",
  bright = "#fffef6",
  black = "#1b1d1e",
  gray = "#505354",
  red = "#e60813",
  bright_red = "#ff0325",
  light_red = "#e24756",
  blue = "#2c3fff",
  blue_2 = "#1d50ff",
  navy = "#2435db",
  light_blue = "#6184ff",
  mid_blue = "#747cff",
  selection_bg = "#070e50",
  selection_fg = "#f0272d",
}

local function apply(groups)
  for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

-- ==========================================================
-- Dark variant (black background)
-- ==========================================================
local dark = {
  Normal = { fg = palette.fg, bg = "#000000" },
  Comment = { fg = palette.gray, italic = true },
  Constant = { fg = palette.bright },
  String = { fg = palette.mid_blue },
  Character = { fg = palette.mid_blue },
  Number = { fg = palette.bright },
  Boolean = { fg = palette.bright },
  Float = { fg = palette.bright },
  Identifier = { fg = palette.fg },
  Function = { fg = palette.light_blue },
  Statement = { fg = palette.bright_red },
  Conditional = { fg = palette.bright_red },
  Repeat = { fg = palette.bright_red },
  Label = { fg = palette.bright_red },
  Operator = { fg = palette.fg },
  Keyword = { fg = palette.bright_red },
  Exception = { fg = palette.light_red },
  PreProc = { fg = palette.bright_red },
  Include = { fg = palette.bright_red },
  Define = { fg = palette.bright_red },
  Macro = { fg = palette.bright_red },
  PreCondit = { fg = palette.bright_red },
  Type = { fg = palette.blue_2 },
  StorageClass = { fg = palette.bright_red },
  Structure = { fg = palette.blue_2 },
  Typedef = { fg = palette.blue_2 },
  Special = { fg = palette.bright },
  SpecialChar = { fg = palette.bright },
  Tag = { fg = palette.light_red },
  Delimiter = { fg = palette.fg },
  SpecialComment = { fg = palette.gray, italic = true },
  Debug = { fg = palette.light_red },
  Underlined = { fg = palette.light_blue, underline = true },
  Ignore = { fg = palette.gray },
  Error = { fg = palette.bright_red },
  Todo = { fg = palette.black, bg = palette.bright_red, bold = true },
  Title = { fg = palette.bright, bold = true },
}

-- ==========================================================
-- Light variant (off-white background)
-- ==========================================================
local light = {
  Normal = { fg = palette.black, bg = palette.bright },
  Comment = { fg = palette.gray, italic = true },
  Constant = { fg = palette.red },
  String = { fg = palette.blue_2 },
  Character = { fg = palette.blue_2 },
  Number = { fg = palette.red },
  Boolean = { fg = palette.red },
  Float = { fg = palette.red },
  Identifier = { fg = palette.black },
  Function = { fg = palette.blue },
  Statement = { fg = palette.red },
  Conditional = { fg = palette.red },
  Repeat = { fg = palette.red },
  Label = { fg = palette.red },
  Operator = { fg = palette.black },
  Keyword = { fg = palette.red },
  Exception = { fg = palette.red },
  PreProc = { fg = palette.red },
  Include = { fg = palette.red },
  Define = { fg = palette.red },
  Macro = { fg = palette.red },
  PreCondit = { fg = palette.red },
  Type = { fg = palette.navy },
  StorageClass = { fg = palette.red },
  Structure = { fg = palette.navy },
  Typedef = { fg = palette.navy },
  Special = { fg = palette.red },
  SpecialChar = { fg = palette.red },
  Tag = { fg = palette.red },
  Delimiter = { fg = palette.black },
  SpecialComment = { fg = palette.gray, italic = true },
  Debug = { fg = palette.red },
  Underlined = { fg = palette.blue, underline = true },
  Ignore = { fg = palette.gray },
  Error = { fg = palette.red },
  Todo = { fg = palette.bright, bg = palette.red, bold = true },
  Title = { fg = palette.black, bold = true },
}

-- ==========================================================
-- Treesitter
-- ==========================================================
local ts_dark = {
  ["@comment"] = { fg = palette.gray, italic = true },
  ["@punctuation.delimiter"] = { fg = palette.fg },
  ["@punctuation.bracket"] = { fg = palette.fg },
  ["@punctuation.special"] = { fg = palette.light_red },
  ["@keyword"] = { fg = palette.bright_red },
  ["@keyword.function"] = { fg = palette.bright_red },
  ["@keyword.return"] = { fg = palette.bright_red },
  ["@conditional"] = { fg = palette.bright_red },
  ["@repeat"] = { fg = palette.bright_red },
  ["@label"] = { fg = palette.bright_red },
  ["@operator"] = { fg = palette.fg },
  ["@exception"] = { fg = palette.light_red },
  ["@include"] = { fg = palette.bright_red },
  ["@variable"] = { fg = palette.fg },
  ["@variable.builtin"] = { fg = palette.light_red },
  ["@variable.parameter"] = { fg = palette.fg },
  ["@constant"] = { fg = palette.bright },
  ["@constant.builtin"] = { fg = palette.bright },
  ["@constant.macro"] = { fg = palette.bright },
  ["@number"] = { fg = palette.bright },
  ["@float"] = { fg = palette.bright },
  ["@boolean"] = { fg = palette.bright },
  ["@string"] = { fg = palette.mid_blue },
  ["@string.escape"] = { fg = palette.bright },
  ["@string.regex"] = { fg = palette.mid_blue },
  ["@string.special"] = { fg = palette.light_red },
  ["@character"] = { fg = palette.mid_blue },
  ["@character.special"] = { fg = palette.light_red },
  ["@function"] = { fg = palette.light_blue },
  ["@function.builtin"] = { fg = palette.light_blue },
  ["@function.call"] = { fg = palette.light_blue },
  ["@function.macro"] = { fg = palette.light_blue },
  ["@method"] = { fg = palette.light_blue },
  ["@method.call"] = { fg = palette.light_blue },
  ["@type"] = { fg = palette.blue_2 },
  ["@type.builtin"] = { fg = palette.blue_2 },
  ["@type.definition"] = { fg = palette.blue_2 },
  ["@namespace"] = { fg = palette.blue_2 },
  ["@parameter"] = { fg = palette.fg },
  ["@parameter.reference"] = { fg = palette.fg },
  ["@property"] = { fg = palette.fg },
  ["@field"] = { fg = palette.fg },
  ["@constructor"] = { fg = palette.light_blue },
  ["@attribute"] = { fg = palette.light_red },
  ["@tag"] = { fg = palette.bright_red },
  ["@tag.attribute"] = { fg = palette.mid_blue },
  ["@tag.delimiter"] = { fg = palette.gray },
  ["@macro"] = { fg = palette.bright_red },
  ["@structure"] = { fg = palette.blue_2 },
  ["@module"] = { fg = palette.blue_2 },
  ["@preproc"] = { fg = palette.bright_red },
  ["@define"] = { fg = palette.bright_red },
  ["@storageclass"] = { fg = palette.bright_red },
}

local ts_light = {
  ["@comment"] = { fg = palette.gray, italic = true },
  ["@punctuation.delimiter"] = { fg = palette.black },
  ["@punctuation.bracket"] = { fg = palette.black },
  ["@punctuation.special"] = { fg = palette.red },
  ["@keyword"] = { fg = palette.red },
  ["@keyword.function"] = { fg = palette.red },
  ["@keyword.return"] = { fg = palette.red },
  ["@conditional"] = { fg = palette.red },
  ["@repeat"] = { fg = palette.red },
  ["@label"] = { fg = palette.red },
  ["@operator"] = { fg = palette.black },
  ["@exception"] = { fg = palette.red },
  ["@include"] = { fg = palette.red },
  ["@variable"] = { fg = palette.black },
  ["@variable.builtin"] = { fg = palette.red },
  ["@variable.parameter"] = { fg = palette.black },
  ["@constant"] = { fg = palette.red },
  ["@constant.builtin"] = { fg = palette.red },
  ["@constant.macro"] = { fg = palette.red },
  ["@number"] = { fg = palette.red },
  ["@float"] = { fg = palette.red },
  ["@boolean"] = { fg = palette.red },
  ["@string"] = { fg = palette.blue_2 },
  ["@string.escape"] = { fg = palette.red },
  ["@string.regex"] = { fg = palette.blue_2 },
  ["@string.special"] = { fg = palette.red },
  ["@character"] = { fg = palette.blue_2 },
  ["@character.special"] = { fg = palette.red },
  ["@function"] = { fg = palette.blue },
  ["@function.builtin"] = { fg = palette.blue },
  ["@function.call"] = { fg = palette.blue },
  ["@function.macro"] = { fg = palette.blue },
  ["@method"] = { fg = palette.blue },
  ["@method.call"] = { fg = palette.blue },
  ["@type"] = { fg = palette.navy },
  ["@type.builtin"] = { fg = palette.navy },
  ["@type.definition"] = { fg = palette.navy },
  ["@namespace"] = { fg = palette.navy },
  ["@parameter"] = { fg = palette.black },
  ["@parameter.reference"] = { fg = palette.black },
  ["@property"] = { fg = palette.black },
  ["@field"] = { fg = palette.black },
  ["@constructor"] = { fg = palette.blue },
  ["@attribute"] = { fg = palette.red },
  ["@tag"] = { fg = palette.red },
  ["@tag.attribute"] = { fg = palette.blue_2 },
  ["@tag.delimiter"] = { fg = palette.gray },
  ["@macro"] = { fg = palette.red },
  ["@structure"] = { fg = palette.navy },
  ["@module"] = { fg = palette.navy },
  ["@preproc"] = { fg = palette.red },
  ["@define"] = { fg = palette.red },
  ["@storageclass"] = { fg = palette.red },
}

-- ==========================================================
-- LSP diagnostics
-- ==========================================================
local diagnostics_dark = {
  DiagnosticError = { fg = palette.bright_red },
  DiagnosticWarn = { fg = palette.light_red },
  DiagnosticInfo = { fg = palette.light_blue },
  DiagnosticHint = { fg = palette.mid_blue },
  DiagnosticOk = { fg = palette.mid_blue },
  DiagnosticVirtualTextError = { fg = palette.bright_red },
  DiagnosticVirtualTextWarn = { fg = palette.light_red },
  DiagnosticVirtualTextInfo = { fg = palette.light_blue },
  DiagnosticVirtualTextHint = { fg = palette.mid_blue },
  DiagnosticUnderlineError = { undercurl = true, fg = palette.bright_red },
  DiagnosticUnderlineWarn = { undercurl = true, fg = palette.light_red },
  DiagnosticUnderlineInfo = { undercurl = true, fg = palette.light_blue },
  DiagnosticUnderlineHint = { undercurl = true, fg = palette.mid_blue },
  DiagnosticSignError = { fg = palette.bright_red },
  DiagnosticSignWarn = { fg = palette.light_red },
  DiagnosticSignInfo = { fg = palette.light_blue },
  DiagnosticSignHint = { fg = palette.mid_blue },
  LspReferenceText = { bg = palette.selection_bg },
  LspReferenceRead = { bg = palette.selection_bg },
  LspReferenceWrite = { bg = palette.selection_bg },
}

local diagnostics_light = {
  DiagnosticError = { fg = palette.red },
  DiagnosticWarn = { fg = palette.light_red },
  DiagnosticInfo = { fg = palette.blue },
  DiagnosticHint = { fg = palette.blue_2 },
  DiagnosticOk = { fg = palette.blue_2 },
  DiagnosticVirtualTextError = { fg = palette.red },
  DiagnosticVirtualTextWarn = { fg = palette.light_red },
  DiagnosticVirtualTextInfo = { fg = palette.blue },
  DiagnosticVirtualTextHint = { fg = palette.blue_2 },
  DiagnosticUnderlineError = { undercurl = true, fg = palette.red },
  DiagnosticUnderlineWarn = { undercurl = true, fg = palette.light_red },
  DiagnosticUnderlineInfo = { undercurl = true, fg = palette.blue },
  DiagnosticUnderlineHint = { undercurl = true, fg = palette.blue_2 },
  DiagnosticSignError = { fg = palette.red },
  DiagnosticSignWarn = { fg = palette.light_red },
  DiagnosticSignInfo = { fg = palette.blue },
  DiagnosticSignHint = { fg = palette.blue_2 },
  LspReferenceText = { bg = palette.selection_bg },
  LspReferenceRead = { bg = palette.selection_bg },
  LspReferenceWrite = { bg = palette.selection_bg },
}

-- ==========================================================
-- UI groups
-- ==========================================================
local ui_dark = {
  LineNr = { fg = palette.gray },
  CursorLineNr = { fg = palette.bright, bold = true },
  CursorLine = { bg = palette.black },
  CursorColumn = { bg = palette.black },
  SignColumn = { fg = palette.gray, bg = "#000000" },
  ColorColumn = { bg = palette.black },
  Visual = { bg = palette.selection_bg, fg = palette.selection_fg },
  VisualNOS = { bg = palette.selection_bg, fg = palette.selection_fg },
  Search = { bg = palette.bright_red, fg = palette.bright },
  CurSearch = { bg = palette.bright_red, fg = palette.bright },
  IncSearch = { bg = palette.bright_red, fg = palette.bright },
  MatchParen = { bg = palette.mid_blue, fg = palette.black, bold = true },
  Pmenu = { bg = palette.black, fg = palette.fg },
  PmenuSel = { bg = palette.blue, fg = palette.bright },
  PmenuSbar = { bg = palette.black },
  PmenuThumb = { bg = palette.gray },
  StatusLine = { bg = palette.bright_red, fg = palette.bright },
  StatusLineNC = { bg = palette.black, fg = palette.gray },
  TabLine = { bg = palette.black, fg = palette.gray },
  TabLineSel = { bg = palette.bright_red, fg = palette.bright },
  TabLineFill = { bg = palette.black },
  WinSeparator = { fg = palette.gray },
  VertSplit = { fg = palette.gray },
  Folded = { bg = palette.black, fg = palette.gray },
  FoldColumn = { fg = palette.gray },
  QuickFixLine = { bg = palette.black },
  FloatBorder = { fg = palette.light_blue },
  NormalFloat = { bg = palette.black, fg = palette.fg },
  Directory = { fg = palette.light_blue },
  ModeMsg = { fg = palette.fg, bold = true },
  MoreMsg = { fg = palette.light_blue },
  WarningMsg = { fg = palette.light_red },
  ErrorMsg = { fg = palette.bright_red },
  Question = { fg = palette.light_blue },
  NonText = { fg = palette.gray },
  SpecialKey = { fg = palette.gray },
  Whitespace = { fg = palette.black },
  Conceal = { fg = palette.gray },
  EndOfBuffer = { fg = palette.black },
  DiffAdd = { fg = palette.mid_blue },
  DiffChange = { fg = palette.bright },
  DiffDelete = { fg = palette.light_red },
  DiffText = { bg = palette.blue, fg = palette.bright },
  SpellBad = { undercurl = true, fg = palette.bright_red },
  SpellCap = { undercurl = true, fg = palette.light_blue },
  SpellLocal = { undercurl = true, fg = palette.light_blue },
  SpellRare = { undercurl = true, fg = palette.light_red },
}

local ui_light = {
  LineNr = { fg = palette.gray },
  CursorLineNr = { fg = palette.black, bold = true },
  CursorLine = { bg = palette.fg },
  CursorColumn = { bg = palette.fg },
  SignColumn = { fg = palette.gray, bg = palette.bright },
  ColorColumn = { bg = palette.fg },
  Visual = { bg = palette.selection_bg, fg = palette.selection_fg },
  VisualNOS = { bg = palette.selection_bg, fg = palette.selection_fg },
  Search = { bg = palette.red, fg = palette.bright },
  CurSearch = { bg = palette.red, fg = palette.bright },
  IncSearch = { bg = palette.red, fg = palette.bright },
  MatchParen = { bg = palette.blue_2, fg = palette.bright, bold = true },
  Pmenu = { bg = palette.fg, fg = palette.black },
  PmenuSel = { bg = palette.blue, fg = palette.bright },
  PmenuSbar = { bg = palette.fg },
  PmenuThumb = { bg = palette.gray },
  StatusLine = { bg = palette.red, fg = palette.bright },
  StatusLineNC = { bg = palette.fg, fg = palette.gray },
  TabLine = { bg = palette.fg, fg = palette.gray },
  TabLineSel = { bg = palette.red, fg = palette.bright },
  TabLineFill = { bg = palette.fg },
  WinSeparator = { fg = palette.gray },
  VertSplit = { fg = palette.gray },
  Folded = { bg = palette.fg, fg = palette.gray },
  FoldColumn = { fg = palette.gray },
  QuickFixLine = { bg = palette.fg },
  FloatBorder = { fg = palette.blue },
  NormalFloat = { bg = palette.fg, fg = palette.black },
  Directory = { fg = palette.blue },
  ModeMsg = { fg = palette.black, bold = true },
  MoreMsg = { fg = palette.blue },
  WarningMsg = { fg = palette.light_red },
  ErrorMsg = { fg = palette.red },
  Question = { fg = palette.blue },
  NonText = { fg = palette.gray },
  SpecialKey = { fg = palette.gray },
  Whitespace = { fg = palette.fg },
  Conceal = { fg = palette.gray },
  EndOfBuffer = { fg = palette.fg },
  DiffAdd = { fg = palette.blue_2 },
  DiffChange = { fg = palette.red },
  DiffDelete = { fg = palette.red },
  DiffText = { bg = palette.blue_2, fg = palette.bright },
  SpellBad = { undercurl = true, fg = palette.red },
  SpellCap = { undercurl = true, fg = palette.blue },
  SpellLocal = { undercurl = true, fg = palette.blue },
  SpellRare = { undercurl = true, fg = palette.red },
}

-- ==========================================================
-- Entry point
-- ==========================================================
local function setup()
  vim.g.terminal_color_0 = "#1b1d1e"
  vim.g.terminal_color_1 = "#e60813"
  vim.g.terminal_color_2 = "#e22928"
  vim.g.terminal_color_3 = "#e24756"
  vim.g.terminal_color_4 = "#2c3fff"
  vim.g.terminal_color_5 = "#2435db"
  vim.g.terminal_color_6 = "#3256ff"
  vim.g.terminal_color_7 = "#fffef6"
  vim.g.terminal_color_8 = "#505354"
  vim.g.terminal_color_9 = "#ff0325"
  vim.g.terminal_color_10 = "#ff3338"
  vim.g.terminal_color_11 = "#fe3a35"
  vim.g.terminal_color_12 = "#1d50ff"
  vim.g.terminal_color_13 = "#747cff"
  vim.g.terminal_color_14 = "#6184ff"
  vim.g.terminal_color_15 = "#fffff9"

  if vim.o.background == "light" then
    apply(light)
    apply(ts_light)
    apply(diagnostics_light)
    apply(ui_light)
  else
    apply(dark)
    apply(ts_dark)
    apply(diagnostics_dark)
    apply(ui_dark)
  end

  vim.g.colors_name = "spiderman"
end

setup()
