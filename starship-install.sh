#!/bin/bash

# Script: starship-install.sh
# Description: Install Starship prompt with any desired preset, configure terminals, and set fonts.
# Author: Mohammed Abdul Raqeeb
# Date: 31/01/2024


# ------- Automated Starship Installation Script -------

## ===========================================================================
### Functions

#Function to print blank lines and sleep
log_and_pause(){
    sleep 2
    echo -e "\n"
}

## --------------------------------------------------------------------------
# Function to install required dependencies
install_dependencies() {
    echo -e "\nInstalling dependencies..."
    log_and_pause

    sudo apt install curl wget unzip -y

    log_and_pause
}

## --------------------------------------------------------------------------
# Function to install Starship
install_starship(){
    # Check if Starship is installed
    if ! command -v starship &>/dev/null; then
        echo "Starship not found, installing..."
        log_and_pause
        
        # Install Starship
        sudo curl -sS https://starship.rs/install.sh | sh -s -- -y || { echo "Error: Starship installation failed."; exit 1 ;}
    else
        echo -e "Starship is already installed.\n"
    fi

    log_and_pause
}

## --------------------------------------------------------------------------
# Function to prompt user for preset selection
select_starship_preset() {
    echo -e "\nSelect a Starship prompt preset:\n"
    
    echo " 1. Nerd Font Symbols"
    echo " 2. No Nerd Font"
    echo " 3. Bracketed Segments"
    echo " 4. Plain Text Symbols"
    echo " 5. No Runtime Versions"
    echo " 6. No Empty Icons"
    echo " 7. Pure Preset"
    echo " 8. Pastel Powerline"
    echo " 9. Tokyo Night"
    echo " 10. Gruvbox Rainbow"
    echo " 11. Custom Starship Configuration"
    echo -e " 12. None, Exit\n"

    sleep 1
    read -p "Enter the number corresponding to your choice: " choice

    case $choice in
        1) apply_starship_preset "nerd-font-symbols" ;;
        2) apply_starship_preset "no-nerd-font" ;;
        3) apply_starship_preset "bracketed-segments" ;;
        4) apply_starship_preset "plain-text-symbols" ;;
        5) apply_starship_preset "no-runtime-versions" ;;
        6) apply_starship_preset "no-empty-icons" ;;
        7) apply_starship_preset "pure-preset" ;;
        8) apply_starship_preset "pastel-powerline" ;;
        9) apply_starship_preset "tokyo-night" ;;
        10) apply_starship_preset "gruvbox-rainbow" ;;
        11) custom_starship_configuration ;;
        12) echo -e "\nExiting..."; log_and_pause; exit 1 ;;
        *) echo -e "\nInvalid choice. Exiting..."; log_and_pause; exit 1 ;;
    esac
}

custom_starship_configuration(){
    echo -e "\n\n\nApplying Custom Starship preset..."
    log_and_pause

    mkdir -p ~/.config && touch ~/.config/starship.toml
    
    cat << 'EOF' > ~/.config/starship.toml
format = """
[](#B54BBB)\
$os\
$username\
[](fg:#B54BBB bg:#FF758E)\
$directory\
[](fg:#FF758E bg:#FFB366)\
$git_branch\
$git_status\
[](fg:#FFB366 bg:#00BFFF)\
$c\
$elixir\
$elm\
$golang\
$gradle\
$haskell\
$java\
$julia\
$nodejs\
$nim\
$python\
$rust\
$scala\
[](fg:#00BFFF bg:#4A90E2)\
$time\
[](fg:#4A90E2)\
$cmd_duration\
[\n  ](fg:#7FFF7F)\
"""
#  #9A348E
# Disable the blank line at the start of the prompt
# add_newline = false

# You can also replace your username with a neat symbol like   or disable this
# and use the os module below
[username]
show_always = true
style_user = "bg:#B54BBB fg:#FFFFFF bold"
style_root = "bg:#B54BBB fg:#FFFFFF bold"
format = '[$user ]($style)'
disabled = false

# An alternative to the username module which displays a symbol that
# represents the current operating system
[os]
style = "bg:#B54BBB"
disabled = true # Disabled by default

[directory]#FF758E #DA627D
style = "bg:#FF758E fg:#FFFFFF bold"
format = "[ $path ]($style)"
truncation_length = 5
truncation_symbol = "…/"

# Here is how you can shorten some long paths by text replacement
# similar to mapped_locations in Oh My Posh:
[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "
# Keep in mind that the order matters. For example:
# "Important Documents" = " 󰈙 "
# will not be replaced, because "Documents" was already substituted before.
# So either put "Important Documents" before "Documents" or use the substituted version:
# "Important 󰈙 " = " 󰈙 "

[c]
symbol = " "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ]($style)'

[docker_context]
symbol = " "
style = "bg:#86BBD8 fg:#FFFFFF"
format = '[ $symbol $context ]($style) $path'

[elixir]
symbol = " "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[elm]
symbol = " "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[git_branch]
symbol = ""
style = "bg:#FFB366 fg:#FFFFFF bold"
format = '[ $symbol $branch ]($style)'

[git_status]
style = "bg:#FFB366 fg:#FFFFFF bold"
format = '[$all_status$ahead_behind ]($style)'

[golang]
symbol = " "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[gradle]
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[haskell]
symbol = " "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[java]
symbol = ""
style = "bg:#00BFFF fg:#FFFFFF bold"
format = '[ $symbol ]($style)'

[julia]
symbol = " "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[nodejs]
symbol = ""
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[nim]
symbol = "󰆥 "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'
 
[python]
symbol = ""
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ]($style)'

