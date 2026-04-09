# Confirm before overwriting files and make it verbose
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# Mkdir will create parent dirs and will be verbose
alias mkdir="mkdir -pv"

# Better finding files
alias f="find . | rg"

# Set Autojump to j
alias j="z"

# Human readable flags
alias df="df -h"
alias du="du -h"
alias free="free -h"

# Rickroll
alias rickroll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

# Better showing contents of a file
if type -q batcat
    alias cat="batcat"
else if type -q bat
    alias cat="bat"
end

# Simpler quitting shell
alias q="exit"

# show IP
alias myip="curl ipinfo.io/ip"

# Simpler clear
alias cl="clear"

# Du sorted
alias dusort="du -sc * | sort -h"
