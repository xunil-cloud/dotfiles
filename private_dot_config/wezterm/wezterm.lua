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
config.font_size = 14

-- Spawn a fish shell in login mode
config.default_prog = { '/usr/bin/fish', '-l' }

config.scrollback_lines = 100000

-- and finally, return the configuration to wezterm
return config