[rust]
symbol = ""
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[scala]
symbol = " "
style = "bg:#00BFFF fg:#FFFFFF"
format = '[ $symbol ($version) ]($style)'

[time] #33658A
disabled = false
time_format = "%I:%M %p" # Hour:Minute AM/PM Format
style = "bg:#4A90E2 fg:#FFFFFF bold"
format = '[ ♥ $time ]($style)'

[cmd_duration]
style = " fg:#00FF00 bold"
format = '[   $duration ]($style)'
min_time = 300
EOF

    echo -e "Custom Starship preset applied successfully.\n"
}

## --------------------------------------------------------------------------
# Function to apply selected Starship preset
apply_starship_preset() {
    local preset=$1
    echo -e "\n\n\nApplying Starship $preset preset..."
    log_and_pause

    mkdir -p ~/.config && touch ~/.config/starship.toml
    starship preset "$preset" -o ~/.config/starship.toml
    
    echo -e "Starship $preset preset applied successfully.\n"
}

## --------------------------------------------------------------------------
# Function to setup starship 
setup_starship_config() {
    echo "Setting up starship configuration file..."
    log_and_pause

    if [ -f ~/.config/starship.toml ]; then
        echo "Starship is already configured."
        read -p "Do you want to configure a different preset? (Y/N): " choice

        # Convert the user input to lowercase for case-insensitive comparison
        case "${choice,,}" in
            y|yes|"")  # Accept 'y', 'yes', 'Y', 'YES', 'Yes', or Enter key
                sleep 1 ; select_starship_preset ;;
            *)
                echo -e "\nConfiguration file is unchanged." ;;
        esac
    else
        select_starship_preset
    fi

    log_and_pause
}

## --------------------------------------------------------------------------
# Function to confirm changes to ~/.bashrc file
confirm_bashrc(){
    if [ -f ~/.bashrc ]; then
        # Check if the ~/.bashrc file contains the line 'eval "$(starship init bash)"'
        if grep -q 'eval "$(starship init bash)"' ~/.bashrc; then
            echo -e "Starship is already configured in ~/.bashrc\n"
            return
        fi

        read -p "Do you want to configure the ~/.bashrc file? (y/n, default: yes): " bash_response
        
        # Convert the user input to lowercase for case-insensitive comparison
        case "${bash_response,,}" in
            y|yes|"") configure_bashrc ;;  # Accept 'y', 'yes', 'Y', 'YES', 'Yes', or Enter key
            *) echo -e "\nSkipped ~/.bashrc configuration."; log_and_pause ;;    # Any other input is considered negative
        esac
    fi
}

## --------------------------------------------------------------------------
# Function to configure Starship in ~/.bashrc
configure_bashrc() {
    echo "Configuring the ~/.bashrc file..."
    log_and_pause

    sed -i '/export PROMPT_COMMAND="echo"/d' ~/.bashrc
    sed -i '/eval "$(starship init bash)"/d' ~/.bashrc
    echo -e '\nexport PROMPT_COMMAND="echo"\neval "$(starship init bash)"' >> ~/.bashrc

    echo "Done!"
    font_cache=1
    log_and_pause
}

## --------------------------------------------------------------------------
# Function to confirm changes to config.fish file
confirm_fish(){
    if [ -f ~/.config/fish/config.fish ]; then
        # Check if the ~/.config/fish/config.fish file contains the line 'starship init fish | source'
        if grep -q 'starship init fish | source' ~/.config/fish/config.fish; then
            echo -e "Starship is already configured in ~/.config/fish/config.fish\n"
            return
        fi

        read -p "Do you want to configure the ~/.config/fish/config.fish file? (y/n, default: yes): " fish_response
        
        # Convert the user input to lowercase for case-insensitive comparison
        case "${fish_response,,}" in
            y|yes|"") configure_fish ;;  # Accept 'y', 'yes', 'Y', 'YES', 'Yes', or Enter key
            *) echo -e "\nSkipped config.fish configuration."; log_and_pause ;;    # Any other input is considered negative
        esac
    fi
}

