# Simple Wayland Clipboard Image Optimizer

This tool optimizes images from your Wayland clipboard, reducing their file size while maintaining quality. It's designed to be quick and easy to use. This is just a quickly made project of mine. I don't plan on adding any other features unless I run into something I absolutely need. This is mostly just in spite of the Discord 10mb image limit.

## Features

- Optimizes images directly from your Wayland clipboard
- Automatically detects and preserves the original image format
- Resizes large images (max 1920x1080) while maintaining aspect ratio
- Strips metadata to further reduce file size
- Provides desktop notifications for feedback
- Easy to use via command line or desktop environment (e.g., Rofi)

## Prerequisites

Ensure you have the following installed on your system:

- `wl-clipboard` (for Wayland clipboard operations)
- `ImageMagick` (for image manipulation)
- `dunst` and `libnotify` (for desktop notifications)


```bash
yay -S wl-clipboard imagemagick dunst libnotify
```

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/kettukaa/simple-wayland-clipboard-image-optimizer.git
   cd simple-wayland-clipboard-image-optimizer
   ```

2. Move the script to `/usr/local/bin/` and make it executable:

   ```bash
   sudo mv optimize-clipboard-image.sh /usr/local/bin/optimize-clipboard-image.sh
   sudo chmod +x /usr/local/bin/optimize-clipboard-image.sh
   ```

3. Create the applications directory if it doesn't exist and move the desktop file:

   ```bash
   mkdir -p ~/.local/share/applications
   mv optimize-clipboard-image.desktop ~/.local/share/applications/
   ```

4. Make the desktop file executable:

   ```bash
   chmod +x ~/.local/share/applications/optimize-clipboard-image.desktop
   ```

## Usage

### Via Command Line

Simply run the script:

```bash
optimize-clipboard-image.sh
```

### Via Desktop Environment

You can now find and run "Optimize Clipboard Image" from your application launcher or Rofi.
