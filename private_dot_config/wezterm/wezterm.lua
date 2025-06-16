-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Chalk'
config.color_scheme = 'Breeze (Gogh)'
-- config.color_scheme = 'OneDark (base16)'
config.font_size = 16
config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Noto Sans TC',
  'Noto Sans CJK TC',
}

config.default_prog = { 'fish' }

config.scrollback_lines = 100000


local io = require 'io'
local os = require 'os'
local act = wezterm.action

-- almost identical to https://wezterm.org/config/lua/wezterm/on.html#example-opening-whole-scrollback-in-vim,
-- but open in new tab
wezterm.on('trigger-vim-with-scrollback', function(window, pane)
  -- Retrieve the text from the pane
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  -- Create a temporary file to pass to vim
  local name = os.tmpname()
  local f = io.open(name, 'w+')
  f:write(text)
  f:flush()
  f:close()

  -- Open a new window running vim and tell it to open the file
  window:perform_action(
    act.SpawnCommandInNewTab {
      args = { 'nvim', name },
    },
    pane
  )

  -- Wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous wrt. running
  -- this script and are not awaitable, so we just pick a number.
  --
  -- Note: We don't strictly need to remove this file, but it is nice
  -- to avoid cluttering up the temporary directory.
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

config.keys = {
  { key = 'UpArrow',   mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },
  {
    key = 'E',
    mods = 'CTRL',
    action = act.EmitEvent 'trigger-vim-with-scrollback',
  },
}

-- and finally, return the configuration to wezterm
return config

