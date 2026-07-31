# Nushell Environment Config File

# Homebrew (macOS) — harmless on Linux, prepended for priority
$env.PATH = ($env.PATH | prepend ["/opt/homebrew/bin" "/opt/homebrew/sbin"])

# opencode
if ($env.HOME | path join ".opencode" "bin" | path exists) {
    $env.PATH = ($env.PATH | append ($env.HOME | path join ".opencode" "bin"))
}
