#!/bin/bash

# Load config variables
source /app/config.env

# Set default values if variables are not set
VIDEO_LENGTH=${VIDEO_LENGTH:-60}  # Recording length in seconds
VIDEO_RESOLUTION=${VIDEO_RESOLUTION:-"1920x1080"}
VIDEO_DEVICE=${VIDEO_DEVICE:-"/dev/video0"}
FRAMERATE=${FRAMERATE:-30}
#OUTPUT_DIR="/app/videos"
FILENAME="pelusacam_$(date +%Y%m%d_%H%M%S).mp4"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Mount the SD card
SDCARD_MOUNT="/mnt/sdcard"
if ! mount | grep -q "$SDCARD_MOUNT"; then
    echo "Mounting SD card..."
    mkdir -p "$SDCARD_MOUNT"
    mount /dev/mmcblk0p1 "$SDCARD_MOUNT"
fi

# Check if mount was successful
if ! mount | grep -q "$SDCARD_MOUNT"; then
    echo "Error: SD card mount failed!"
    exit 1
fi

echo "Starting video capture..."
ffmpeg -f v4l2 -framerate "$FRAMERATE" -video_size "$VIDEO_RESOLUTION" -input_format h264 -i "$VIDEO_DEVICE" \
       -f alsa -i hw:0 -c:v copy -c:a aac -b:a 128k -t "$VIDEO_LENGTH" "$SDCARD_MOUNT/$FILENAME"


#echo "Uploading to Azure..."
#azcopy copy "$FULL_PATH" "https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_CONTAINER}/$FILENAME" --account-key "$AZURE_STORAGE_KEY"

#echo "Cleanup: Removing local file"
#rm "$FULL_PATH"

echo "Process completed!"
while true; do
    echo "Waiting for the next cycle..."
    sleep 120;
done