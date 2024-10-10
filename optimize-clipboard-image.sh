#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to send notification
send_notification() {
    if command_exists dunstify; then
        dunstify -a "Image Optimizer" "$1" "$2"
    else
        echo "$1: $2"
    fi
}

# Check for required commands
for cmd in wl-paste wl-copy convert identify dunstify; do
    if ! command_exists "$cmd"; then
        send_notification "Error" "$cmd is not installed. Please install it and try again."
        exit 1
    fi
done

# Send start notification
send_notification "Image Optimization" "Starting image optimization..."

# Create a temporary directory
temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

# Get image from clipboard
input_file="$temp_dir/input_image.png"
if ! wl-paste > "$input_file"; then
    send_notification "Error" "Failed to get image from clipboard."
    exit 1
fi

# Check if the input is an image using ImageMagick's identify
if ! identify "$input_file" >/dev/null 2>&1; then
    send_notification "Error" "Clipboard does not contain a valid image."
    exit 1
fi

# Get the actual image format
format=$(identify -format "%m" "$input_file")
echo "Detected image format: $format"

# Optimize the image
output_file="$temp_dir/optimized_image.$format"
if ! convert "$input_file" -strip -quality 85 -resize '1920x1080>' "$output_file"; then
    send_notification "Error" "Image optimization failed."
    exit 1
fi

# Check if optimization was successful
if [ ! -f "$output_file" ]; then
    send_notification "Error" "Optimized image file not found."
    exit 1
fi

# Put optimized image back into clipboard
if ! wl-copy < "$output_file"; then
    send_notification "Error" "Failed to copy optimized image to clipboard."
    exit 1
fi

# Send success notification
send_notification "Image Optimization" "Image optimized and copied to clipboard successfully."
