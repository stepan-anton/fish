if type -q eza
    alias l="eza -F --icons --group-directories-first"
    alias ls="eza -F --icons --group-directories-first"
    alias la="eza -aF --icons --group-directories-first"
    alias ll="eza -lhF --icons --git --group-directories-first"
    alias lr="eza -RF --icons --group-directories-first"
    alias lt="eza -TF --icons --group-directories-first"
else if type -q exa
    alias l="exa -F --icons --group-directories-first"
    alias ls="exa -F --icons --group-directories-first"
    alias la="exa -aF --icons --group-directories-first"
    # Why: Ubuntu's exa package is built without git support, so `--git` always fails there.
    alias ll="exa -lhF --icons --group-directories-first"
    alias lr="exa -RF --icons --group-directories-first"
    alias lt="exa -TF --icons --group-directories-first"
else
    alias l="ls -F --group-directories-first"
    alias ls="ls -F --group-directories-first"
    alias la="ls -aF --group-directories-first"
    alias ll="ls -lhF --group-directories-first"
    alias lr="ls -RF --group-directories-first"
    alias lt="ls -tF --group-directories-first"
end
