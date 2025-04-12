#!/bin/bash

# Path to the Paddle override dylib (same directory as the script)
LIBRARY_PATH="$(dirname "$0")/libPaddleOverride.dylib"

# Check if the dylib exists
if [ ! -f "$LIBRARY_PATH" ]; then
  echo "Error: libPaddleOverride.dylib not found at $LIBRARY_PATH"
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

# Loop through all applications in /Applications
for app in /Applications/*.app; do
  # Check if the app contains Paddle.framework
  if [ -d "$app/Contents/Frameworks/Paddle.framework" ]; then
    echo "Found Paddle in $app"
    inject_dylib "$app"
  else
    echo "No Paddle framework found in $app"
  fi
done

echo "Injection completed for all applicable apps."
