#!/bin/sh -e

DOTFILES_LOCATION="$HOME/jeev-dotfiles"

if ! command -v pacman >/dev/null; then
    printf "%b\n" "Only Arch-based distributions are supported as of now !!"
    exit 1
fi

if [ -d "$DOTFILES_LOCATION" ]; then
    printf "%b\n" "$DOTFILES_LOCATION already exists. Do you want to remove it? [Y\n]"
    read -r choice
    choice=${choice:-Y}
    if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
        rm -rf "$DOTFILES_LOCATION"
    else
        exit 0
    fi
fi

git clone "https://github.com/jeevithakannan2/dotfiles" "$DOTFILES_LOCATION"
cd "$DOTFILES_LOCATION" || exit 1

prompt() {
    printf "%b\n" "Jeev DotFiles Installer !!"
    printf "%b\n" "Choose what to install"
    printf "%b\n" "1. Hypr Catppuccin"
    printf "%b\n" "2. QT theme Catppuccin"
    printf "%b\n" "0. Exit"
    printf "%b" "Your choice [ 0-2 ]: "
    read -r choice
}

prompt

while [ "$choice" != "0" ]; do
    case "$choice" in
        1)
            ./scripts/hypr.sh
            ;;
        2)
            ./scripts/qt-theme.sh
            ;;
        *)
            printf "%b\n" "Invalid choice. Please select a valid option."
            ;;
    esac
    prompt
done

printf "%b\n" "Exiting. Thank you for using Jeev DotFiles Installer!"