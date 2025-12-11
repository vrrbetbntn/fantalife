#!/bin/bash
# Script to get SHA-256 fingerprint for Android
# Run: chmod +x get-sha256.sh && ./get-sha256.sh

echo "Getting SHA-256 fingerprint from debug keystore..."
echo ""

KEYSTORE_PATH="$HOME/.android/debug.keystore"

if [ -f "$KEYSTORE_PATH" ]; then
    keytool -list -v -keystore "$KEYSTORE_PATH" -alias androiddebugkey -storepass android -keypass android | grep SHA256
    echo ""
    echo "Copy the SHA-256 value above and paste it into:"
    echo "public/.well-known/assetlinks.json"
else
    echo "Debug keystore not found at: $KEYSTORE_PATH"
    echo "Make sure you've built at least one Android app."
fi

