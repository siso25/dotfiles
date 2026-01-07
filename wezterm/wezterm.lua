local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.automatically_reload_config = true
config.font = wezterm.font "HackGen Console NF"
config.font_size = 15.0
config.use_ime = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.initial_cols = 120
config.initial_rows = 40
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.window_background_gradient = {
  colors = { "#24273a" },
}
config.show_new_tab_button_in_tab_bar = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5b6078"
  local foreground = "#FFFFFF"

  if tab.is_active then
    background = "#8aadf4"
    foreground = "#FFFFFF"
  end

  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

config.color_scheme = "Catppuccin Macchiato"

config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

return config
