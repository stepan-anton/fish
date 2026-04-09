# Update function
function fish_update
    if not test -d "$fish_config/.git"
        return
    end

    set -l fish_status (git -C "$fish_config" status --porcelain 2>/dev/null)
    if test -n "$fish_status"
        # Why: this repo is intentionally customized locally, so auto-pulling over dirty changes is unsafe.
        echo "Skipping git pull because $fish_config has local changes:"
        git -C "$fish_config" status -s
        return
    end

    git -C "$fish_config" pull --ff-only
end
