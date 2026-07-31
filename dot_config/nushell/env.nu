# Nushell Environment Config File

# Inside env.nu, $env.PATH is still a string — nushell converts it to a list
# only after env.nu and config.nu are read. Split it once so the edits below
# operate on a proper list.
$env.PATH = ($env.PATH | split row (char esep))

# Homebrew (macOS only) — prepended for priority
if $nu.os-info.name == "macos" {
    $env.PATH = ($env.PATH | prepend ["/opt/homebrew/bin" "/opt/homebrew/sbin"])
}

# opencode
let opencode_bin = ($env.HOME | path join ".opencode" "bin")
if ($opencode_bin | path exists) {
    $env.PATH = ($env.PATH | append $opencode_bin)
}

# env.nu runs once per nested shell; dedup so PATH doesn't accumulate
$env.PATH = ($env.PATH | uniq)
