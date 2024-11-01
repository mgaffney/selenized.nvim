-- Copyright © 2024 Calin Don. All Rights Reserved.

-- lua port of the selenized color scheme
-- see: https://github.com/jan-warchol/selenized
-- with updated values from https://github.com/jan-warchol/selenized/blob/9efeaac1b95a151d5ada36f17f7c4d5c8c3f0741/the-values.md

_G.selenized = _G.selenized or {}

local cmd = vim.cmd
local g = vim.g
local fn = vim.fn


local background = vim.o.background or 'dark'

local none = 'none'
local colors = {
	dark = {
		bg_0       = '#103c48',
		bg_1       = '#184956',
		bg_2       = '#2d5b69',
		dim_0      = '#72898f',
		fg_0       = '#adbcbc',
		fg_1       = '#cad8d9',
		bg_15      = '#14404b', -- bg_1 12% darker for subtle highlighting of embedded, selectable blocks
		dim_1      = '#90998f', -- yellowish dim_0 for things like autocomplete previews
		red        = '#fa5750',
		green      = '#75b938',
		yellow     = '#dbb32d',
		blue       = '#4695f7',
		magenta    = '#f275be',
		cyan       = '#41c7b9',
		orange     = '#ed8649',
		violet     = '#af88eb',
		br_red     = '#ff665c',
		br_green   = '#84c747',
		br_yellow  = '#ebc13d',
		br_blue    = '#58a3ff',
		br_magenta = '#ff84cd',
		br_cyan    = '#53d6c7',
		br_orange  = '#fd9456',
		br_violet  = '#bd96fa',
	},
	light = {
		bg_0       = '#fbf3db',
		bg_1       = '#e9e4d0',
		bg_2       = '#cfcebe',
		dim_0      = '#909995',
		fg_0       = '#53676d',
		fg_1       = '#3a4d53',
		dim_1      = '#909995', -- TODO: yellowish dim_0 for things like autocomplete previews
		bg_15      = '#e9e4d0', -- TODO: bg_1 12% darker for subtle highlighting of embedded, selectable blocks
		red        = '#d2212d',
		green      = '#489100',
		yellow     = '#ad8900',
		blue       = '#0072d4',
		magenta    = '#ca4898',
		cyan       = '#009c8f',
		orange     = '#c25d1e',
		violet     = '#8762c6',
		br_red     = '#cc1729',
		br_green   = '#428b00',
		br_yellow  = '#a78300',
		br_blue    = '#006dce',
		br_magenta = '#c44392',
		br_cyan    = '#00978a',
		br_orange  = '#bc5819',
		br_violet  = '#825dc0',
		deep_dark  = '#181818',
	}
}
_G.selenized.color_scheme = colors
_G.selenized.colors = colors[background]

local highlight = function(name, val)
	val = val or { fg = 'fg', bg = 'bg' }
	if type(val) == 'string' then
		val = { link = val }
	end

	-- Force links
	val.force = true

	-- Make sure that `cterm` attribute is not populated from `gui`
	val.cterm = val.cterm or {}

	-- Define global highlight
	vim.api.nvim_set_hl(0, name, val)
end

