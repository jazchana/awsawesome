#!/bin/bash

# Set up variables
BUILD_DIR="build"
FINAL_SCRIPT="$BUILD_DIR/aws-helper-functions.sh"

# Create build directory
mkdir -p "$BUILD_DIR"

# Start with a clean file
echo "#!/bin/bash" > "$FINAL_SCRIPT"
echo "" >> "$FINAL_SCRIPT"

# Combine function files
for f in src/functions/*.sh; do
    echo "# $(basename "$f")" >> "$FINAL_SCRIPT"
    cat "$f" >> "$FINAL_SCRIPT"
    echo "" >> "$FINAL_SCRIPT"
done

# Add main script (without the sourcing part)
sed '/^# Source helper functions/,/^done$/d' src/aws-helper-functions.sh >> "$FINAL_SCRIPT"

# Make executable
chmod +x "$FINAL_SCRIPT"

echo "Built combined script at $FINAL_SCRIPT"