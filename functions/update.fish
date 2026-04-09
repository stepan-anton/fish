function print_package_manager --argument-names pm
    set_color blue
    set_color --bold
    echo "--- $pm ---"
    set_color normal
end

function update
    # NixOS
    if test -f /etc/NIXOS
        print_package_manager NixOS
        if type -q nh
            nh os switch --update --impure
            git status -s
        else
            sudo nix-channel --update
            sudo nixos-rebuild switch
        end
    else if type -q nix
        print_package_manager Nix
        nix-channel --update
        nix-env -u
    end

    # Arch
    if type -q yay
        print_package_manager Arch
        sudo yay -Syu
    else if type -q pacman
        print_package_manager Arch
        sudo pacman -Syu
    end

    # Bun programs
    if type -q bun
        print_package_manager Bun
        bun update -g --latest
    end

    if type -q npm
        print_package_manager "Global npm packages"
        npm -g outdated; or true
        npm update -g
    end

    # Debian
    if test (uname) != Darwin
        if type -q nala
            print_package_manager Debian
            sudo nala update
            sudo nala upgrade
        else if type -q apt
            print_package_manager Debian
            sudo apt update
            sudo apt upgrade
        end
    end

    # Fedora
    if type -q dnf
        print_package_manager Fedora
        sudo dnf update
    end

    # Flatpak
    if type -q flatpak
        print_package_manager Flatpak
        sudo flatpak update -y
        sudo flatpak remove --unused -y
    end

    # macOS
    if type -q brew
        print_package_manager Homebrew
        brew update
        brew outdated --greedy

        read -P "Do you want to upgrade all brew packages? [Y/n] " reply

        switch (string lower $reply)
            case "" y yes
                brew upgrade --greedy
        end
    end

    if type -q ghcup
        print_package_manager GHCup
        ghcup upgrade -i
    end

    # OpenCode extension manager
    if type -q ocx
        print_package_manager "OpenCode extension manager"
        ocx update -g --all
    end

    if type -q opencode
        print_package_manager OpenCode
        opencode upgrade
    end

    if type -q dotnet
        set -l dotnet_tools (dotnet tool list --global 2>/dev/null | string match -v -r '^(Package Id|[-[:space:]]*$)')
        set -l dotnet_workloads (dotnet workload list 2>/dev/null | string match -v -r '^(Installed Workload Id|[-[:space:]]*$|Use `dotnet workload search`.*)')

        if test (count $dotnet_tools) -gt 0 -o (count $dotnet_workloads) -gt 0
            print_package_manager ".NET"

            if test (count $dotnet_tools) -gt 0
                for line in $dotnet_tools
                    set -l tool_id (string split '\t' -- (string replace -r '\s{2,}' '\t' -- (string trim -- $line)))[1]
                    if test -n "$tool_id"
                        dotnet tool update --global $tool_id
                    end
                end
            end

            if test (count $dotnet_workloads) -gt 0
                dotnet workload update
            end
        end
    end

    # Rust
    if type -q rustup
        print_package_manager Rust
        rustup update
    end

    # Rust programs
    if type -q cargo
        if type -q cargo-install-update
            print_package_manager "Rust programs"
            cargo install-update -a
        else
            echo "Cargo is installed, but cargo-update is not."
            echo "Run 'cargo install cargo-update' to install it."
            echo "Unable to update Rust programs."
        end
    end

    # Snap
    if type -q snap
        print_package_manager Snap
        sudo snap refresh
    end

    # Windows
    if type -q scoop
        print_package_manager Scoop
        scoop update
        scoop upgrade
    end

    # Fish config
    if test -d "$fish_config/.git"
        print_package_manager "Fish config"
        fish_update
    end

    # Fisher
    if functions -q fisher
        print_package_manager Fisher
        fisher update
        git -C "$fish_config" status -s
    end
end