---@diagnostic disable-next-line: redefined-local
local highlights = function(colors)
	cmd.hi('clear')
	if fn.exists('syntax_on') then
		cmd.syntax('reset')
	end

	g.colors_name                      = 'selenized'

	g.terminal_color_0                 = colors.bg_1
	g.terminal_color_1                 = colors.red
	g.terminal_color_2                 = colors.green
	g.terminal_color_3                 = colors.yellow
	g.terminal_color_4                 = colors.blue
	g.terminal_color_5                 = colors.magenta
	g.terminal_color_6                 = colors.cyan
	g.terminal_color_7                 = colors.dim_0
	g.terminal_color_8                 = colors.bg_2
	g.terminal_color_9                 = colors.br_red
	g.terminal_color_10                = colors.br_green
	g.terminal_color_11                = colors.br_yellow
	g.terminal_color_12                = colors.br_blue
	g.terminal_color_13                = colors.br_magenta
	g.terminal_color_14                = colors.br_cyan
	g.terminal_color_15                = colors.fg_1

	local hi                           = {}
	hi['Normal']                       = { fg = colors.fg_0, bg = colors.bg_0 }

	hi['IncSearch']                    = { fg = colors.orange, bg = none, reverse = true }
	hi['Search']                       = { fg = colors.yellow, bg = none, reverse = true }
	hi['CurSearch']                    = { fg = colors.br_yellow, bg = none, reverse = true }
	hi['QuickFixLine']                 = 'Search'
	hi['Visual']                       = { fg = none, bg = colors.bg_1 }
	hi['MatchParen']                   = { fg = colors.br_yellow, bg = colors.bg_2, bold = true }
	hi['Cursor']                       = { fg = none, bg = none, reverse = true }
	hi['lCursor']                      = 'Cursor'
	hi['CursorLine']                   = { fg = none, bg = colors.bg_1 }
	hi['CursorColumn']                 = { fg = none, bg = colors.bg_1 }
	hi['Folded']                       = { fg = none, bg = colors.bg_1 }
	hi['ColorColumn']                  = { fg = none, bg = colors.bg_2 }
	hi['LineNr']                       = { fg = colors.dim_0, bg = colors.bg_1 }
	hi['CursorLineNr']                 = { fg = colors.fg_1, bg = none }
	hi['WinSeparator']                 = { fg = colors.dim_0, bg = colors.dim_0 }
	hi['StatusLine']                   = { fg = none, bg = colors.bg_1 }
	hi['StatusLineNC']                 = { fg = none, bg = colors.bg_2 }
	hi['StatusLineTerm']               = 'StatusLine'
	hi['StatusLineTermNC']             = 'StatusLineNC'
	hi['TabLineSel']                   = { fg = colors.fg_1, bg = colors.bg_1, bold = true, reverse = true }
	hi['TabLine']                      = { fg = colors.dim_0, bg = none, reverse = true }
	hi['TabLineFill']                  = { fg = colors.dim_0, bg = none, reverse = true }
	hi['ToolbarButton']                = { fg = none, bg = none, reverse = true }
	hi['ToolbarLine']                  = { fg = none, bg = colors.bg_2 }
	hi['Pmenu']                        = { fg = colors.dim_0, bg = colors.bg_1 }
	hi['PmenuSel']                     = { fg = none, bg = colors.bg_2 }
	hi['PmenuThumb']                   = { fg = none, bg = colors.dim_0 }
	hi['PmenuSbar']                    = { fg = none, bg = colors.bg_2 }
	hi['DiffAdd']                      = { fg = colors.green, bg = colors.bg_1 }
	hi['DiffChange']                   = { fg = none, bg = colors.bg_1 }
	hi['DiffDelete']                   = { fg = colors.red, bg = colors.bg_1 }
	hi['DiffText']                     = { fg = colors.bg_1, bg = colors.yellow }
	hi['Added']                        = { fg = colors.br_green }
	hi['Changed']                      = { fg = colors.br_blue }
	hi['Removed']                      = { fg = colors.br_red }
	hi['Comment']                      = { fg = colors.dim_0, bg = none, italic = true }
	hi['Constant']                     = { fg = colors.cyan, bg = none }
	hi['String']                       = 'Constant'
	hi['Number']                       = 'Constant'
	hi['Boolean']                      = 'Constant'
	hi['Character']                    = 'Constant'
	hi['Float']                        = 'Constant'
	hi['SpecialChar']                  = { fg = colors.violet, bg = none }
	hi['Identifier']                   = { fg = colors.br_blue, bg = none }
	hi['Function']                     = 'Identifier'
	hi['Statement']                    = { fg = colors.br_yellow, bg = none }
	hi['Conditional']                  = 'Statement'
	hi['Repeat']                       = 'Statement'
	hi['Keyword']                      = 'Statement'
	hi['Label']                        = 'Statement'
	hi['Exception']                    = 'Statement'
	hi['Operator']                     = 'Statement'
	hi['PreProc']                      = { fg = colors.orange, bg = none }
	hi['Define']                       = 'PreProc'
	hi['PreCondit']                    = 'PreProc'
	hi['Include']                      = 'PreProc'
	hi['Macro']                        = 'Include'
	hi['Type']                         = { fg = colors.green, bg = none }
	hi['Typedef']                      = 'Type'
	hi['StorageClass']                 = 'Type'
	hi['Structure']                    = 'Type'
	hi['Special']                      = { fg = colors.red, bg = none }
	hi['Delimiter']                    = 'Special'
	hi['SpecialComment']               = 'Special'
	hi['Debug']                        = 'Special'
	hi['Tag']                          = 'Special'
	hi['Error']                        = { fg = colors.red, bg = none, bold = true }
	hi['Todo']                         = { fg = colors.magenta, bg = none, bold = true }
	hi['Underlined']                   = { fg = colors.br_violet, bg = none, underline = true }
	hi['Ignore']                       = { fg = colors.bg_2, bg = none }
	hi['VimCommand']                   = { fg = colors.yellow, bg = none }
	hi['RubyDefine']                   = { fg = colors.fg_1, bg = none, bold = true }

	hi['Terminal']                     = { fg = none, bg = none }
	hi['Conceal']                      = { fg = none, bg = none }
	hi['Directory']                    = { fg = none, bg = none }
	hi['EndOfBuffer']                  = { fg = none, bg = none }
	hi['ErrorMsg']                     = { fg = none, bg = none }
	hi['FoldColumn']                   = { fg = none, bg = none }
	hi['ModeMsg']                      = { fg = none, bg = none }
	hi['MoreMsg']                      = { fg = none, bg = none }
	hi['NonText']                      = { fg = none, bg = none }
	hi['Question']                     = { fg = none, bg = none }
	hi['SignColumn']                   = { fg = none, bg = none }
	hi['SpecialKey']                   = { fg = none, bg = none }
	hi['SpellBad']                     = { fg = none, bg = none, sp = colors.red, undercurl = true }
	hi['SpellCap']                     = { fg = none, bg = none, sp = colors.red, undercurl = true }
	hi['SpellLocal']                   = { fg = none, bg = none, sp = colors.yellow, undercurl = true }
	hi['SpellRare']                    = { fg = none, bg = none, sp = colors.cyan, undercurl = true }
	hi['Title']                        = { fg = none, bg = none }
	hi['VisualNOS']                    = { fg = none, bg = none }
	hi['WarningMsg']                   = { fg = none, bg = none }
	hi['WildMenu']                     = { fg = none, bg = none }
	hi['FloatBorder']                  = { fg = colors.bg_1, bg = none }
	hi['NormalFloat']                  = { fg = colors.dim_0, bg = colors.bg_0 }
	hi['FloatTitle']                   = { fg = colors.dim_0, bg = colors.bg_0 }
	hi['WinBar']                       = { fg = colors.dim_0, bg = colors.bg_0 }

	hi['Suggestion']                   = { fg = colors.dim_1, bg = none, italic = true }
	hi['SnippetTabstop']               = { fg = none, bg = colors.bg_1, italic = true }

	-- snippy nvim
	hi['SnippyPlaceholder']            = 'SnippetTabstop'
	-- vim Copilot
	hi['CopilotSuggestion']            = 'Suggestion'

	-- Built-in diagnostic
	hi['DiagnosticError']              = { fg = colors.red, bg = hi['SignColumn'].bg }
	hi['DiagnosticHint']               = { fg = colors.yellow, bg = hi['SignColumn'].bg }
	hi['DiagnosticInfo']               = { fg = colors.cyan, bg = hi['SignColumn'].bg }
	hi['DiagnosticWarn']               = { fg = colors.cyan, bg = hi['SignColumn'].bg }

	hi['DiagnosticUnderlineError']     = { underline = true, sp = hi['DiagnosticError'].fg }
	hi['DiagnosticUnderlineHint']      = { underline = true, sp = hi['DiagnosticWarn'].fg }
	hi['DiagnosticUnderlineInfo']      = { underline = true, sp = hi['DiagnosticInfo'].fg }
	hi['DiagnosticUnderlineWarn']      = { underline = true, sp = hi['DiagnosticHint'].fg }

	-- Built-in LSP
	hi['LspReferenceText']             = { bg = colors.bg_1 }
	hi['LspReferenceRead']             = 'LspReferenceText'
	hi['LspReferenceWrite']            = 'LspReferenceText'

	hi['LspInfoBorder']                = 'FloatBorder'

	-- nvim-cmp highlight groups
	hi['CmpItemKindClass']             = 'Type'
	hi['CmpItemKindColor']             = 'Special'
	hi['CmpItemKindConstant']          = 'Constant'
	hi['CmpItemKindConstructor']       = 'Type'
	hi['CmpItemKindEnum']              = 'Structure'
	hi['CmpItemKindEnumMember']        = 'Structure'
	hi['CmpItemKindEvent']             = 'Exception'
	hi['CmpItemKindField']             = 'Structure'
	hi['CmpItemKindFile']              = 'Tag'
	hi['CmpItemKindFolder']            = 'Directory'
	hi['CmpItemKindFunction']          = 'Function'
	hi['CmpItemKindInterface']         = 'Structure'
	hi['CmpItemKindKeyword']           = 'Keyword'
	hi['CmpItemKindMethod']            = 'Function'
	hi['CmpItemKindModule']            = 'Structure'
	hi['CmpItemKindOperator']          = 'Operator'
	hi['CmpItemKindProperty']          = 'Structure'
	hi['CmpItemKindReference']         = 'Tag'
	hi['CmpItemKindSnippet']           = 'Special'
	hi['CmpItemKindStruct']            = 'Structure'
	hi['CmpItemKindText']              = 'Statement'
	hi['CmpItemKindTypeParameter']     = 'Type'
	hi['CmpItemKindUnit']              = 'Special'
	hi['CmpItemKindValue']             = 'Identifier'
	hi['CmpItemKindVariable']          = 'Delimiter'
	hi['CmpItemKindCopilot']           = 'Structure'

	-- Git Signs
	hi['GitSignsAdd']                  = { fg = colors.green, bg = colors.bg_1 }
	hi['GitSignsDelete']               = { fg = colors.red, bg = colors.bg_1 }
	hi['GitSignsChange']               = { fg = colors.blue, bg = colors.bg_1 }

	hi['ColorColumn']                  = { fg = none, bg = colors.bg_1 }
	hi['WinSeparator']                 = { fg = colors.bg_2, bg = none, bold = true }

	-- Identifiers
	hi['@variable']                    = 'Identifier' -- various variable names
	hi['@variable.builtin']            = 'Special'   -- built-in variable names (e.g. `this`)
	hi['@variable.parameter']          = 'Identifier' -- parameters of a function
	hi['@variable.parameter.builtin']  = 'Special'   -- special parameters (e.g. `_`, `it`)
	hi['@variable.member']             = 'Identifier' -- object and struct fields

	hi['@constant']                    = 'Constant'  -- constant identifiers
	hi['@constant.builtin']            = 'Special'   -- built-in constant values
	hi['@constant.macro']              = 'Define'    -- constants defined by the preprocessor

	hi['@module']                      = 'Identifier' -- modules or namespaces
	hi['@module.builtin']              = 'Special'   -- built-in modules or namespaces
	hi['@label']                       = 'Label'     -- GOTO and other labels (e.g. `label:` in C), including heredoc labels

	-- Literals
	hi['@string']                      = 'String'     -- string literals
	hi['@string.documentation']        = 'Comment'    -- string documenting code (e.g. Python docstrings)
	hi['@string.regexp']               = 'SpecialChar' -- regular expressions
	hi['@string.escape']               = 'SpecialChar' -- escape sequences
	hi['@string.special']              = 'SpecialChar' -- other special strings (e.g. dates)
	hi['@string.special.symbol']       = 'SpecialChar' -- symbols or atoms
	hi['@string.special.url']          = 'Underlined' -- URIs (e.g. hyperlinks)
	hi['@string.special.path']         = 'Underlined' -- filenames

	hi['@character']                   = 'Character'  -- character literals
	hi['@character.special']           = 'SpecialChar' -- special characters (e.g. wildcards)

	hi['@boolean']                     = 'Boolean'    -- boolean literals
	hi['@number']                      = 'Number'     -- numeric literals
	hi['@number.float']                = 'Float'      -- floating-point number literals

	-- Types
	hi['@type']                        = 'Type'      -- type or class definitions and annotations
	hi['@type.builtin']                = 'Special'   -- built-in types
	hi['@type.definition']             = 'TypeDef'   -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)

	hi['@attribute']                   = 'Macro'     -- attribute annotations (e.g. Python decorators, Rust lifetimes)
	hi['@attribute.builtin']           = 'Special'   -- builtin annotations (e.g. `@property` in Python)
	hi['@property']                    = 'Identifier' -- the key in key/value pairs

	-- Functions
	hi['@function']                    = 'Function' -- function definitions
	hi['@function.builtin']            = 'Special' -- built-in functions
	hi['@function.call']               = 'Function' -- function calls
	hi['@function.macro']              = 'Macro'   -- preprocessor macros

	hi['@function.method']             = 'Function' -- method definitions
	hi['@function.method.call']        = 'Function' -- method calls

	hi['@constructor']                 = 'Special' -- constructor calls and definitions
	hi['@operator']                    = 'Operator' -- symbolic operators (e.g. `+` / `*`)

	-- Keywords
	hi['@keyword']                     = 'Keyword'    -- keywords not fitting into specific categories
	hi['@keyword.coroutine']           = 'Special'    -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
	hi['@keyword.function']            = 'Keyword'    -- keywords that define a function (e.g. `func` in Go, `def` in Python)
	hi['@keyword.operator']            = 'Operator'   -- operators that are English words (e.g. `and` / `or`)
	hi['@keyword.import']              = 'Include'    -- keywords for including or exporting modules (e.g. `import` in Python)
	hi['@keyword.type']                = 'Keyword'    -- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
	hi['@keyword.modifier']            = 'Keyword'    -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
	hi['@keyword.repeat']              = 'Repeat'     -- keywords related to loops (e.g. `for` / `while`)
	hi['@keyword.return']              = 'Statement'  -- keywords like `return` and `yield`
	hi['@keyword.debug']               = 'Debug'      -- keywords related to debugging
	hi['@keyword.exception']           = 'Exception'  -- keywords related to exceptions (e.g. `throw` / `catch`)

	hi['@keyword.conditional']         = 'Conditional' -- keywords related to conditionals (e.g. `if` / `else`)
	hi['@keyword.conditional.ternary'] = 'Conditional' -- ternary operator (e.g. `?` / `:`)

	hi['@keyword.directive']           = 'Define'     -- various preprocessor directives & shebangs
	hi['@keyword.directive.define']    = 'Define'     -- preprocessor definition directives

	hi['@keyword.luadoc']              = { bold = false, nocombine = true }

	-- Punctuation
	hi['@punctuation.delimiter']       = 'Delimiter' -- delimiters (e.g. `;` / `.` / `,`)
	hi['@punctuation.bracket']         = 'Delimiter' -- brackets (e.g. `()` / `{}` / `[]`)
	hi['@punctuation.special']         = 'Special'  -- special symbols (e.g. `{}` in string interpolation)

	-- Comments
	hi['@comment']                     = 'Comment'                                                               -- line and block comments
	hi['@comment.documentation']       =
	'Comment'                                                                                                    -- comments documenting code

	hi['@comment.error']               = { fg = colors.bg_0, bg = colors.red, bold = true, nocombine = true }    -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
	hi['@comment.warning']             = { fg = colors.bg_0, bg = colors.yellow, bold = true, nocombine = true } -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
	hi['@comment.todo']                = { fg = colors.bg_0, bg = colors.magenta, bold = true, nocombine = true } -- todo-type comments (e.g. `TODO`, `WIP`)
	hi['@comment.note']                = { fg = colors.bg_0, bg = colors.cyan, bold = true, nocombine = true }   -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)

	-- Diff
	hi['@diff.plus']                   = 'Added'  -- added text (for diff files)
	hi['@diff.minus']                  = 'Removed' -- deleted text (for diff files)
	hi['@diff.delta']                  = 'Changed' -- changed text (for diff files)

	-- Tags
	hi['@tag']                         = 'Tag'       -- XML-style tag names (and similar)
	hi['@tag.builtin']                 = 'Special'   -- builtin tag names (e.g. HTML5 tags)
	hi['@tag.attribute']               = 'Identifier' -- XML-style tag attributes
	hi['@tag.delimiter']               = 'Delimiter' -- XML-style tag delimiters

	-- Markup
	hi['@markup.raw']                  = { bg = colors.bg_15 }
	hi['@markup.link']                 = 'Identifier'
	hi['@markup.heading']              = { fg = colors.fg_1, bold = true }
	hi['@markup.link.url']             = 'Underlined'
	hi['@markup.underline']            = 'Underlined'

	-- LSP semantic tokens
	hi['@lsp.type.comment']            = {}             -- reset since it interferes with the `@comment` group
	hi['@lsp.mod.defaultLibrary']      = 'Special'      -- default library symbols
	hi['@lsp.mod.globalScope']         = { bold = true } -- global scope symbols
	hi['@lsp.mod.global']              = { bold = true } -- global scope symbols

	hi['@lsp.mod.documentation.lua']   = '@keyword.luadoc'

	-- hi['@lsp.type.class']             = 'Structure'
	-- hi['@lsp.type.decorator']         = 'Function'
	-- hi['@lsp.type.enum']              = 'Structure'
	-- hi['@lsp.type.enumMember']        = 'Constant'
	-- hi['@lsp.type.function']          = 'Function'
	-- hi['@lsp.type.interface']         = 'Structure'
	-- hi['@lsp.type.macro']             = 'Macro'
	-- hi['@lsp.type.method']            = 'Function'
	-- hi['@lsp.type.namespace']         = 'Structure'
	-- hi['@lsp.type.parameter']         = 'Identifier'
	-- hi['@lsp.type.property']          = 'Identifier'
	-- hi['@lsp.type.struct']            = 'Structure'
	-- hi['@lsp.type.type']              = 'Type'
	-- hi['@lsp.type.typeParameter']     = 'TypeDef'
	-- hi['@lsp.type.variable']          = 'Identifier'

	for group, highlights in pairs(hi) do
		highlight(group, highlights)
	end
	_G.selenized.colors = colors
end
highlights(colors[background])
