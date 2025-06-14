#!/bin/bash

# Load config variables
source /app/config.env

# Set default values if variables are not set
VIDEO_LENGTH=${VIDEO_LENGTH:-60}  # Recording length in seconds
VIDEO_RESOLUTION=${VIDEO_RESOLUTION:-"1920x1080"}
FRAMERATE=${FRAMERATE:-30}
OUTPUT_DIR="/app/videos"
FILENAME="pelusacam_$(date +%Y%m%d_%H%M%S).mp4"
FULL_PATH="$OUTPUT_DIR/$FILENAME"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

echo "Starting video capture..."
ffmpeg -f v4l2 -i /dev/video0 -f alsa -i hw:1 \
       -t "$VIDEO_LENGTH" -r "$FRAMERATE" -s "$VIDEO_RESOLUTION" \
       -c:v libx264 -preset fast -c:a aac -strict experimental "$FULL_PATH"

echo "Uploading to Azure..."
azcopy copy "$FULL_PATH" "https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_CONTAINER}/$FILENAME" --account-key "$AZURE_STORAGE_KEY"

echo "Cleanup: Removing local file"
rm "$FULL_PATH"

echo "Process completed!"
