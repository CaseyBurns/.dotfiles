#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo"
    exit 1
fi

# Define list of packages in an array
PACKAGES=(
    "python3"
    "python3-pip"
    "git"
    "curl"
    "stow"
    "zip"
    "bat"
    "zoxide"
)

# Log file
LOG_FILE="/var/log/package_install_$(date +%Y%m%d_%H%M%S).log"

# Function to log messages
log_message() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1" | tee -a "$LOG_FILE"
}

# Update package list
log_message "Updating package list..."
apt update -y 2>> "$LOG_FILE"
if [ $? -ne 0 ]; then
    log_message "Failed to update package list"
    exit 1
fi

# Function to install a single package
install_package() {
    local package=$1
    log_message "Checking/Installing $package..."
    
    # Check if package is already installed
    if dpkg -l | grep -q "^ii  $package "; then
        log_message "$package is already installed"
        # Check for updates
        apt install --only-upgrade -y "$package" 2>> "$LOG_FILE"
        if [ $? -eq 0 ]; then
            log_message "$package updated successfully"
        else
            log_message "Failed to update $package"
        fi
    else
        # Install package if not present
        apt install -y "$package" 2>> "$LOG_FILE"
        if [ $? -eq 0 ]; then
            log_message "$package installed successfully"
            # Verify installation
            installed_version=$(dpkg -l "$package" | grep "^ii" | awk '{print $3}')
            log_message "$package version: $installed_version"
        else
            log_message "Failed to install $package"
        fi
    fi
}

# Main installation loop
for package in "${PACKAGES[@]}"; do
    install_package "$package"
done

# Clean up
log_message "Cleaning up apt cache..."
apt autoremove -y 2>> "$LOG_FILE"
apt autoclean 2>> "$LOG_FILE"

log_message "Package installation process completed"

# Display installed versions
log_message "Currently installed versions:"
dpkg -l "${PACKAGES[@]}" 2>/dev/null | grep "^ii" | awk '{print $2 " " $3}' | tee -a "$LOG_FILE"
