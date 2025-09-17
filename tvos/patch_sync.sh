#!/bin/sh

FILE_FOR_PATCH_RN="./node_modules/react-native/Libraries/BatchedBridge/MessageQueue.js"

if [ -z "$FILE_FOR_PATCH_RN" ]; then
  echo "❌ Please provide a file path."
  echo "Usage: $0 path/to/file.js"
  exit 1
fi

if [ ! -f "$FILE_FOR_PATCH_RN" ]; then
  echo "❌ File not found: $FILE_FOR_PATCH_RN"
  exit 1
fi

# Use sed to replace the entire method (single-line form)
sed -i '' 's|callNativeSyncHook( moduleID: number, methodID: number, params: mixed\[\], onFail: \?\(...mixed\[\]\) => void, onSucc: \?\(...mixed\[\]\) => void, ): mixed { if (__DEV__) { invariant( global.nativeCallSyncHook, '\''Calling synchronous methods on native '\'' + '\''modules is not supported in Chrome.\\n\\n Consider providing alternative '\'' + '\''methods to expose this method in debug mode, e.g. by exposing constants '\'' + '\''ahead-of-time.'\'', ); } this.processCallbacks(moduleID, methodID, params, onFail, onSucc); return global.nativeCallSyncHook(moduleID, methodID, params); }|callNativeSyncHook( moduleID: number, methodID: number, params: mixed[], onFail: ?(...mixed[]) => void, onSucc: ?(...mixed[]) => void, ): mixed { this.processCallbacks(moduleID, methodID, params, onFail, onSucc); if(global.nativeCallSyncHook) { return global.nativeCallSyncHook(moduleID, methodID, params); } }|' "$FILE"

echo "✅ Replaced callNativeSyncHook method in $FILE_FOR_PATCH_RN"
