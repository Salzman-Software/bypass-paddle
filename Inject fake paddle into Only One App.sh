#!/bin/bash

# Path to the Paddle override dylib (same directory as the script)
LIBRARY_PATH="$(dirname "$0")/libPaddleOverride.dylib"

# Check if the dylib exists
if [ ! -f "$LIBRARY_PATH" ]; then
  echo "Error: libPaddleOverride.dylib not found at $LIBRARY_PATH"
  exit 1
fi

# Check if an application was dragged to the terminal
if [ $# -eq 0 ]; then
  echo "No input argument. Drag this script into the terminal and the app to modify."
  exit 1
fi

# Function to inject dylib into an app
inject_dylib() {
  local app_path="$1"
  echo "Injecting libPaddleOverride.dylib into $app_path..."

  # Set the DYLD_INSERT_LIBRARIES variable and launch the app
  export DYLD_INSERT_LIBRARIES="$LIBRARY_PATH"
  open "$app_path"
}

# Get the application path from the dragged argument
app_path="$1"

# Check if the app contains Paddle.framework
if [ -d "$app_path/Contents/Frameworks/Paddle.framework" ]; then
  echo "Found Paddle in $app_path"
  inject_dylib "$app_path"
else
  echo "No Paddle framework found in $app_path"
fi

echo "Injection completed for the provided app."