## --------------------------------------------------------------------------
# Function to configure Starship in config.fish file
configure_fish(){
    echo -e "\nConfiguring the ~/.config/fish/config.fish file..."
    log_and_pause

    sed -i '/starship init fish | source/d' ~/.config/fish/config.fish
    echo -e "\nstarship init fish | source" >> ~/.config/fish/config.fish

    echo "Done!"
    font_cache=1
    log_and_pause
}

## --------------------------------------------------------------------------
# Function to confirm changes to ~/.zshrc file
confirm_zshrc(){
    if [ -f ~/.zshrc ]; then
        # Check if the ~/.zshrc file contains the line 'eval "$(starship init zsh)"'
        if grep -q 'eval "$(starship init zsh)"' ~/.zshrc; then
            echo -e "Starship is already configured in ~/.zshrc\n"
            return
        fi

        read -p "Do you want to configure the ~/.zshrc file? (y/n, default: yes): " zsh_response
        
        # Convert the user input to lowercase for case-insensitive comparison
        case "${zsh_response,,}" in
            y|yes|"") configure_zshrc ;;  # Accept 'y', 'yes', 'Y', 'YES', 'Yes', or Enter key
            *) echo -e "\nSkipped .zshrc configuration."; log_and_pause ;;    # Any other input is considered negative
        esac
    fi
}

## --------------------------------------------------------------------------
# Function to configure Starship in ~/.zshrc file
configure_zshrc() {
    echo -e "\nConfiguring the  ~/.zshrc file..."
    log_and_pause

    sed -i '/eval "$(starship init zsh)"/d' ~/.zshrc
    echo -e "\neval \"$(starship init zsh)\"" >> ~/.zshrc

    echo "Done!"
    font_cache=1
    log_and_pause
    
}

## --------------------------------------------------------------------------
# Function to check Caskaydia Cove Nerd font if installed
check_caskaydia_font() {
    echo -e "\nChecking whether Caskaydia Cove Nerd font is installed..."
    log_and_pause

    mkdir -p ~/.local/share/fonts/

    if ls ~/.local/share/fonts/ | grep Caskaydia > /dev/null; then
        echo -e "Caskaydia Cove Nerd font is already installed...\n"
    else
        # Install Nerd Font
        download_nerd_font
        unzip_nerd_font
        update_fonts_dir
    fi
    
    log_and_pause
}

## --------------------------------------------------------------------------
# Function to download Nerd Font for Starship preset
download_nerd_font() {
    echo "Downloading CascadiaCode Nerd Font for Preset..."
    log_and_pause

    wget -N https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip -P ~
    log_and_pause
}

## --------------------------------------------------------------------------
# Function to download Nerd Font for Starship preset
unzip_nerd_font() {
    echo "Unzipping CascadiaCode.zip..."
    log_and_pause

    mkdir ~/CascadiaCode
    unzip ~/CascadiaCode.zip -d ~/CascadiaCode
    log_and_pause
}

## --------------------------------------------------------------------------
# Function to download Nerd Font for Starship preset
update_fonts_dir() {
    echo -e "\nUpdating ~/.local/share/fonts/ directory..."
    log_and_pause

    mv ~/CascadiaCode/*.ttf ~/.local/share/fonts/

    echo "Done!"

    rm -r ~/CascadiaCode.zip
    rm -rf ~/CascadiaCode
}

## --------------------------------------------------------------------------
# Function to download Nerd Font for Starship preset
update_font_cache() {
    if [ "$font_cache" = "1" ]; then
        # Update the font cache
        echo "Updating font cache..."
        log_and_pause

        fc-cache -f -v
        log_and_pause
        sleep 1

        echo -e "\nInstallation Completed."
        log_and_pause
    fi
}

## --------------------------------------------------------------------------
# Function to set the font in the terminal
# set_terminal_font() {
    # echo "Setting the font in the terminal..."
    # Instructions for setting the font in the terminal
    # (This step may vary depending on the terminal emulator)
# }


### ===========================================================================
## Main function to execute all the steps
#

main() {
    set -e  # Exit script if any command returns a non-zero status

    clear

    # Assigning font_cache variable
    font_cache=0

    sudo echo -e "\n------- Automated Starship Installation Script -------"
    log_and_pause

    install_dependencies
    install_starship
    setup_starship_config
    confirm_bashrc
    confirm_fish
    confirm_zshrc
    check_caskaydia_font
    update_font_cache

    echo -e "\nStarship Installation Successfull!!!\n\n\n----- SUCCESS -----\n\n"

    read -n 1 -s -r -p "Press any key to Exit..."
    sleep 0.5
}

# Execute the main function
main
