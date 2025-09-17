#!/bin/bash

FILE="./packages/quick-brick-core/App/index.tsx"

if [ -z "$FILE" ]; then
  echo "❌ Please provide a file path."
  echo "Usage: $0 path/to/file.js"
  exit 1
fi

if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

# Temporary file
TMP_FILE=$(mktemp)

# Add new lines on top
cat <<'EOF' > "$TMP_FILE"
// Disable logs popups(RN68,RN77)
import { LogBox } from "react-native";
LogBox.ignoreAllLogs();

EOF

# Append original content
cat "$FILE" >> "$TMP_FILE"

# Replace original file
mv "$TMP_FILE" "$FILE"

echo "✅ Added LogBox ignore code to top of $FILE"
