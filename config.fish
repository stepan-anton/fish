# Set distro global variable
if type -q lsb_release # This checking is needed or Termux will go crazy
    set -x DISTRO (lsb_release -si)
else
    set -x DISTRO unknown
end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if test -d "$PNPM_HOME"
    if not contains -- "$PNPM_HOME" $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end
end
# pnpm end

# Editor
if type -q hx
    set -x EDITOR hx
else if type -q nvim
    set -x EDITOR nvim
else if type -q vim
    set -x EDITOR vim
else if type -q vi
    set -x EDITOR vi
end

set -x GIT_EDITOR $EDITOR

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0

# Source aliases
for i in $__fish_config_dir/aliases/*.fish
    source $i
end

# Source abbreviations
for i in $__fish_config_dir/abbrs/*.fish
    source $i
end

# Source previous_command
# Needed for !! and !$
if test -e $__fish_config_dir/functions/previous_command.fish
    source $__fish_config_dir/functions/previous_command.fish
end

# Source fish_update
if test -e $__fish_config_dir/functions/fish_update.fish
    source $__fish_config_dir/functions/fish_update.fish
end

# Source private stuff (scripts for this machine only in ./functions/private.fish)
if test -e $__fish_config_dir/functions/private.fish
    source $__fish_config_dir/functions/private.fish
end

# Java and Android
if test (uname) = Darwin
    set -x JAVA_HOME (/usr/libexec/java_home)
    set -x ANDROID_HOME /opt/homebrew/share/android-sdk
    set -x ANDROID_NDK_ROOT /opt/homebrew/share/android-ndk
    set -x DOTNET_ROOT "/opt/homebrew/opt/dotnet@8/libexec"
end

# Godot
if type -q godot
    alias godot4="godot"
end

if status is-interactive
    fish_config theme choose "Dracula Official"

    if type -q starship
        # Why: resolve the prompt config from the active Fish config dir so cloned or symlinked setups load the same file.
        set -gx STARSHIP_CONFIG "$__fish_config_dir/starship.toml"
        starship init fish | source
    end
end
