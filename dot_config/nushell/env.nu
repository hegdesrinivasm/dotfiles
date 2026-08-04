# Nushell Environment Config File

# Inside env.nu, $env.PATH is still a string — nushell converts it to a list
# only after env.nu and config.nu are read. Split it once so the edits below
# operate on a proper list.
$env.PATH = ($env.PATH | split row (char esep))

# Homebrew (macOS only) — prepended for priority
if $nu.os-info.name == "macos" {
    $env.PATH = ($env.PATH | prepend ["/opt/homebrew/bin" "/opt/homebrew/sbin"])
}

# pyenv — nushell is the login shell, so .zshrc never runs; add shims ourselves
$env.PYENV_ROOT = ($env.HOME | path join ".pyenv")
let pyenv_shims = ($env.PYENV_ROOT | path join "shims")
if ($pyenv_shims | path exists) {
    $env.PATH = ($env.PATH | prepend $pyenv_shims)
}

# opencode
let opencode_bin = ($env.HOME | path join ".opencode" "bin")
if ($opencode_bin | path exists) {
    $env.PATH = ($env.PATH | append $opencode_bin)
}

# chezmoi
let local_bin = ($env.HOME | path join ".local" "bin")
if ($local_bin | path exists) {
    $env.PATH = ($env.PATH | append $local_bin)
}

# env.nu runs once per nested shell; dedup so PATH doesn't accumulate
$env.PATH = ($env.PATH | uniq)
