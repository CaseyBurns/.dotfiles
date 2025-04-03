#!/bin/bash

# Check if running as root (optional warning)
if [ "$EUID" -eq 0 ]; then
    echo "Running as root. Installing system-wide is not recommended for fonts."
    echo "Continuing with user-level installation."
fi

# Define variables
FONT_DIR="${HOME}/.local/share/fonts"
TEMP_DIR="/tmp/fonts_install_$$"  # Unique temp dir using process ID
DOWNLOADS=()

# List of fonts to install (name, source URL, optional unzip path)
# Format: "name|URL|unzip_path"
FONT_LIST=(
    "FiraCode|https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip|"
    "Meslo|https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip"
)

# Ensure required tools are installed
echo "Checking dependencies..."
for tool in curl unzip fc-cache; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Installing $tool..."
        sudo apt update
        sudo apt install -y "$tool"
    fi
done

# Create directories
echo "Setting up directories..."
mkdir -p "$FONT_DIR" "$TEMP_DIR"
cd "$TEMP_DIR" || {
    echo "Failed to access temp directory"
    exit 1
}

# Function to install a font
install_font() {
    local font_entry="$1"
    IFS='|' read -r name url unzip_path <<< "$font_entry"
    
    echo "Processing $name..."

    if [ "$url" = "APT" ]; then
        # Install via APT
        echo "Installing $name via APT..."
        sudo apt install -y "$unzip_path"  # unzip_path is the package name here
        if [ $? -eq 0 ]; then
            echo "$name installed successfully via APT"
        else
            echo "Failed to install $name via APT"
        fi
    else
        # Download and install from URL
        local zip_file="${name}.zip"
        echo "Downloading $name from $url..."
        curl -L -o "$zip_file" "$url"
        if [ $? -ne 0 ]; then
            echo "Failed to download $name"
            return 1
        fi

        echo "Extracting $name..."
        unzip -o -q "$zip_file" -d "$name"
        if [ $? -ne 0 ]; then
            echo "Failed to extract $name"
            return 1
        fi

        # Move .ttf files to font directory
        if [ -n "$unzip_path" ]; then
            find "$name/$unzip_path" -name "*.ttf" -exec mv {} "$FONT_DIR/" \;
        else
            find "$name" -name "*.ttf" -exec mv {} "$FONT_DIR/" \;
        fi

        if [ $? -eq 0 ]; then
            echo "$name installed successfully"
            DOWNLOADS+=("$zip_file")
        else
            echo "Failed to install $name fonts"
        fi
    fi
}

# Install each font in the list
for font in "${FONT_LIST[@]}"; do
    install_font "$font"
done

# Clean up
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

# Update font cache
echo "Updating font cache..."
fc-cache -f
if [ $? -eq 0 ]; then
    echo "Font cache updated successfully"
else
    echo "Failed to update font cache"
    exit 1
fi

echo "Font installation complete!"
echo "Installed fonts are now available in your applications."