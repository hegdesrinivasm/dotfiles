# Nushell configuration — sourced after env.nu on every startup.
# PATH is managed in env.nu (hand-maintained, not templated).
#
# Validated against nushell 0.115.0 ($nu.config-path). On macOS this file is
# symlinked from ~/Library/Application Support/nushell/config.nu via
# Library/Application Support/nushell/symlink_config.nu.

# Default editor
$env.config.buffer_editor = "code --wait"

# History
$env.config.history = {
  max_size: 10000
  sync_on_enter: true
}

# Color output — Spiderman palette (see dot_config/starship.toml)
$env.config.color_config = {
  separator: "#505354"
  leading_trailing_space_bg: "#505354"
  header: "#6184ff"
  datetime: "#6184ff"
  row_index: "#e60813"
  bool: "#6184ff"
  int: "#6184ff"
  filesize: "#6184ff"
  hints: "#505354"
  search_result: "#ff0325"
}

# Prompt indicator
$env.PROMPT_INDICATOR = {|| " " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
