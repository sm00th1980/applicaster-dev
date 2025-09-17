#!/bin/sh

FILE="./packages/zapp-react-native-tvos-app/InteractionManager/index.ts"

if [ -z "$FILE" ]; then
  echo "❌ Please provide a file path."
  echo "Usage: $0 path/to/file.js"
  exit 1
fi

if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

# Replace line in place
sed -i.bak 's/const IS_DEBUGGER_ENABLED = false;/const IS_DEBUGGER_ENABLED = true;/' "$FILE"

echo "✅ Updated debugger flag in $FILE (backup saved as $FILE.bak)"
