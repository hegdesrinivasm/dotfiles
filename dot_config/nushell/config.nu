# Nushell configuration — sourced after env.nu on every startup.
# Customize here; PATH is managed in env.nu (hand-maintained, not templated).

# Default editor
$env.config.editor = "code --wait"

# History
$env.config.history = {
  file_size: 10000
  duration: 10000
  sync: true
}

# Color output
$env.config.color_config = {
  separator: "#505354"
  leading_trailing_space_bg: "#505354"
  header: "#6184ff"
  date: "#6184ff"
}

# Prompt
$env.config.prompt = {
  left_indicator: ""
  right_indicator: ""
  prompt: " "
}
