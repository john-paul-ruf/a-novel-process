#!/bin/bash
set -e

cd "$(dirname "$0")/.."

TNRB="/System/Library/Fonts/Supplemental/Times New Roman Bold.ttf"
TNR="/System/Library/Fonts/Supplemental/Times New Roman.ttf"
GBI="/System/Library/Fonts/Supplemental/Georgia Bold Italic.ttf"

# Customize this ImageMagick command for your cover design.
# Requires: assets/cover-art.jpg as source image
# Outputs:  assets/cover.jpg

if [ ! -f "assets/cover-art.jpg" ]; then
  echo "⚠ No assets/cover-art.jpg found. Add cover art and customize this script."
  exit 1
fi

magick assets/cover-art.jpg \
  -resize 1600x2384\! \
  -quality 95 assets/cover.jpg

echo "✓ Cover built: assets/cover.jpg"
