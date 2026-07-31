# Nushell Environment Config File

# PATH is a list inside nushell, but external commands need a string.
# Newer nushell converts PATH internally; older nushell needs these
# ENV_CONVERSIONS entries to serialize a list PATH when running commands.
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Homebrew (macOS) — harmless on Linux, prepended for priority
let _path = if (($env.PATH | describe) | str contains "list") {
    $env.PATH
} else {
    $env.PATH | split row (char esep)
}
$env.PATH = ($_path | prepend ["/opt/homebrew/bin" "/opt/homebrew/sbin"])

# opencode
if ($env.HOME | path join ".opencode" "bin" | path exists) {
    $env.PATH = ($env.PATH | append ($env.HOME | path join ".opencode" "bin"))
}
