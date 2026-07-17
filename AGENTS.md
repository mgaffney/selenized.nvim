# AGENTS.md

Single-file Neovim colorscheme — a Lua port of jan-warchol/selenized. No build,
test, lint, or CI tooling exists. Verify changes by sourcing the colorscheme in
Neovim (`:colorscheme selenized`).

## Testing color changes

When a plan or change involves a highlight tweak, always include a
paste-ready `:lua` one-liner so the change can be applied to an
already-running Neovim instance for live inspection and adjustment
before committing. Use the cached palette, e.g.:

	:lua vim.api.nvim_set_hl(0, 'GroupName', { fg = _G.selenized.colors.dim_0, italic = true })

`_G.selenized.colors` is the active variant's palette (set at
colorscheme load). Omit `bg` for transparent behavior — passing
`bg = 'none'` as a string can error in `nvim_set_hl`.

## Layout

- `colors/selenized.lua` — the entire theme: the `dark`/`light` palette tables
  plus every highlight group (~433 lines). Nearly all edits happen here.
- `lua/lualine/themes/selenized.lua` — lualine statusline theme.

## Gotchas

- **Load order**: `lua/lualine/themes/selenized.lua` reads the global
  `selenized.colors`, which only exists after `colors/selenized.lua` runs. The
  colorscheme must load before the lualine theme.
- **Background**: the active variant is picked from `vim.o.background` at load
  time and cached in `_G.selenized.colors`. No live toggle — re-source to switch
  dark/light. Palette is also exposed as `_G.selenized.color_scheme`.
- **Light variant is incomplete**: some `light` values are `TODO` placeholders
  (e.g. `bg_15`, `dim_1`). Dark is the primary, maintained theme.

## Editing conventions

- Hard tabs; `hi[...] =` assignments are column-aligned. Preserve both.
- Highlights are grouped into sections (base groups, treesitter `@...`, LSP
  `@lsp...`), most defined as string links to base groups (e.g. `hi['String'] =
  'Constant'`).
- `.luarc.json` is gitignored (machine-specific lua-language-server config); do
  not commit it.

## Commits

- Commit messages follow the 50/72 rule: subject line ≤50 chars, blank line,
  body wrapped at ≤72 chars.
- Always include the full commit message in the plan before committing.
- Break work into separate, focused commits — one logical change per commit.
